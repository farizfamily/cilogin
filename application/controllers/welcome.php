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
			$userid = $this->input->post('userid');
			$passw = $this->input->post('passw');
			$hasil = $this->db->get_where('users', array('userid' => $userid,'passw'=>$passw))->result_array();
			if($hasil){
				$userdata=$hasil[0];
				$user_menu_head = $this->db->get_where('menu_head', array('user_id'=>$userdata['user_id']))->result_array();
				$user_menus = $this->db->get_where('head_menu', array('user_id'=>$userdata['user_id']))->result_array();
				foreach($user_menu_head as $k=>$i){
					$user_menu_head2[$k]['menu_head']=$i['menu_head'];
					$user_menu_head2[$k]['icon']=$i['icon'];
				}
				
				foreach($user_menus as $k=>$i){
					$user_menus2[$i['menu_head']][$k]=$i;
				}
				$userdata['menu_heads']=$user_menu_head2;
				$userdata['menus']=$user_menus2;
				//print_r($userdata);
				$this->session->set_userdata($userdata);
				$_SESSION['mantra']=$userdata['user_id'];
				redirect('def');
			} else {
				$data['alert']['type']='warning';
				$data['alert']['messages']='Wrong userid/email or password!, please try again';
			}
		
		}
		$this->load->view('welcome_message', $data);
	}
	function logout(){
		$this->session->unset_userdata('menus');
		$this->session->unset_userdata('menu_heads');
		$this->session->unset_userdata('userid');
		$this->session->unset_userdata('username');
		unset($_SESSION['mantra']);
		redirect('welcome');
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */