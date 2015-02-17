<?php 
class Inventory_model extends CI_Model {

	var $mcs_id=null;
	var $delete_able=true;
	var $new_status=null;
	var $status_id=0;
	var $transaction_type_id=null;
	var $quotation_id=null;
	var $quotation_header=array();
	var $data=array();
	
	function __construct() {
        parent::__construct();		
    }
	function keder() {
		$data=array();

		if($this->mcs_id){
			$data=$this->get_header();
			$this->quotation_id=$data['quotation_id'];
			$data['mir']=$this->get_items();
		}
		
		if( $this->quotation_id) {
			$this->load->model('Quotations_model');
			$this->load->model('Etc_model');
			$this->Quotations_model->quotation_id=$this->quotation_id;
			$data = array_merge($data,$this->Quotations_model->get_header());
			$data['customers']=$this->Etc_model->customers();
			$data['events']=$this->Etc_model->events();
			$data['users']=$this->Etc_model->users();
			$data['venues']=$this->Etc_model->venues();
			$data['columns']=$this->Inventory_model->columns();
		}

		$data['mir']=array_merge($data['mir'], array(1,2,3,4,5,6,7));
		if( empty($this->mcs_id) ) $data['mir']=array(1,2,3,4,5,6,7,8,9);

		
		$stocks2=$this->db->get('v_stocks')->result_array();
		foreach($stocks2 as $stocks3){
			$stocks[$stocks3['stock_id']]=$stocks3['stock_name'];
		}
		$data['stocks']=$stocks;
		
		$sgroups2=$this->db->get('stock_groups')->result_array();
		foreach($sgroups2 as $sgroups3){
			$sgroups[$sgroups3['group_id']]=$sgroups3['group_name'];
		}
		$data['sgroups']=$sgroups;
		return array_merge($data, $this->columns());
	}
	
	function getTtypeName(){
		return $this->db->get_where('mcs_transaction_types', array('transaction_type_id'=>$this->transaction_type_id))->row()->transaction_name;
	}

	function columns(){
		return  array_values(  $this->db->query("select column_name from information_schema.columns where table_name='mcs_headers' ")->result_array() );
	}
	
	function delete(){
		$this->db->where('mcs_id', $this->mcs_id);
		return $this->db->update('mcs_headers', array('mcs_status_id'=>4) );
	}
	
	function send(){
		$this->db->where('mcs_id', $this->mcs_id);
		return $this->db->update('mcs_headers', array('mcs_status_id'=>1 ));
	}
	
	function update_status(){
		$this->db->where('mcs_id', $this->mcs_id);
		return $this->db->update('mcs_headers', array('mcs_status_id'=>$this->new_status) );
	}
	
	function get_header(){
		return $this->db->get_where('mcs_headers', array('mcs_id'=>$this->mcs_id))->row_array();
	}
	
	function get_items(){
		return $this->db->get_where('v_mcs_items', array('mcs_id'=>$this->mcs_id))->result_array();
	}
	
	function ttypecode(){
		return $this->db->query("select code from mcs_transaction_types where transaction_type_id=".$this->transaction_type_id)->row()->code;
	}
	
	function save_header($data){
		if(!$this->mcs_id){
			$data['mcs_id']=1+$this->db->query("select max(mcs_id) as mcs_id from mcs_headers")->row()->mcs_id;
			$data=$this->sanitize($data);
			$data['transaction_type_id']=$this->transaction_type_id;
			$data['mcs_number']=$this->getTtypeName().date('Ym').'/'.$data['mcs_id'];
			if($this->db->insert('mcs_headers',$data)){
				$this->mcs_id=$data['mcs_id'];
				$res['status']='success';
				$res['data']=$data;
			} else {
				$res['status']='error';
			}
		} else {
			$data=$this->sanitize($data);
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
