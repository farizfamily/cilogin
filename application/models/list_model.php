<?php 
class List_model extends CI_Model {


	public $table_name = '';
	public $search = array();
	public $row_per_page = 2;
	public $set_page = 1;
	public $hidden_column=array();
	public $rename_column=array();
	public $readonly_condition="";
	public $list_title=' Pentawira';
	public $order_by = '';
	public $links=array();
	function __construct() {
        parent::__construct();
		//echo 'test';
    }

	public function render(){
		$data['hidden_column']=$this->hidden_column;
		$data['search']=$this->search;
		$data['row_per_page']=$this->row_per_page;
		$data['set_page']=$this->set_page;
		$data['rename_column']=$this->rename_column;
		$data['readonly_condition']=$this->readonly_condition;
		$data['list_title']=$this->list_title;
		$data['links']=$this->links;
		$halaman = $this->row_per_page*$this->set_page-1;
		if(!empty($this->search)) {
			foreach($this->search as $s){
				$ssearch['lower('.$s.')']=$this->input->get('searchs');
			}
			$this->db->or_like($ssearch);
		}
		if(!empty($this->order_by)) $this->db->order_by($this->order_by);
		$data['data'] = $this->db->get($this->table_name)->result_array();
		return $data;
	}
}	