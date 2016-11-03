apl<-function(vdd_list, vth_list, alpha, constant){
  if(is.loaded("alpha_power_law"))
  		dyn.unload("alpha_Delay.so")
	dyn.load("alpha_Delay.so")

	# convert to single precision, because CUDA kernel may be written using floats
	# mode(vdd_list) <- "single"
	# mode(vth_list) <- "single"
	# mode(alpha) <- "single"
	# mode(constant) <- "single"
	vdd_length = length(vdd_list)
	vth_length = length(vth_list)
# 	print(vdd_length)
# 	print(vth_length)
# 	print(alpha)
# 	print(constant)
  
	delay_length = vdd_length * vth_length
	delay_vec = rep(1.0,delay_length)
	# mode(delay_vec) <- "single"
# 	print(length(delay_vec))
	res<-.C("alpha_power_law",vdd_list,vth_list, alpha, constant, delay_vec, as.integer(vdd_length), as.integer(vth_length))
	# In R, a matrix is stored by column in the memory. In C, a matrix is stored by the rown in memory. So we need to transpose any matrix 
	# x, namely t(x) before transforming to vector for C function.
	# When transforming back a matrix from C in vector form to matrix in R, we have to use matrix()function.
	# In C, matrix is stored by row. So when transforming back, we need to specify byrow =T
	out <- matrix(unlist(res[5]), ncol = vth_length, byrow = TRUE)
	# attr(out,"Csingle") <-NULL
	return(out)
}
