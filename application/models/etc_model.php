<?php 
class Etc_model extends CI_Model {

	function __construct() {
        parent::__construct();
    }

	function role(){
		foreach( $this->db->query("select * from roles")->result_array() as $i){
			$data[$i['role_id']]=$i['role_name'];
		}
		return $data;
	}
	
	function sanitize($qdata){
		foreach($qdata as $k=>$i){
				if(empty($i)) {
					unset($qdata[$k]);
				}	
		}
		return $qdata;
	}
	
}	