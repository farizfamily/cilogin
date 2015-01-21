<?php $this->load->view('header');?>

<form class="form-horizontal" role="form" method=post>
<div class="row-fluid">
	<div class="span6 billing-form">


			<div class="control-group ">
				<label class="control-label">User Id</label>
				<input class=" span8" size="16" type="text" name="user_id" value="<?php echo $user_id;?>"  readonly />
			</div>


			<div class="control-group ">
				<label class="control-label">Register Number</label>
				<input class=" span8" size="16" type="text" name="register_number" value="<?php echo $register_number;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Userid</label>
				<input class=" span8" size="16" type="text" name="userid" value="<?php echo $userid;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Username</label>
				<input class=" span8" size="16" type="text" name="username" value="<?php echo $username;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Email</label>
				<input class=" span8" size="16" type="email" name="email" value="<?php echo $email;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Passw</label>
				<input class=" span8" size="16" type="text" name="passw" value="<?php echo $passw;?>"  />
			</div>

			<div class="control-group ">
				<label class="control-label">Userrole</label>
				<?php echo form_dropdown('role_id', $roles, $role_id, 'class="span8 chosen"'); ?>
			</div>

			<div class="control-group ">
				<label class="control-label">Dept</label>
				<input class=" span8" size="16" type="text" name="dept" value="<?php echo $dept;?>"  />
			</div>
                                       <div class="row-fluid text-center">
                                            											<input type="submit" value="Submit"  class="btn btn-primary btn-large hidden-print" >
										 
                                        </div>
	</div>
</div>
</form>
<!-- end potong di sini -->



<?php $this->load->view('footer');?>

