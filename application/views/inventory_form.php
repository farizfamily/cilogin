<?php $this->load->view('header');?>
<!-- button -->
<div class="row-fluid">
<?php if($mcs_status_id==0):?>
	<?php if($mcs_id):?>
	 <a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/mo/send_mo?one=<?php echo $mcs_id;?>">
		 <i class="icon-print"></i>
		 <div>Send</div>
	 </a>
	 
 	<a class="icon-btn span2" href="<?php echo base_url();?><?php echo index_page();?>/mo/delete?one=<?php echo $mcs_id;?>">
		 <i class="icon-trash"></i>
		 <div>Delete</div>
	 </a>

	 
	 <?php endif;?>
<?php endif;?>

	 
	 
	 
</div>
<!-- end button -->
<div class="row-fluid">
<!-- quotation header -->
<?php if (  !empty($this->Inventory_model->quotation_id) ):?>
<?php $this->load->view('quotation_header');?>
<?php endif;?>
<!-- end quotation header -->

<!-- material table start-->
<?php $magic=array(0,2,3);?>
<?php if( in_array($mcs_status_id , $magic  )): ?>
<form  method="post">
<?php endif;?>
<input type="hidden" name="quotation_id" value="<?php echo $quotation_id;?>">
<input type="hidden" name="mcs_id" value="<?php echo $mcs_id;?>">
<h4>  Data <?php echo $this->Inventory_model->getTtypeName();?></h4>

<div class="row-fluid">
	<!-- loop inventory header data should start here xxxxxx -->
<div class="row-fluid">
	<div class="span6 billing-form">

			<div class="control-group ">
				<label class="control-label">Number</label>
				<input class=" span8" size="16" type="text" name="mcs_number" value="<?php echo $mcs_number;?>" readonly />
			</div>

		<?php /*	<div class="control-group ">
				<label class="control-label">Mcs Status Id</label>
				<input class=" span8" size="16" type="text" name="mcs_status_id" value="<?php echo $mcs_status_id;?>"  />
			</div> */  ?>

 
			<div class="control-group ">
				<label class="control-label"> Date</label>
				<input class="span8  m-ctrl-medium date-picker" size="16" type="text" name="mcs_date" value="<?php echo $mcs_date;?>"   />
			</div>

			<div class="control-group ">
				<label class="control-label">Notes</label>
				<input class=" span8" size="16" type="text" name="mcs_notes" value="<?php echo $mcs_notes;?>"  />
			</div>
			
			<?php if($this->Inventory_model->transaction_type_id==3):?>
			<div class="control-group ">
			<label class="control-label">Supplier</label>
			<?php echo form_dropdown('supplier_id', $suppliers, $supplier_id, 'class="span8 chosen"');?>
			</div>
			<?php endif;?>
			
	</div>
</div>
	<!-- loop inventory header data should start here xxxxxx -->
</div>

<hr/>
<div class="space15"></div>
                                <div class="row-fluid">
                                    <div class="span12">
                                        <h4>Material Item</h4>
                                        <table class="table table-hover invoice-input">
                                            <thead>
                                            <tr>
                                                <th></th>
												<th>Item Group</th>
                                                <th>Item</th>
                                                <th>Notes</th>
												<th>Unit</th>
                                                <th>Qty</th>
                                            </tr>
                                            </thead>
                                            <tbody>
											<?php foreach($mir as $k=>$i):?>
                                            <tr>
                                                <td><?php echo $k+1;?></td>
												<td>
												<input type="hidden" name="i[<?php echo $k;?>][mcs_item_id]" value="<?php echo $i['mcs_item_id'];?>" >
												<?php echo form_dropdown('', $sgroups, $i['group_id'], 'class="input-large chosen"');?>
												</td>
												<td><?php echo form_dropdown('i['.$k.'][stock_id]', $stocks, $i['stock_id'], 'class="span8 chosen"'); ?></td>
                                                <td><input type="text" name="i[<?php echo $k;?>][notes]" class="input-xlarge"  value="<?php echo $i['notes'];?>" ></td>
                                                <td><?php echo $i['unit'];?></td>
												<td>
												<input type="text" data-mask=" 999,999,999.99"  name="i[<?php echo $k;?>][qty]" class="input-large" value="<?php echo $i['qty'];?>" style="text-align: right"  >
												</td>
                                            </tr>
											<?php endforeach;?>
                                            </tbody>
                                        </table>
                                        <div class="row-fluid text-center">
											<?php if( in_array($mcs_status_id , $magic )): ?>
											<input type="submit" value="Submit"  class="btn btn-primary btn-large hidden-print" >
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

