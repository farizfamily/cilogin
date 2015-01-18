<?php $this->load->view('header');?>
<!-- button -->
<div class="row-fluid">
	 <a class="icon-btn span2" href="invoice.html">
		 <i class="  icon-eye-open"></i>
		 <div>View Invoice</div>
	 </a>
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/quotation/create_quotation">
		 <i class=" icon-edit"></i>
		 <div>New Quotation</div>
	 </a>
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/quotation/quotation_list">
		 <i class=" icon-th-list"></i>
		 <div>Quotation List</div>
	 </a>
</div>
<!-- end button -->
<form method=post>
<div class="row-fluid">
	<div class="span6 billing-form">
		<h4>General information</h4>
		<div class="space10"></div>
		<!--
		<div class="control-group ">
			<label class="control-label">Quotation Id</label>
			<input class=" span8" size="16" type="text" name="quotation_id" value="" readonly />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Time Stamp</label>
			<input class=" span8" size="16" type="text" name="time_stamp" value="2015-01-13 10:33:53"  />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Created By</label>
			<input class=" span8" size="16" type="text" name="created_by" value=""  />
		</div>
		-->		
		<input type="hidden" name="quotation_id" value="<?php echo $quotation_id;?>" />
		<div class="control-group ">
			<label class="control-label">Quotation Number</label>
			<input class=" span8" size="16" type="text" name="quotation_number" value="<?php echo $quotation_number;?>" readonly />
		</div>


		<div class="control-group ">
			<label class="control-label">Revision</label>
			<input class=" span8" size="16" type="text" name="revision" value="<?php echo $revision;?>" readonly />
		</div>		

		<div class="control-group ">
			<label class="control-label">Status</label>
			<input class=" span8" size="16" type="text" name="status" value="<?php echo $status;?>" readonly />
		</div>
				

				
		<?php if(false):?>
		<div class="control-group ">
			<label class="control-label">Sales Number</label>
			<input class=" span8" size="16" type="text" name="sales_number" value="<?php echo $sales_number;?>"  />
		</div>
		<?php endif; //only when converted to polis  ?>		

		<div class="control-group ">
			<label class="control-label">Quotation Date</label>
<!--			<input class=" span8" type="date" name="quotation_date" value="<?php echo $quotation_date;?>" maxlength="10"  /> -->
				<input class="span8  m-ctrl-medium date-picker"  name="quotation_date" size="16" type="text" value="<?php echo $quotation_date;?>" data-date-format="yyyy-mm-dd" />
 		</div>
				

		<div class="control-group ">
			<label class="control-label">Contract Number</label>
			<input class=" span8" size="16" type="text" name="contract_number" value="<?php echo $contract_number;?>"  />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Term Of Payment</label>
			<input class=" span8" size="16" type="text" name="term_of_payment" value="<?php echo $term_of_payment;?>"  />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Construction Type</label>
			<input class=" span8" size="16" type="text" name="construction_type" value="<?php echo $construction_type;?>"  />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Size</label>
			<input class=" span8" size="16" type="text" name="size" value="<?php echo $size;?>"  />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Official</label>
				<div class="controls">
										 <label class="checkbox line">
										 <input type="checkbox" value="1"  name="official" <?php echo $official2;?>  /> Official
										 </label>
			</div>
		</div>
		</div>
				 
		<div class="span6 billing-form">
			<h4>Customer</h4>
			<div class="space10"></div>
			
			<div class="control-group">
				<label class="control-label">Customer Name</label>
					<?php echo form_dropdown('customer_id', $customers, $customer_id, 'class="span8 chosen"'); ?>
					<?php /* <select class="span8 chosen" data-placeholder="Choose a Category" tabindex="1">
						<option value=""></option>
						<option value="Category 1">Category 1</option>
						<option value="Category 2">Category 2</option>
						<option value="Category 3">Category 5</option>
						<option value="Category 4">Category 4</option>
					 </select> */ ?>
           </div>
					
			<div class="control-group ">
				<label class="control-label">Customer Contacts</label>
				<input class=" span8" size="16" type="tel" name="customer_contacts" value="" readonly  />
			</div>

			<div class="control-group ">
				<label class="control-label">Customer address</label>
				<input class=" span8" size="16" type="tel" name="customer_contacts" value="" readonly />
			</div>
			<div class="control-group ">
				<label class="control-label">Phone</label>
				<input class=" span8" size="16" type="tel" name="customer_contacts" value="" readonly />
			</div>


			
		</div>
</div>
<hr/>
<div class="row-fluid">
	<div class="span6 billing-form">
		<h4>Event</h4>
		<div class="space10"></div>
		<!-- fixme -->
		<div class="control-group ">
			<label class="control-label">Event name</label>
			<?php echo form_dropdown('event_id', $events, $event_id, 'class="span8 chosen"'); ?>
		</div>
		
		<div class="control-group ">
			<label class="control-label">Venue</label>
			<?php echo form_dropdown('venue_id', $venues, $venue_id, 'class="span8 chosen"'); ?>
		</div>
				

		<div class="control-group ">
			<label class="control-label">Show Day From</label>
			<input class="m-ctrl-medium date-picker span8 " size="16" type="text" name="show_day_from" value="<?php echo $show_day_from;?>" data-date-format="yyyy-mm-dd"  />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Show Day To</label>
			<input class="m-ctrl-medium date-picker span8" size="16" type="text" name="show_day_to" value="<?php echo $show_day_to;?>" data-date-format="yyyy-mm-dd"  />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Move In From</label>
			<input class="m-ctrl-medium date-picker input-small" size="16" type="text" name="move_in_from_date" value="<?php echo $move_in_from_date;?>"  data-date-format="yyyy-mm-dd" />
            <input type="text" name="move_in_from_time"  value="<?php echo $move_in_from_time;?>"  class=" input-small" />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Move In To</label>
			<input   class="m-ctrl-medium date-picker input-small" size="16" type="text" name="move_in_to_date" value="<?php echo $move_in_to_date;?>"  data-date-format="yyyy-mm-dd" />
            <input type="text" name="move_in_to_time"  value="<?php echo $move_in_to_time;?>"  class=" input-small" />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Move Out From</label>
			<input  class="m-ctrl-medium date-picker input-small" size="16" type="text" name="move_out_from_date" value="<?php echo $move_out_from_date;?>"  data-date-format="yyyy-mm-dd" />
            <input type="text" name="move_out_from_time"  value="<?php echo $move_out_from_time;?>" class=" input-small" />
		</div>
				

		<div class="control-group ">
			<label class="control-label">Move Out To</label>
			<input   class="m-ctrl-medium date-picker input-small" size="16" type="text" name="move_out_to_date" value="<?php echo $move_out_to_date;?>"  />
            <input type="text" name="move_out_to_time"  value="<?php echo $move_out_to_time;?>" class=" input-small" />
		</div>
	</div>

		<div class="span6 billing-form">
		<h4>Project Team</h4>
		<div class="space10"></div>
		

			<div class="control-group ">
				<label class="control-label">Project Executive</label>
				<?php echo form_dropdown('project_executive', $users, $project_executive, 'class="span8 chosen"'); ?>
			</div>
					

			<div class="control-group ">
				<label class="control-label">Project Supervisor</label>
				<?php echo form_dropdown('project_supervisor', $users, $project_supervisor, 'class="span8 chosen"'); ?>
			</div>
					

			<div class="control-group ">
				<label class="control-label">Designer</label>
				<?php echo form_dropdown('designer', $users, $designer, 'class="span8 chosen"'); ?>
			</div>
					

			<div class="control-group ">
				<label class="control-label">Notes</label>
				<div class="controls">
                                        <textarea class="input-xlarge" rows="3" name="notes" ><?php echo $notes;?></textarea>
                </div>
			</div>
		
	</div>
</div>
<hr/>
<!-- table start-->
   <div class="space15"></div>
                                <div class="row-fluid">
                                    <div class="span12">
                                        <h4>Product Item</h4>
                                        <table class="table table-hover invoice-input">
                                            <thead>
                                            <tr>
                                                <th></th>
                                                <th>Product Group</th>
                                                <th>Description</th>
                                                <th >Contract Amount</th>
                                            </tr>
                                            </thead>
                                            <tbody>
											<?php foreach($qir as $k=>$i):?>
                                            <tr>
                                                <td><?php echo $k+1;?></td>
												<input type="hidden" name="f[<?php echo $k;?>][quotation_product_id]" value="<?php echo $i['quotation_product_id'];?>">
                                                <td><input type="text" name="f[<?php echo $k;?>][product_group]"  class="input-large" value="<?php echo $i['product_group'];?>" ></td>
                                                <td><input type="text" name="f[<?php echo $k;?>][description]" class="input-xlarge"  value="<?php echo $i['description'];?>" ></td>
                                                <td>
												<input type="text" data-mask=" 999,999,999.99"  name="f[<?php echo $k;?>][amount]" class="input-large" value="<?php echo $i['amount'];?>" >
												</td>
                                            </tr>
											<?php endforeach;?>


                                            <?php /* fixme <tr>
                                                <td colspan="3"></td>
                                                <td ><a href="#">Add More +</a></td>
                                            </tr> */ ?>
											
                                            </tbody>
                                        </table>
                                        <div class="row-fluid text-center">
                                            <?php /* <a class="btn btn-primary btn-large hidden-print" >Submit   </a> */ ?>
											<input type="submit" value="Submit"  class="btn btn-primary btn-large hidden-print" >
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

<!-- table end -->
</form>
<?php $this->load->view('footer');?>

