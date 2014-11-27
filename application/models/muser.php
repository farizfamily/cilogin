<?php 
class M_adduser extends CI_Model {

	function baca(){
		return $this->db->get('users')->result_array();
	}

	function simpan(){
		$this->db->insert('users', $this->input->post()); 
	}

}	