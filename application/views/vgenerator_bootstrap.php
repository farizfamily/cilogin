<?php $this->load->view('header');?>
<!-- container 2 -->
	<div class="row clearfix">
		<div class="col-md-12 column">
			<?php $this->load->view('menu');?>
			<?php $this->load->view("alert");?>
			
		</div>
	</div>
	<?php $this->load->view('breadcomb');?>


<h3><?php echo $judul;?> Form</h3>

<form class="form-horizontal" role="form" method=post>
<?php //print_r($cols);?>
<!-- potong di sini -->
<?php foreach($cols as $i):?>
<?php $readonly='';?>
<?php $val='';?>
<?php if(!empty($i['column_default'])  and substr($i['column_default'],0,7)=='nextval'  ) $readonly='readonly';?>
<?php if(!empty($i['column_default'])  and substr($i['column_default'],0,7)=='now()'  ) $val=date('Y-m-d h:i:s');?>

<div class="control-group ">
	<label class="control-label"><?php echo  ucwords(str_replace('_',' ',$i['column_name']));?></label>
	<input class=" span8" size="16" type="text" name="<?php echo $i['column_name'];?>" value="<?php echo $val;?>" <?php echo $readonly;?> />
</div>
		
<?php endforeach;?>
<!-- end potong di sini -->
<tr align=center><td colspan=2 ><input type=submit value=Save>
</table>
</form>
	<!-- end landing page -->
<?php $this->load->view('footer');?>
