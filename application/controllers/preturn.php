<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Preturn extends CI_Controller {

	function __construct() {
        parent::__construct();
		if(!$this->session->userdata('userid')) redirect('welcome');

		//$this->load->model('Mcs_model');
		$this->load->model('Inventory_model');
		$this->Inventory_model->transaction_type_id=5;
		
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

	
	function purchase_return(){
		error_reporting(0);
		$this->output->enable_profiler(TRUE);
		//$this->Inventory_model->turn_on_unit_price=true;
		if($this->input->post('mcs_date')) {
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
			redirect('preturn/prt_list');
			print_r($this->Inventory_model);
		} 
		
		$this->load->helper('form');

		
		if($this->input->get('anse')){
			$this->Inventory_model->ref_id=$this->input->get('anse');
		}
		if($this->input->get('r34scrt8')){
			$this->Inventory_model->mcs_id=$this->input->get('r34scrt8');
		}
		
		
		$data = $this->Inventory_model->keder();
		
		$data['pos']= $this->Inventory_model->po_options(4);
					
		$this->load->view('inventory_form', $data);
	}

	function active_po_list(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(E_ALL);
		error_reporting(0);
		
		//open receipt
		if($this->input->get('anse')){
			return $this->new_pr();
		}
		
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='aktiv_po';
		$this->List_model->hidden_column=array('mcs_status_id','mcs_id');
		$this->List_model->list_title='   Purchase Order';
		$this->List_model->search=array('supplier_name');
		//$this->List_model->order_by='';
		/*$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/pr/new_pr/?anse=',
					'key'=>'mcs_id',
					'extra'=>''
				)
			);
			*/
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
	}

	
	function prt_list(){
		if(!$this->session->userdata('userid')) redirect('welcome');
		error_reporting(E_ALL);
		error_reporting(0);
		$data=array();
		$this->load->model('List_model');
		$this->List_model->table_name='prt_list';
		$this->List_model->hidden_column=array('mcs_id');
		$this->List_model->list_title=' Purchase Receipt';
		$this->List_model->search=array('supplier_name','number');
		//$this->List_model->order_by='';
		$this->List_model->links=
			array(
				array
				(
					'link_icon'=>'icon-tasks',
					'link_uri'=>base_url().index_page().'/preturn/purchase_return/?r34scrt8=',
					'key'=>'mcs_id',
					'extra'=>''
				)
			);
		$data=$this->List_model->render();
		return $this->load->view('list2',$data);
	}
}	