<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Logistic extends CI_Controller {

	function create_stock(){
		if(!$this->session->userdata('userid')) redirect('welcome');

		error_reporting(0);
		$data=array();
	
		$this->load->view('create_stock', $data);
	}

	function stock_list(){
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