
min_in_rect <-function(mat_source, xa,ya, xb,yb){
  # Search for the smallest droop percentage
  xa = floor(xa)
  xb = floor(xb)
  ya = floor(ya)
  yb = floor(yb)
  cat ("\t(", xa, ",", ya, ") -> (", xb,",",yb,")" )
  MIN = mat_source[xa,ya]
  tx = xa
  ty = ya
  for(x in c(xa:xb)){
    for(y in c(ya:yb)){
#       cat(x,",", y,":",mat_source[x,y],"\n")
      if(mat_source[x,y] < MIN){
        MIN = mat_source[x,y]
        tx = x
        ty = y
      }
    }
  }
  cat("\t[min: " ,MIN, "@",tx,",",ty,"]\n")
  return(MIN)
}


max_in_rect <-function(mat_source, xa,ya, xb,yb){
  # Search for the smallest droop - closest to nominal - i.e largest VDD 
  xa = floor(xa)
  xb = floor(xb)
  ya = floor(ya)
  yb = floor(yb)
  cat ("\t(", xa, ",", ya, ") -> (", xb,",",yb,")" )
  MAX = mat_source[xa,ya]
  tx = xa
  ty = ya
  for(x in c(xa:xb)){
    for(y in c(ya:yb)){
      #       cat(x,",", y,":",mat_source[x,y],"\n")
      if(mat_source[x,y] > MAX){
        MAX = mat_source[x,y]
        tx = x
        ty = y
      }
    }
  }
  cat("\t[max: " ,MAX, "@",tx,",",ty,"]\n")
  return(MAX)
}

get_min_droop_tolerated <- function(Ndim,MAT){
  #taken from draw SM
  sm = 0
#   Ndim = 80
  sm_min = c()
  for (y in c(0.05,0.225)){
    for(x in c(0.05,0.275,0.5,0.725)){
      xa = (x*Ndim) + 1
      xb = xa + (0.225 * Ndim)
      ya = (y*Ndim) + 1
      yb = ya + (0.175*Ndim)
      cat ("SM:", sm)
#       sm_min <-c(sm_min,min_in_rect(MAT,xa,ya,xb,yb))
      sm_min <-c(sm_min,max_in_rect(MAT,xa,ya,xb,yb))
      sm = sm+1
    }
  }
  for(y in c(0.6,0.775)){
    for(x in c(0.05,0.275,0.5,0.725)){
      xa = (x*Ndim) + 1
      xb = xa + (0.225 * Ndim)
      ya = (y*Ndim) + 1
      yb = ya + (0.175*Ndim)
      cat ("SM:", sm)
#       sm_min <-c(sm_min,min_in_rect(MAT,xa,ya,xb,yb))    
      sm_min <-c(sm_min,max_in_rect(MAT,xa,ya,xb,yb))
      sm = sm+1
    }    
  } 
return (sm_min)
}
