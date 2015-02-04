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

	function customers(){
		return get_assoc( array('customer_id', 'customer_name'), $this->db->query("select customer_id, customer_name from customers")->result_array());
	}
	
	function events(){
		return get_assoc( array('event_id','event_name'), $this->db->query("select event_id, event_name from events")->result_array());
	}
	
	function venues(){
				return get_assoc( array('venue_id', 'venue_name'),$this->db->query("select venue_id, venue_name from venues")->result_array());
	}
	
	function users(){
		return get_assoc( array('user_id', 'username'),$this->db->query("select user_id, username from users")->result_array());
	}

/*	

		$events = $this->db->query("select event_id, event_name from events")->result_array();
		foreach($events as $i){
			$events2[$i['event_id']]=$i['event_name'];
		}
		$data['events']=$events2;

		$venues = $this->db->query("select venue_id, venue_name from venues")->result_array();
		foreach($venues as $i){
			$venues2[$i['venue_id']]=$i['venue_name'];
		}
		$data['venues']=$venues2;		

		$users = $this->db->query("select user_id, username from users")->result_array();
		foreach($users as $i){
			$users2[$i['user_id']]=$i['username'];
		}
		$data['users']=$users2;		
			
*/	
	
	
	
	
	
	
	
	
	
	
	function sanitize($qdata){
		foreach($qdata as $k=>$i){
				if(empty($i)) {
					unset($qdata[$k]);
				}	
		}
		return $qdata;
	}
	
}	