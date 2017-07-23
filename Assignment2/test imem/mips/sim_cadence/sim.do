database -shm ncsim -default
#probe -create tb_top  -all  -database ncsim -depth all 
probe -create : -all -variables -database ncsim -depth all 
#probe -shm {:d0} -all -variables -database ncsim  
#run  
run 500ns 
exit
