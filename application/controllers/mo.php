<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Mo extends CI_Controller {

	function __construct() {
        parent::__construct();
		if(!$this->session->userdata('userid')) redirect('welcome');

		$this->load->model('Mcs_model');
		$this->load->model('Inventory_model');
		$this->Inventory_model->transaction_type_id=2;

    }
	
	function delete(){
		$this->Inventory_model->mcs_id=$this->input->get('one');
		$this->Inventory_model->delete();
		redirect('mo/manage');
	}

	function send_mo(){
		$this->Inventory_model->mcs_id=$this->input->get('one');
		$this->Inventory_model->send();
		redirect('mo/manage');
	}

	
	function create_mo(){
		error_reporting(0);
				//$this->output->enable_profiler(TRUE);

		if($this->input->post('quotation_id')) {
			$data=$_POST;
			unset($data['i']);
			if($this->input->post('mcs_id')){
				$this->Inventory_model->mcs_id=$this->input->post('mcs_id');
			}
			$this->Inventory_model->save_header($data);
			foreach($this->input->post('i') as $i){
				if(!empty($i['qty'])) $this->Inventory_model->save_item($i);
			}
			$this->Inventory_model->mcs_id=$this->input->post('mcs_id');
			redirect('mo/manage');
			//print_r($this->Inventory_model);
		} 
		$this->load->helper('form');
		if($this->input->get('anse')){
			$this->Inventory_model->mcs_id=$this->input->get('anse');
		} else {
			$this->Inventory_model->quotation_id=$this->input->get('r34scrt8');
		}
		$data = $this->Inventory_model->keder();
					//print_r($this->Inventory_model);
		$this->load->view('inventory_form', $data);
	}

	function manage(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(E_ALL);
		error_reporting(0);
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='mo';
		$this->List_model->hidden_column=array('mcs_status_id','mcs_id');
		$this->List_model->list_title=' Material Order';
		$this->List_model->search=array('event_name');
		//$this->List_model->order_by='';
		$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/mo/create_mo/?anse=',
					'key'=>'mcs_id',
					'extra'=>''
				)
			);
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
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