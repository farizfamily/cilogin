<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Quotation extends CI_Controller {

	public function index()
	{
	}
	
	function delete_quotation(){
		$this->db->where("quotation_id", $this->input->get('r34scrt8'));
		$this->db->delete("quotations");
		redirect('quotation/quotation_list');
	}
	
	public function create_quotation(){
		//$this->output->enable_profiler(TRUE);
		error_reporting(0); // thats why error_reporting(0) is invented :D
		if(!$this->session->userdata('userid')) redirect('welcome');
		$this->load->helper('form');
		$data=array();
		$data['qir']=array(1,2,3,4,5,6,7);//quotation item rows
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

		
		//save edit
		if($this->input->post('quotation_id')){
			$qdata=$_POST;
			unset($qdata['f']);
			unset($qdata['description']);
			foreach($qdata as $k=>$i){
				if(empty($i)) {
					unset($qdata[$k]);
				}	
			}
			if(!isset($qdata['official'])) $qdata['official']='f';
			$this->db->where('quotation_id', $this->input->post('quotation_id'));
			$this->db->update('quotations', $qdata);
			
			foreach($this->input->post('f') as $qp){
				//print_r($qp);
				if(!empty($qp['quotation_product_id'])) {
					$this->db->where('quotation_product_id', $qp['quotation_product_id']);
					$this->db->update('quotation_products', $qp);
				}	else {
					if(!empty($qp['amount'])) {
						unset($qp['quotation_product_id']);
						$qp['quotation_id']=$this->input->post('quotation_id')	;
						$this->db->insert('quotation_products', $qp);
					}	
				}
			}
			$file_id2 = $this->db->query("select max(quotation_files_id) as id from quotation_files")->row_array();
			$file_id = $file_id2['id']+1;
			$res = $this->do_upload( $this->input->post('quotation_id'), $file_id );
			//print_r($res);
			if($res[0]=='success'){
				$qfd['quotation_files_id']=$file_id;
				$qfd['quotation_id']=$this->input->post('quotation_id');
				$qfd['file_name']=$res[1]['file_name'];
				$qfd['description']=$this->input->post('description');
				$this->db->insert('quotation_files', $qfd);
			} else {
				print_r($res);
			}
			//$dataj = $this->_getQuoatationData($this->input->post('quotation_id'));
			//return $this->load->view('quotation_form', $data); 
			redirect('quotation/create_quotation?r34scrt8='.$this->input->post('quotation_id'));
		}
		// -- ngek ngok save edit
		
		// save
		if($this->input->post('f')){
			$qdata=$_POST;
			unset($qdata['f']);
			$quotation_id2 = $this->db->query("select max(quotation_id) as quotation_id from quotations")->result_array();
			$quotation_id = $quotation_id2[0]['quotation_id']+1;
			$qdata['quotation_id']=$quotation_id;
			//print_r($qdata);
			foreach($qdata as $k=>$i){
				if(empty($i)) unset($qdata[$k]);
			}
			$this->load->helper('general');
			$qdata['quotation_number'] = quotation_number($quotation_id);
			$qdata['revision']=0;
			$qdata['status']=0;
			$this->db->insert('quotations', $qdata);
			foreach($this->input->post('f') as $qp){
				foreach($qp as $k=>$i){
					if(empty($i)) {
						unset($qp[$k]);
					}
				}
				if(!empty($qp)) {
					$qp['quotation_id']=$quotation_id;
					$this->db->insert('quotation_products', $qp);
				}	
			}
			redirect('quotation/create_quotation?r34scrt8='.$quotation_id);
		}//end save
		
		//edit
		if($this->input->get('r34scrt8')){
			$quotation_id = $this->input->get('r34scrt8');
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
		}// end edit

		
		$this->load->view('quotation_form', $data);
	}

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
	
	public function manage_quotation(){
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