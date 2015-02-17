<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Logistic extends CI_Controller {

	function __construct() {
        parent::__construct();
		$this->load->model('Logistics_model');
		$this->load->helper('form');
    }
	function create_stock(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(0);
		if($this->input->post('stock_name_id')){
			$data=$_POST;
			if($this->input->post('stock_id')){
				$this->Logistics_model->update($data);
			} else {
				$this->Logistics_model->save($data);
			}
			redirect('logistic/stock_list');
		}
		$data=array();
		$data = $this->Logistics_model->get_stock_data($this->input->get('r'));
		$data['group_options']=$this->Logistics_model->get_groups();
		$data['stock_names']=$this->Logistics_model->get_names();
		$data['units']=$this->Logistics_model->stock_units;
		$this->load->view('create_stock', $data);
	}

	function create_stock_name(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(0);
		if($this->input->post('stock_name')){
			$data=$_POST;
			if($this->Logistics_model->save_stock_name($data)) redirect('logistic/stock_name_list/');
		}
		if($this->input->get('r')) $data=$this->Logistics_model->get_stock_names($this->input->get('r'));
		$this->load->view('stock_name', $data);
	}


	function stock_name_list(){
		error_reporting(E_ALL);
		error_reporting(0);
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='stock_names';
		//$this->List_model->hidden_column=array('quotation_status_id','quotation_id');
		$this->List_model->list_title=' Master SKU Names';
		$this->List_model->search=array('stock_name' );
		//$this->List_model->order_by='stock_id';
		$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/logistic/create_stock_name/?r=',
					'key'=>'stock_name_id',
					'extra'=>''
				)
			);
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
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




}                                                                                                                

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */