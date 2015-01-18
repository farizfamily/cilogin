<?php $this->load->view('header');?>
<br><br><br>

       <div class="row-fluid">
				<div class="widget">
                        <div class="widget-title">
                        <h4><i class="icon-reorder"></i>Quotation</h4>
                        </div>
						
						<!-- mulai form -->
						
						<table>
						<tr valign="top">
						<td><!-- form kiri-->
							<table>
							<Tr ><td>Status<td><select><option>Create</option></select>
							<tr ><td>Quotation Number<td><input type=text>
							<tr ><td>Date<td><input type="text" >
							<tr ><td>Contract<td><input type="text" >
							<tr ><td>Payment Term<td><input type="text" >
							<tr ><td>Construction Type<td><input type="text" >
							<tr ><td>Size<td><input type="text" >
							<tr ><td>Official<td><input type="checkbox">
							</table>
						<td><!-- form kanan -->
							<table>
							<tr ><td>Customer name<td><input type=text>
							<tr ><td>Address<td><textarea cols=10 rows=2></textarea>
							<tr ><td>Contact<td><input type="text">
							<tr ><td>Phone<td><input type="text">
							</table>
						</table>
						<!-- end form -->
				</div>						
		</div>
<?php $this->load->view('footer');?>

