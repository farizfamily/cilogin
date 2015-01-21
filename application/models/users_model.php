<?php 
class Users_model extends CI_Model {

	function count(){
		return $this->db->count_all('users');
	}

	function get_all(){
		return $this->db->get('users')->result_array();
	}
	
	function get_user_data($id){
		return $this->db->get_where('users', array('user_id' => $id))->row_array();
	}
}	