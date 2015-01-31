<?php $this->load->view('header');?>
  <!-- BEGIN BORDERED TABLE widget-->
  <?php if(!empty($search)):?>
  <form><input type="search" placeholder="Search" class="input-large" name="searchs" value="<?php $this->input->get('searchs');?>"> <!-- input type="submit" class="btn" value="Search" --> </form>
  <?php endif;?>
                    <div class="widget">
                        <div class="widget-title">
                            <h4><i class="icon-reorder"></i> <?php echo $list_title;?></h4>
                        <span class="tools">
                        <a href="javascript:;" class="icon-chevron-down"></a>
                        <a href="javascript:;" class="icon-remove"></a>
                        </span>
                        </div>
                        <div class="widget-body">
							<?php if(empty($data)):?>
								<h5><?php echo $list_title;?></h5>
							<?php else: ?>
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
								<?php foreach($data[0] as $k=>$i):?>
									<?php 
										if(!in_array($k, $hidden_column)){
											echo "<th>".ucwords(str_replace('_',' ',$k))."</th>"; 
										}
										?>
								<?php endforeach;?>	
									<th>Links</th>
                                </tr>
                                </thead>
                                <tbody>
								<?php foreach($data as $i):?>
                                <tr>
									<?php foreach($i as $kk=>$ii):?>
										<?php
										if(!in_array($kk, $hidden_column)){
											echo "<td>".$ii."</td>"; 
										}	
											?>
									<?php endforeach;?>	
									<td>
									<?php if(!empty($links)): ?>
										<?php foreach($links as $ll):?>
										<a href="<?php echo $ll['link_uri'];?>
										<?php echo $i[$ll['key']];?>" <?php echo $ll['extra'];?> >
										<i class="<?php echo $ll['link_icon'];?>">
										</a><td>
										<?php endforeach;?>
									<?php endif; ?>
                                </tr>
								<?php endforeach;?>
                                </tbody>
                            </table>
							<?php endif;?>
                        </div>
                    </div>
                    <!-- END BORDERED TABLE widget-->
<?php $this->load->view('footer');?>