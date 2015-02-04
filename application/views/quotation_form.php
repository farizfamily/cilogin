<?php $this->load->view('header');?>
<!-- button -->
<div class="row-fluid">
	 
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/quotation/create_quotation">
		 <i class=" icon-edit"></i>
		 <div>New Quotation</div>
	 </a>
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/quotation/quotation_list">
		 <i class=" icon-th-list"></i>
		 <div>Quotation List</div>
	 </a>
<?php if($quotation_status_id==0):?>
	<?php if($quotation_id):?>
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/quotation/send_quotation?one=<?php echo $quotation_id;?>">
		 <i class="icon-print"></i>
		 <div>Send</div>
	 </a>
	 <?php endif;?>
<?php endif;?>

<?php if($quotation_status_id==1):?>
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/quotation/convert_to_sales?one=<?php echo $quotation_id;?>">
		 <i class="  icon-money"></i>
		 <div>Win</div>
	 </a>
	 
	 
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/quotation/loss_quotation?one=<?php echo $quotation_id;?>">
		 <i class="  icon-eye-open"></i>
		 <div>Lose</div>
	 </a>
<?php endif;?>
	 
	 
	 
</div>
<!-- end button -->
<?php $magic=array(0,2,3);?>
<?php if( in_array($quotation_status_id , $magic  )): ?>
<form  method="post" accept-charset="utf-8" enctype="multipart/form-data">
<?php endif;?>
<div class="row-fluid">
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
				
		<?php if( $quotation_status_id==3):?>
		<div class="control-group ">
			<label class="control-label">Sales Number</label>
			<input class=" span8" size="16" type="text" name="sales_number" value="<?php echo $sales_number;?>"  />
		</div>

		<div class="control-group ">
			<label class="control-label">Contract Number</label>
			<input class=" span8" size="16" type="text" name="contract_number" value="<?php echo $contract_number;?>"  />
		</div>
		<?php endif; //only when converted to polis  ?>		

		<?php if( $quotation_status_id==4):?>
		<div class="control-group ">
			<label class="control-label">Loss Factor</label>
			<?php echo form_dropdown('loss_factor_id', $loss_factors, $loss_factor_id, 'class="input-large" id="lfu"  '); ?>
            <button type="submit" class="btn blue" onclick="lfu()"><i class="icon-thumbs-down"></i> Update Loss Factor and Close</button>
		</div>
		<script>
		function lfu(){
			var lfv = $('#lfu').find(":selected");
			//alert(lfv.text());
			//alert(lfv.val());
			c = confirm("This will update loss factor to "+lfv.text()+" and close quotation\n click Ok to continue");
			if(c){
				window.location="<?php echo base_url();?><?php echo index_page();?>/quotation/loss_factor?one=<?php echo $quotation_id;?>&lfi="+lfv.val();
			} 
		}
		</script>
		<?php endif;?>
		
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
												<input type="text" data-mask=" 999,999,999.99"  name="f[<?php echo $k;?>][amount]" class="input-large" value="<?php echo $i['amount'];?>" style="text-align: right">
												</td>
                                            </tr>
											<?php endforeach;?>
											<tr>
                                                <td></td>
												<td></td>
                                                <td >Gross Total</td>
												<td><input type="text" data-mask=" 999,999,999.99"   class="input-large" value="<?php echo $gross_total;?>" style="text-align: right" readonly ></td>
											</tr>
											<tr>
												<td></td>
												<td></td>
												<td >Fee</td>
												<td><input type="text" name="fee" value="<?php echo $fee;?>" style="text-align: right" >
											</tr>
											<tr>
												<td></td>
												<td></td>
												<td >Discount</td>
												<td><input type="text" name="discount" value="<?php echo $discount;?>"  style="text-align: right" >
											</tr>
												<td></td>
												<td></td>
												<td>Nett Total</td>
												<td><input type="text" value="<?php echo $nett_total;?>"  style="text-align: right" readonly >
											</tr>
                                            </tbody>
                                        </table>
                                        <div class="row-fluid text-center">
											<?php if( in_array($quotation_status_id , $magic )): ?>
											<input type="submit" value="Submit"  class="btn btn-primary btn-large hidden-print" >
											<?php else:?>
											<input type="button" value="Submit" disabled  class="btn btn-primary btn-large hidden-print" title="readonly mode" >
											<?php endif;?>
                                        </div>
                                    </div>
                                </div>
<!-- table end-->								
<!-- files -->
<?php if($quotation_id):?>

<hr/>
								<div class="space15"></div>
								
                                <div class="row-fluid">
                                    <div class="span12">
                                        <h4>Files</h4>
                                        <table class="table table-hover invoice-input">
                                            <thead>
                                            <tr>
                                                <th></th>
                                                <th>File Name</th>
                                                <th>Description</th>
                                                <th>Link</th>
                                            </tr>
                                            </thead>
                                            <tbody>
											<?php if(!empty($files[0])):?>
											<?php foreach($files as $k=>$i):?>
                                            <tr>
                                                <td><?php echo $k+1;?></td>
												<td><?php echo $i['file_name'];?>
												<td><?php echo $i['description'];?>
												<td>
												
												<!-- a href="<?php echo base_url();?><?php echo index_page();?>/quotation/download_file?xol=<?php echo $i['quotation_files_id'];?>" target="_blank" ><i class=" icon-download-alt" ></i></a  -->
												
												<a href="<?php echo base_url();?>berkas/<?php echo $i['file_name'];?>" target="_blank" ><i class="icon-download-alt"></i></a>
												
												<?php if($quotation_status_id==0):?>
												<a href="<?php echo base_url();?><?php echo index_page();?>/quotation/delete_file/?xol=<?php 
										echo $i['quotation_files_id'];?>" onclick="return confirm('Are you sure you want to delete?')" ><i class="icon-remove"></a></td>
												<?php endif;?>
                                            </tr>
											<?php endforeach;?>
											<?php else:?>
											<tr><td colspan=4>No file yet for this quotation</td>
											<?php endif;?>
											<tr>
											<td></td>
											<td><input type="file" name="userfile" /></td>
											<td colspan="2"><input type="text" name="description" ></td>
                                            </tbody>
                                        </table>
										<hr/>
                                    </div>
                                </div>								
<?php endif;?>
<!-- end files -->
                            </div>
                        </div>
                    </div>









</form>
<?php $this->load->view('footer');?>

