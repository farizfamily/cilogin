<?php 
class Logistics_model extends CI_Model {

	function count(){
		return $this->db->count_all('stocks');
	}

	function update($data){
		foreach($data as $k=>$i){
			if(empty($i)) {
				unset($data[$k]);
			}	
		}
		$this->db->where('stock_id', $data['stock_id']);
		$this->db->update('stocks', $data);
	}
	
	function get_all(){
		return $this->db->get('v_stocks')->result_array();
	}
	
	function get_stock_data($id){
		return $this->db->get_where('stocks', array('stock_id' => $id))->row_array();
	}
	
	function get_groups(){
		$a=$this->db->get('stock_groups')->result_array();
		foreach($a as $b){
			$c[$b['group_id']]=$b['group_name'];
		}
		return $c;
	}

	
	function get_names(){
		$a=$this->db->get('stock_names')->result_array();
		foreach($a as $b){
			$c[$b['stock_name_id']]=$b['stock_name'];
		}
		return $c;
	}
	
}	