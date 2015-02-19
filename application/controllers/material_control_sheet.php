<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Material_control_sheet extends CI_Controller {

	function __construct() {
        parent::__construct();
		$this->load->model('Mcs_model');
    }

	public function index()
	{
		return $this->active_project_list();
	}
	
	function active_project_list(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(E_ALL);
		error_reporting(0);
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='active_sales';
		$this->List_model->hidden_column=array('quotation_status_id','quotation_id');
		$this->List_model->list_title=' select Project for MCS';
		$this->List_model->search=array('event_name','customer_name');
		//$this->List_model->order_by='';
		$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/material_control_sheet/create_mcs/?r34scrt8=',
					'key'=>'quotation_id',
					'extra'=>''
				)
			);
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
	}
	
	function mcs_list(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(E_ALL);
		error_reporting(0);
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='v_mcs_list1';
		$this->List_model->hidden_column=array('mcs_status_id','mcs_id');
		$this->List_model->list_title=' MCSs ';
		$this->List_model->search=array('mcs_number','event_name','customer_name');
		//$this->List_model->order_by='';
		$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/material_control_sheet/create_mcs/?ifhak=',
					'key'=>'mcs_id',
					'extra'=>''
				)
			);
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
	}

	
	
	public function create_mcs(){
		$this->output->enable_profiler(TRUE);
		error_reporting(0); // thats why error_reporting(0) is invented :D
		//error_reporting(E_ALL);
		if(!$this->session->userdata('userid')) redirect('welcome');
		$this->load->helper('form');
		$this->load->model('Quotations_model');
		$data=array();
		$customers = $this->db->query("select customer_id, customer_name from customers")->result_array();
		foreach($customers as $i){
			$customers2[$i['customer_id']]=$i['customer_name'];
		}
		$data['customers']=$customers2;

		$events = $this->db->query("select event_id, event_name from events")->result_array();
		foreach($events as $i){
			$events2[$i['event_id']]=$i['event_name'];
		}
		$data['events']=$events2;

		$venues = $this->db->query("select venue_id, venue_name from venues")->result_array();
		foreach($venues as $i){
			$venues2[$i['venue_id']]=$i['venue_name'];
		}
		$data['venues']=$venues2;		

		$users = $this->db->query("select user_id, username from users")->result_array();
		foreach($users as $i){
			$users2[$i['user_id']]=$i['username'];
		}
		$data['users']=$users2;		
		
		$stocks2=$this->db->get('v_stocks')->result_array();
		foreach($stocks2 as $stocks3){
			$stocks[$stocks3['stock_id']]=$stocks3['stock_name'];
		}
		$data['stocks']=$stocks;
		
		$this->db->order_by('group_id');
		$sgroups2=$this->db->get('stock_groups')->result_array();
		foreach($sgroups2 as $sgroups3){
			$sgroups[$sgroups3['group_id']]=$sgroups3['group_name'];
		}
		$data['sgroups']=$sgroups;
		
		
		// save
		if($this->input->post('i')){
			$mcsdata=$_POST;
			unset($mcsdata['i']);
			$this->Mcs_model->mcs_id=$this->input->post('mcs_id');
			$res = $this->Mcs_model->save_header($mcsdata);
			foreach($this->input->post('i') as $m){
				if(!empty($m['qty'])) $this->Mcs_model->save_item($m);
			}
		}//end save

		//mcs data
		if($this->input->get('ifhak')) $this->Mcs_model->mcs_id=$this->input->get('ifhak');
		foreach($this->Mcs_model->get_header() as $k=>$i){
			$data[$k]=$i;
		}
		$mir=$this->Mcs_model->get_items();
		if(empty($mir)) {
			$mir=array(1,2,3,4,5,6,7,8,9);//quotation item rows
		} else {
			for($i=0;$i<=(9-count($mir));$i++){
				array_push($mir,1);
			}
		}
		$data['mir']=$mir;
		
		// sales data getter
		if( $this->input->get('r34scrt8') ){
			$this->Quotations_model->quotation_id=$this->input->get('r34scrt8');
		} else {
			$this->Quotations_model->quotation_id=$data['quotation_id'];
		}
		
		$qdata2=$this->Quotations_model->get_header();
		foreach($qdata2 as $k=>$i){
			$data[$k]=$i;
		}
		$data['files']=$this->Quotations_model->quotation_files();;
		
		$this->load->view('mcs', $data);
	}

	
	function send_mcs(){
		if($this->input->get('one')){
			$this->Mcs_model->mcs_id=$this->input->get('one');
			$this->Mcs_model->send();
		}
		redirect('material_control_sheet/mcs_list');
	}
	

	function delete_mcs(){
		if($this->input->get('one')){
			$this->Mcs_model->mcs_id=$this->input->get('one');
			$this->Mcs_model->delete();
		}
		redirect('material_control_sheet/mcs_list');
	}
	
	public function sales_list(){
		$pj=$this->db->get_where('v_quotation', array('status'=>5))->result_array();
		$data['kunci']='user_id';
		$data['list_titla']="User List";
		$data['open_url']=base_url().index_page().'/administrator/create_user';
		$data['delete_url']=base_url().index_page().'/administrator/delete_user';
		$data['data'] = $this->Users_model->get_all();

		$this->load->view('list', $data);	}
	
	
	function _getQuoatationDataHeader($quotation_id){
			//$quotation_id = $this->input->get('r34scrt8');
			$this->db->query('SET datestyle TO "DMY, DMY"');
			$qdata2 = $this->db->get_where('v_quotation', array('quotation_id'=>$quotation_id))->result_array();
			//$data['qdata']=$qdata2[0];
			foreach($qdata2[0] as $k=>$i){
				$data[$k]=$i;
			}
			$qprdcs = $this->db->get_where('quotation_products', array('quotation_id'=>$quotation_id))->result_array();
			$qf =  $this->db->get_where('quotation_files', array('quotation_id'=>$quotation_id))->result_array();
			array_push($qprdcs,1);
			array_push($qprdcs,1);
			array_push($qprdcs,1);

			$data['qir']=$qprdcs;
			$data['files']=$qf;
			return $data;
	}
	
	public function manage_mcs(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		$data=array();
		$this->load->view('quotation_form', $data);
	}

	function quotation_list(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		$data=array();
		$data['q'] = $this->db->get('quotation_list1')->result_array();
		$this->load->view('quotation_list', $data);
	}
	
	public function delete_file(){
	
	}
	
	public function download_file(){
		$file_id=$this->input->get('xol');
		$df = $this->db->get_where('quotation_files', array('quotation_files_id'=>$file_id))->row_array();
		echo file_get_contents( 'berkas/'.$df['file_name'] );
	}
	
	public function do_upload($quotation_id='', $file_id='')
	{
		$config['upload_path'] = 'berkas/';
		$config['allowed_types'] = 'gif|jpg|png|pdf';
		$config['file_name']= 'qf_'.$quotation_id.'_'.$file_id.'_'.$_FILES['userfile']['name'];
		$config['max_size']	= '100';
		//$config['max_width']  = '1024';
		//$config['max_height']  = '768';
		$this->load->library('upload', $config);
		if ( ! $this->upload->do_upload())
		{
			return array(
				'error',
				$this->upload->display_errors()
				);
		}
		else
		{
			return array('success', $this->upload->data());
		}
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */