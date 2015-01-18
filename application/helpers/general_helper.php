<?php
/* 2015-01-19
ridei.karim@gmail.com
*/

function quotation_number($initial=''){
	$y=date('Y');
	$m=date('m');
	//$a = $this->db->query("select max(quotation_id) as a from quotations")->row_array();
	$b = $a['a']+1;
	return 'Q'.$y.$m.'/'.$initial;
}