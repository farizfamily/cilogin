			<?php if(isset($alert)):?>
			<?php if( !isset($alert['type']) or empty($alert['type']) ) $alert['type']='warning';?>
			<div class="alert alert-dismissable alert-<?php echo $alert['type'];?>">
				 <button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>
				<h4>
					Alert!
				</h4> <?php echo $alert['messages'];?>
			</div>
			<?php endif;?>
