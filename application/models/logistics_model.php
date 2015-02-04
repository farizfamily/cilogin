<?php 
class Logistics_model extends CI_Model {

	var $stock_id=0;
	var $stock_types = array();
	var $stock_brands = array();
	var $stock_units = array();

	function __construct() {
        parent::__construct();
		$this->stock_types = get_assoc ( array('type_id','type_name') ,  $this->db->get('stock_types')->result_array() );
		$this->stock_brands= get_assoc ( array('brand_id','brand_name'), $this->db->get('stock_brands')->result_array() );
		$this->stock_units= get_assoc ( array('stock_unit_id','unit_name'), $this->db->get('stock_units')->result_array() );
    }
	
	function count(){
		return $this->db->count_all('stocks');
	}
	
	function save($data){
		$data=sanitize($data);
		$this->db->insert('stocks', $data);
	}

	function update($data){
		foreach($data as $k=>$i){
			if(empty($i)) {
				unset($data[$k]);
			}	
		}
		$this->db->where( array('stock_id' => $data['stock_id']))  ;
		$this->db->update('stocks', $data);
		$this->stock_id=$data['stock_id'];
	}
	
	function save_stock_name($data){
		$data=sanitize($data);
		if(empty($data['stock_name_id'])){
			if($this->db->insert('stock_names', $data)) return true;
		} else {
			$this->db->where( array('stock_name_id'=>$data['stock_name_id']));
			if($this->db->update('stock_names', $data)) return true;
		}
		return false;
	}
	
	function get_stock_names($id){
		return $this->db->get_where('stock_names', array('stock_name_id'=>$id))->row_array();
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