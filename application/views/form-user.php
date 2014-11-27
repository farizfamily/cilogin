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
<h3>User Management</h3>

<form class="form-horizontal" role="form" method=post>

		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Register Number</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="register_number" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Userid</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="userid" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Username</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="username" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="email" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Passw</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="passw" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Userrole</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="userrole" value=""  > 
		</div>
</div>
		

<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label">Dept</label>
		<div class="col-sm-10">
		<input class="form-control" type=text name="dept" value=""  > 
		</div>
</div>
		
<tr align=center><td colspan=2 ><input type=submit value=Save>
</table>
</form>

	<!-- end landing page -->
<?php $this->load->view('footer');?>
