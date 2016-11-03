nearest <- function(w,x){
  closestLoc = which(abs(w-x) == min(abs(w-x)))
  closestVal = w[which(abs(w-x) == min(abs(w-x)))]
  return(closestLoc)
}

 
power_plot <-function(spice_in, title_plot,colors,top){
    # filename = paste(title_plot,".pdf", sep="")
    # pdf(filename, width=16, height= 9)
    # par(mfrow=c(1,1),
    # oma = c(0,0,0,0),
    # mar=c(5,4,2,7),
    # cex=2)
    spice <- subset(spice_in, select = -c(Time))
    # colors = c("green", "cyan","blue", "red")
    #   par(mfrow=c(4,4), oma = c( 0, 0, 2, 0 ) )
    colnames <-dimnames(spice)[[2]]
    mx=mean(spice[[1]])
    for(i in 1:1){
        mx=mean(spice[[i]])
        h <- hist(spice[[i]]+0.05, breaks=50, plot = F)
        h$density = h$counts/sum(h$counts) * 100
        ymax = max(h$count)
        minVg = 0.85
        maxVg = 1.1
        y5max_percent = 30
        # title_plot = paste(title_plot , colnames[i])
        if(exists("m_droop")==FALSE){
            plot(h, freq=TRUE, ylab='', 
                main ='', 
                col = colors[1], 
                xlab='Voltage',yaxt="n",
                xlim=c(minVg,maxVg), ylim=c(0,ymax))
            # axis(side=2, line=1, col = colors[1])
            axis(side=4, line=1, col = colors[1])
            # par(new=TRUE)
            # plot(x = h$mids, y=h$density, 
            #     type="l", lwd =6, xaxt="n", yaxt="n", 
            #     xlab="", ylab="", col = colors[3], 
            #     xlim=c(minVg,maxVg))
            # axis(side=4, col = colors[3], line=1)
        }

        if(exists("m_droop")==TRUE){
            variation <- hist(m_droop[[1]], breaks=10, plot = F)
            plot(variation, 
                freq=TRUE, 
                col = colors[2],
                xlim=c(minVg,maxVg), ylim=c(0,6),xaxt="n", yaxt="n",
                xlab='',
                ylab='',
                main='')
            axis(side=2, line=1, col = colors[2])
            par(new=TRUE)
            if(top==TRUE){
                plot(h, freq=TRUE, ylab='', 
                    col = colors[1], yaxt="n",xaxt="n",
                    xlab='',main='',
                    xlim=c(minVg,maxVg), ylim=c(0,ymax))
                    axis(side=4, line=2, col = colors[1])
                }else{
                    plot(h, freq=TRUE, ylab='', 
                    col = colors[1], yaxt="n",
                    xlab='',main='',
                    xlim=c(minVg,maxVg), 
                    ylim=c(0,ymax))

                    axis(side=4, line=NA, col = colors[1])
                }
            
            # par(new=TRUE)
            # plot(x = h$mids, y=h$density, 
            #     type="l", lwd =6, xaxt="n", yaxt="n", 
            #     xlab="", ylab="", col = colors[3], 
            #     xlim=c(minVg,maxVg))
            # axis(side=4, col = colors[3], line=4)
        }
        
        abline(v=mx, col = colors[4], lwd = 6)
        # if(exists("m_droop")==TRUE){
        #     # legend("topleft", xjust=1, 
        #     #     col=colors,
        #     #     legend=c("Benchmarks' VDD Spread (Absolute)",
        #     #         "Histogram of SM' Minimum VDD Required",
        #     #         "Benchmarks' VDD Spread (%)", 
        #     #         "Benchmarks' Mean VDD")
        #     #     , lty=1, lw=10,cex = 0.6)
        #     legend("topleft", xjust=1, 
        #         col=c(colors[1],colors[2]),
        #         legend=c("Vdd Spread (Absolute)",
        #             "Histogram - Min. Vdd"),
        #             lty=1, lw=20,cex = 1.2)
        #     }else{
        #     #     legend("topleft", xjust=1, 
        #     #     col=c(colors[1],colors[3],colors[4]),
        #     #     legend=c("Benchmarks' VDD Spread (Absolute)",
        #     #         "Benchmarks' VDD Spread (%)", 
        #     #         "Benchmarks' Mean VDD")
        #     #     , lty=1, lw=10,cex = 1.2)
        #     # }
        #      legend("topleft", xjust=1, 
        #         col=c(colors[1],colors[4]),
        #         legend=c("VDD Spread (Absolute)",
        #             "Mean VDD")
        #         , lty=1, lw=10,cex = 1.2)
        #     }
        # minor.tick(nx=10, ny=10, tick.ratio = 0.5)
        # title(title_plot, cex=0.8)
        box()
    }
}