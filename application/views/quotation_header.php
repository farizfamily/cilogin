<div class="row-fluid">
	<div class="span6 billing-form">
		<h4>General information <?php if( !in_array($quotation_status_id, $magic)):?> <small> Read only </small><?php endif;?>  </h4>
		<div class="space10"></div>
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
			<input class=" span8" size="16" type="text"  value="<?php echo $status_name;?>" readonly />
		</div>
				
		<div class="control-group ">
			<label class="control-label">Sales Number</label>
			<input class=" span8" size="16" type="text" name="sales_number" value="<?php echo $sales_number;?>"  />
		</div>

		<div class="control-group ">
			<label class="control-label">Contract Number</label>
			<input class=" span8" size="16" type="text" name="contract_number" value="<?php echo $contract_number;?>"  />
		</div>
		
		<div class="control-group ">
			<label class="control-label">Quotation Date</label>
				<input class="span8  m-ctrl-medium date-picker"  name="quotation_date" size="16" type="text" value="<?php echo $quotation_date;?>" data-date-format="yyyy-mm-dd" />
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
           </div>
					
			<div class="control-group ">
				<label class="control-label">Customer Contacts</label>
				<input class=" span8" size="16" type="tel"   value="<?php echo $customer_contact_1;?>" readonly  />
			</div>

			<div class="control-group ">
				<label class="control-label">Customer address</label>
				<input class=" span8" size="16" type="tel"   value="<?php echo $full_address;?>" readonly />
			</div>
			<div class="control-group ">
				<label class="control-label">Phone</label>
				<input class=" span8" size="16" type="tel"   value="<?php echo $phone;?>" readonly />
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
