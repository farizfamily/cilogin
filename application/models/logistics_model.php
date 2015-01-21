<?php 
class Logistics_model extends CI_Model {

	function count(){
		return $this->db->count_all('stocks');
	}

	function get_all(){
		return $this->db->get('v_stocks')->result_array();
	}
	
	function get_stock_data($id){
		return $this->db->get_where('stocks', array('stock_id' => $id))->row_array();
	}
}	