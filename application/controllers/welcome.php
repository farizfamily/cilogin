<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Welcome extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -  
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in 
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see http://codeigniter.com/user_guide/general/urls.html
	 */
	public function index()
	{
		$data=array();
		if($this->input->post('userid')){
			//login logic
			//$this->db->se
			$userid = $this->input->post('userid');
			$passw = $this->input->post('passw');
			$hasil = $this->db->get_where('users', array('userid' => $userid,'passw'=>$passw))->result_array();
			if($hasil){
				//echo "login success";
				$userdata = array ('userid',$userid);
				$this->session->set_userdata($userdata);
				redirect('def');
			} else {
				$data['alert']['type']='warning';
				$data['alert']['messages']='Wrong userid/email or password!, please try again';
			}
		
		}
		$this->load->view('welcome_message', $data);
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */