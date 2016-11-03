
min_in_rect <-function(mat_source, xa,ya, xb,yb){
  xa = floor(xa)
  xb = floor(xb)
  ya = floor(ya)
  yb = floor(yb)
  MIN = mat_source[xa,ya]
  for(x in c(xa:xb)){
    for(y in c(ya:yb)){
#       cat(x,",", y,":",mat_source[x,y],"\n")
      if(mat_source[x,y] < MIN){
        MIN = mat_source[x,y]
        
      }
    }
  }
  print(MIN)
  return(MIN)
}

get_min_droop_tolerated <- function(N,MAT){
  #taken from draw SM
  sm = 0
#   N = 80
  for (y in c(0.05,0.225)){
    for(x in c(0.05,0.275,0.5,0.725)){
      xa = (x*N) + 1
      xb = xa + (0.225 * N)
      ya = (y*N) + 1
      yb = ya + (0.175*N)
      min_in_rect(MAT,xa,ya,xb,yb)
      cat ("SM:", sm)
      sm++
    }
  }
  for(y in c(0.6,0.775)){
    for(x in c(0.05,0.275,0.5,0.725)){
      xa = (x*N) + 1
      xb = xa + (0.225 * N)
      ya = (y*N) + 1
      yb = ya + (0.175*N)
      min_in_rect(MAT,xa,ya,xb,yb)      
      cat ("SM:", sm)
      sm++
    }    
  } 
}