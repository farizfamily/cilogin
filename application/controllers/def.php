<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Def extends CI_Controller {

	public function index()
	{
		$data=array();
		$this->load->view('default', $data);
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */