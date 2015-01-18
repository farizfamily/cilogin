<?php $this->load->view('header');?>
  <!-- BEGIN BORDERED TABLE widget-->
                    <div class="widget">
                        <div class="widget-title">
                            <h4><i class="icon-reorder"></i>Bordered Table</h4>
                        <span class="tools">
                        <a href="javascript:;" class="icon-chevron-down"></a>
                        <a href="javascript:;" class="icon-remove"></a>
                        </span>
                        </div>
                        <div class="widget-body">
							<?php if(empty($q)):?>
								<h5>Quoatation list empty</h5>
							<?php else: ?>
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
								<?php foreach($q[0] as $k=>$i):?>
									<th><?php echo ucwords(str_replace('_',' ',$k)); ?></th>
								<?php endforeach;?>	
									<th>
                                </tr>
                                </thead>
                                <tbody>
								<?php foreach($q as $i):?>
                                <tr>
									<?php foreach($i as $kk=>$ii):?>
										<td><?php echo $ii; ?></td>
									<?php endforeach;?>	
										<td><a href="<?php echo base_url();?><?php echo index_page();?>/quotation/create_quotation/?r34scrt8=<?php 
										echo $i['quotation_id'];?>"><i class="icon-folder-open"></a></td>

										<td><a href="<?php echo base_url();?><?php echo index_page();?>/quotation/delete_quotation/?r34scrt8=<?php 
										echo $i['quotation_id'];?>" onclick="return confirm('Are you sure you want to delete?')" ><i class="icon-remove"></a></td>

										
                                </tr>
								<?php endforeach;?>
                                </tbody>
                            </table>
							<?php endif;?>
                        </div>
                    </div>
                    <!-- END BORDERED TABLE widget-->
<?php $this->load->view('footer');?>