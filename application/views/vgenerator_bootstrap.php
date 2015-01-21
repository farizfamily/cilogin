<?php $this->load->view('header');?>

<!-- potong di sini -->
<form class="form-horizontal" role="form" method=post>
<div class="row-fluid">
	<div class="span6 billing-form">

<?php foreach($cols as $i):?>
<?php $readonly='';?>
<?php $val='';?>
<?php if(!empty($i['column_default'])  and substr($i['column_default'],0,7)=='nextval'  ) $readonly='readonly';?>
<?php if(!empty($i['column_default'])  and substr($i['column_default'],0,7)=='now()'  ) $val=date('Y-m-d h:i:s');?>

<?php /*
<div class="control-group ">
	<label class="control-label"><?php echo  ucwords(str_replace('_',' ',$i['column_name']));?></label>
	<input class=" span8" size="16" type="text" name="<?php echo $i['column_name'];?>" value="<?php echo $val;?>" <?php echo $readonly;?> />
</div>*/?>
			<div class="control-group ">
				<label class="control-label"><?php echo  ucwords(str_replace('_',' ',$i['column_name']));?></label>
				<input class=" span8" size="16" type="text" name="<?php echo $i['column_name'];?>" value="xxxxx<?php echo $i['column_name'];?>xxx"  />
			</div>
<?php endforeach;?>
                                       <div class="row-fluid text-center">
                                            <?php /* <a class="btn btn-primary btn-large hidden-print" >Submit   </a> */ ?>
											<input type="submit" value="Submit"  class="btn btn-primary btn-large hidden-print" >
										 
                                        </div>
	</div>
</div>
</form>
<!-- end potong di sini -->
<?php $this->load->view('footer');?>
