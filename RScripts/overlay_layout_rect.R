overlay_layout_rect <- function(){
  #draw MC
  x = 0
  rect(0 + x, 0.05, 0.05+x, 0.95)
  x = 0.95
  rect(0 + x, 0.05, 0.05+x, 0.95)
  #draw IO
  y = 0
  rect(0,0 + y, 1, 0.05 +y)
  y = 0.95
  rect(0,0 + y, 1, 0.05 +y)
  #draw L2
  rect(0.05,0.4,0.95,0.6)
  
  #draw SM
  for (y in c(0.05,0.225)){
    for(x in c(0.05,0.275,0.5,0.725)){
      rect(x,y,x+0.225,y+0.175)
    }
  }
  for(y in c(0.6,0.775)){
    for(x in c(0.05,0.275,0.5,0.725)){
      rect(x,y,x+0.225,y+0.175)      
    }    
  }  
}