<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Formgenerator extends CI_Controller {

	public function __construct (){
		parent::__construct();        
		$this->load->model('M_adduser');
		$this->load->library('form_validation');
	}

	public function index($table_name='')
	{	
		$data=array();
		$data['judul']='judul';
		if(empty($table_name)){
			echo "empty table_name";
			exit;
		}
		
		//ambil column
			$cols = $this->db->query("select table_name,column_name, data_type, is_nullable, column_default
			from information_schema.columns where table_name=? order by ordinal_position", array($table_name))->result_array();

		$data['judul']=$cols[0]['table_name'];	
		$data['cols']=$cols;
		//$this->M_adduser->simpan($data);
		$this->load->view('vgenerator_bootstrap',$data);
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */