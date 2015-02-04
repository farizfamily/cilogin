<?php 
class Menus_model extends CI_Model {
	
	var $user_id='';
	//var $user_menu_heads=array();
	//var $user_menus=array();

	function heads(){
		$user_menu_head2=array();
		$user_menu_head =  $this->db->get_where('menu_head', array('user_id'=>$this->user_id))->result_array();
		foreach($user_menu_head as $k=>$i){
					$user_menu_head2[$k]['menu_head']=$i['menu_head'];
					$user_menu_head2[$k]['icon']=$i['icon'];
		}
		//$this->user_menu_heads=
		return $user_menu_head2;
		
	}
	
	function menus(){
		$user_menus2=array();
		$user_menus = $this->db->get_where('head_menu', array('user_id'=>$this->user_id))->result_array();
		foreach($user_menus as $k=>$i){
					$user_menus2[$i['menu_head']][$k]=$i;
		}
		//$this->user_menus = 
		return $user_menus2;
	}

}	



/*

	$userid = $this->input->post('userid');
			$passw = $this->input->post('passw');
			$hasil = $this->db->get_where('users', array('userid' => $userid,'passw'=>$passw))->result_array();
			if($hasil){
				$userdata=$hasil[0];
				$user_menu_head = $this->db->get_where('menu_head', array('user_id'=>$userdata['user_id']))->result_array();
				$user_menus = $this->db->get_where('head_menu', array('user_id'=>$userdata['user_id']))->result_array();
				foreach($user_menu_head as $k=>$i){
					$user_menu_head2[$k]['menu_head']=$i['menu_head'];
					$user_menu_head2[$k]['icon']=$i['icon'];
				}
				
				foreach($user_menus as $k=>$i){
					$user_menus2[$i['menu_head']][$k]=$i;
				}
				$userdata['menu_heads']=$user_menu_head2;
				$userdata['menus']=$user_menus2;
				//print_r($userdata);
				$this->session->set_userdata($userdata);
				$_SESSION['mantra']=$userdata['user_id'];
				redirect('def');
*/				