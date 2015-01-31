<?php 
class Mcs_model extends CI_Model {

	var $mcs_id=null;
	var $delete_able=true;
	
	function __construct() {
        parent::__construct();
    }

	function delete(){
		$this->db->where('mcs_id', $this->mcs_id);
		return $this->db->update('mcs_headers', array('mcs_status_id'=>4) );
	}
	
	function send(){
		$this->db->where('mcs_id', $this->mcs_id);
		return $this->db->update('mcs_headers', array('mcs_status_id'=>1) );
	}
	
	function get_header(){
		return $this->db->get_where('mcs_headers', array('mcs_id'=>$this->mcs_id))->row_array();
	}
	
	function get_items(){
		return $this->db->get_where('v_mcs_items', array('mcs_id'=>$this->mcs_id))->result_array();
	}
	
	function save_header($data){
		if(!$this->mcs_id){
			$data['mcs_id']=1+$this->db->query("select max(mcs_id) as mcs_id from mcs_headers")->row()->mcs_id;
			$this->sanitize($data);
			if($this->db->insert('mcs_headers',$data)){
				$this->mcs_id=$data['mcs_id'];
				$res['status']='success';
				$res['data']=$data;
			} else {
				$res['status']='error';
			}
		} else {
			$this->db->where( array('mcs_id'=>$this->mcs_id));
			$this->db->update('mcs_headers',$data);
		}
		return $res;
	}

	function save_item($data){
		$data['mcs_id']=$this->mcs_id;
		$data=$this->sanitize($data);
		if(empty($data['mcs_item_id'])){
			return $this->db->insert('mcs_items', $data);
		} else {
			$this->db->where(array('mcs_item_id'=>$data['mcs_item_id']));
			return $this->db->update('mcs_items', $data);
		}
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
