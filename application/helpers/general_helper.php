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

function sanitize($qdata){
	foreach($qdata as $k=>$i){
				if(empty($i)) {
					unset($qdata[$k]);
				}	
	}
	return $qdata;
}


function get_assoc($a,$b){
	$c=array();
	foreach($b as $i){
		$c[$i[ $a[0] ]]=$i[ $a[1]];
	}
	return $c;
}