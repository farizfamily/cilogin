<?php $this->load->view('header');?>
<!-- container 2 -->
	<div class="row clearfix">
		<div class="col-md-12 column">
			<h3>
				Welcome to <?php echo APPLICATION_NAME;?>
			</h3>
			
			<?php $this->load->view("alert");?>
			
			<form class="form-horizontal" role="form" method=post>
				<div class="form-group">
					 <label for="inputEmail3" class="col-sm-2 control-label">Userid</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="inputEmail3" name="userid">
					</div>
				</div>
				<div class="form-group">
					 <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="inputPassword3" name="passw">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<div class="checkbox">
							 <label><input type="checkbox"> Remember you </label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						 <button type="submit" class="btn btn-default">Sign in</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<?php $this->load->view('footer');?>
