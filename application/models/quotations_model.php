<?php 
class Quotations_model extends CI_Model {

	var $quotation_id=0;
	var $delete_able=true;
	
	function __construct() {
        parent::__construct();
    }

	function delete(){
		$this->db->where('quotations_id', $this->quotation_id);
		return $this->db->delete('quotations');
	}
	
	function get_header(){
		return $this->db->get_where('v_quotation', array('quotation_id'=>$this->quotation_id))->row_array();
	}
	
	function get_items(){
		return $this->db->get_where('quotations_products', array('quotation_id'=>$this->quotation_id))->result_array();
	}
	
	function quotation_files(){
		return $this->db->get_where('quotation_files', array('quotation_id'=>$this->quotation_id))->result_array();
	}
	
	function save_header($data){
		$data['quotation_id']=1+$this->db->query("select max(quotation_id) as quotation_id from quotations")->row()->quotation_id;
		$this->sanitize($data);
		if($this->db->insert('quotations_headers',$data)){
			$this->quotation_id=$data['quotation_id'];
			$res['status']='success';
			$res['data']=$data;
		} else {
			$res['status']='error';
		}
		return $res;
	}

	function save_item($data){
		$data['quotation_id']=$this->quotation_id;
		$data=$this->sanitize($data);
		return $this->db->insert('quotations_products', $data);
	}
	
	function sanitize($data){
		foreach($data as $k=>$i){
				if(empty($i)) {
					unset($data[$k]);
				}	
		}
		return $data;
	}
}	
