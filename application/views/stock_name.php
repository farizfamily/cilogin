<?php $this->load->view('header');?>

<form class="form-horizontal" role="form" method=post>
<div class="row-fluid">
	<div class="span6 billing-form">


			<div class="control-group ">
				<label class="control-label">Stock Name Id</label>
				<input class=" span8" size="16" type="text" name="stock_name_id" value="<?php echo $stock_name_id;?>" readonly />
			</div>

			<div class="control-group ">
				<label class="control-label">Stock Name</label>
				<input class=" span8" size="16" type="text" name="stock_name" value="<?php echo $stock_name;?>"  />
			</div>
                                       <div class="row-fluid text-center">
                                            											<input type="submit" value="Submit"  class="btn btn-primary btn-large hidden-print" >
										 
                                        </div>
	</div>
</div>
</form>
<?php $this->load->view('footer');?>