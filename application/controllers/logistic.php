<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Logistic extends CI_Controller {

	function __construct() {
        parent::__construct();
		$this->load->model('Logistics_model');
		$this->load->helper('form');
    }

	function stock_list(){
		error_reporting(E_ALL);
		error_reporting(0);
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='v_stacks';
		//$this->List_model->hidden_column=array('quotation_status_id','quotation_id');
		$this->List_model->list_title=' Master Materials';
		$this->List_model->search=array('stock_name','group_name');
		$this->List_model->order_by='stock_id';
		$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/logistic/create_stock/?r=',
					'key'=>'stock_id',
					'extra'=>''
				)
			);
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
	}


	function create_stock(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(E_ALL);
		if($this->input->post('stock_name_id')){
			$data=$_POST;
			$this->Logistics_model->update($data);
			redirect('logistic/stock_list');
		}
		$data=array();
		$data = $this->Logistics_model->get_stock_data($this->input->get('r'));
		$data['group_options']=$this->Logistics_model->get_groups();
		$data['stock_names']=$this->Logistics_model->get_names();
		$this->load->view('create_stock', $data);
	}

	function xstock_list(){
		if(!$this->session->userdata('userid')) redirect('welcome');

		error_reporting(0);
		error_reporting(E_ALL);
		$data=array();
		$this->load->model('Logistics_model');
		
		$data['kunci']='stock_id';
		$data['list_titla']="Master Stocks List";
		$data['open_url']=base_url().index_page().'/logistic/create_stock';
		$data['delete_url']=base_url().index_page().'/logistic/delete_stock';
		$data['data']=$this->Logistics_model->get_all();
		$this->load->view('list', $data);
	}



}                                                                                                                

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */