<?php $this->load->view('header');?>

<!-- potong di sini -->
<form class="form-horizontal" role="form" method=post>
<div class="row-fluid">
	<div class="span6 billing-form">


			<div class="control-group ">
				<label class="control-label">Stock Id</label>
				<input class=" span8" size="16" type="text" name="stock_id" value="<?php echo $stock_id;?>" readonly />
			</div>

			<div class="control-group ">
				<label class="control-label">Stock Code</label>
				<input class=" span8" size="16" type="text" name="stock_code" value="<?php echo $stock_code;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Stock Name Id</label>
				<input class=" span8" size="16" type="text" name="stock_name_id" value="<?php echo $stock_name_id;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Size</label>
				<input class=" span8" size="16" type="text" name="size" value="<?php echo $size;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Unit Id</label>
				<input class=" span8" size="16" type="text" name="unit_id" value="<?php echo $unit_id;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Group Id</label>
				<input class=" span8" size="16" type="text" name="group_id" value="<?php echo $group_id;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Sub Group Id</label>
				<input class=" span8" size="16" type="text" name="sub_group_id" value="<?php echo $sub_group_id;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Type Id</label>
				<input class=" span8" size="16" type="text" name="type_id" value="<?php echo $type_id;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Brand Id</label>
				<input class=" span8" size="16" type="text" name="brand_id" value="<?php echo $brand_id;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Active</label>
				<input class=" span8" size="16" type="text" name="active" value="<?php echo $active;?>"  />
			</div>
                                       <div class="row-fluid text-center">
                                            											<input type="submit" value="Submit"  class="btn btn-primary btn-large hidden-print" >
										 
                                        </div>
	</div>
</div>
</form>
<!-- end potong di sini -->




<?php $this->load->view('footer');?>