<?php $this->load->view('header');?>
<!-- container 2 -->
	<div class="row clearfix">
		<div class="col-md-12 column">
			<?php $this->load->view('menu');?>
			<?php $this->load->view("alert");?>
			
		</div>
	</div>
	<?php $this->load->view('breadcomb');?>
	<!-- landing page -->
<h3>Menu Management</h3>

<form class="form-horizontal" role="form" method=post>

		
<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Menu Name</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="menu_name" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Menu Head</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="menu_head" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Module</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="module" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Action</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="action" value=""  > 
		</div>
</div>
		
<tr align=center><td colspan=2 ><input type=submit value=Save>
</table>
</form>

	<!-- end landing page -->
<?php $this->load->view('footer');?>
