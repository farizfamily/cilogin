			<ul class="breadcrumb">
				<li>
					<a href="#"><?php echo $this->uri->rsegment(1);?></a> <span class="divider">/</span>
				</li>
				<li>
					<a href="#"><?php echo $this->uri->rsegment(2);?></a> <span class="divider">/</span>
				</li>
				<li class="active">
					<?php echo $this->uri->rsegment(3);?>
				</li>
			</ul>
