<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Mo extends CI_Controller {

	function __construct() {
        parent::__construct();
		$this->load->model('Mcs_model');
		$this->load->model('Inventory_model');
    }
	
	function create_mo(){
		error_reporting(0);
		//		error_reporting(E_ALL);

		$this->load->model('Quotations_model');
		$this->load->model('Etc_model');
		$this->load->helper('form');
		$this->Quotations_model->quotation_id=$this->input->get('r34scrt8');
		$data=$this->Quotations_model->get_header();
		$data['customers']=$this->Etc_model->customers();
		$data['events']=$this->Etc_model->events();
		$data['users']=$this->Etc_model->users();
		$data['venues']=$this->Etc_model->venues();
		$data['columns']=$this->Inventory_model->columns();
		
			//	print_r($data);

		$this->load->view('inventory_form', $data);
	}
	
	function new_mo(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(E_ALL);
		error_reporting(0);
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='active_sales';
		$this->List_model->hidden_column=array('quotation_status_id','quotation_id');
		$this->List_model->list_title=' select Project for MO';
		$this->List_model->search=array('event_name','customer_name');
		//$this->List_model->order_by='';
		$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/mo/create_mo/?r34scrt8=',
					'key'=>'quotation_id',
					'extra'=>''
				)
			);
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
	}
}	