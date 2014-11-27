<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Nimda extends CI_Controller {

	public function resu()
	{
		$data=array();
		$this->load->view('nimda', $data);
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */