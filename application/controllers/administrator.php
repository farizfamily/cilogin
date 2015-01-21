<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Administrator extends CI_Controller {

	public function manage_user(){
		$this->load->model('Users_model');
		$data['kunci']='user_id';
		$data['list_titla']="User List";
		$data['open_url']=base_url().index_page().'/administrator/create_user';
		$data['delete_url']=base_url().index_page().'/administrator/delete_user';
		$data['data'] = $this->Users_model->get_all();
		$this->load->view('list', $data);
	}
	
 
	public function create_user(){
		error_reporting(E_ALL);
		if(!$this->session->userdata('userid')) redirect('welcome');
		$this->load->model('Etc_model');
		$this->load->model('Users_model');

		$this->load->helper('form');
		$data['roles']=$this->Etc_model->role();
		
		//save
		if($this->input->post('userid')){
			//insert
			if($this->input->post('user_id')){
				$ud = $_POST;
				$ud=$this->Etc_model->sanitize($ud);
				$this->db->where('user_id', $this->input->post('user_id'));
				$this->db->update('users',$ud);
			} else {	//update
				$ud = $_POST;
				$ud=$this->Etc_model->sanitize($ud);
				$this->db->insert('users',$ud);
			}
		}
		if($this->input->get('rec')){
			foreach($this->Users_model->get_user_data($this->input->get('rec')) as $k=>$i){
				$data[$k]=$i;
			}
		}
		return $this->load->view('create_user', $data);
	}


}                                                                                                                

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */