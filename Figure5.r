library(forestplot)

workdir <- "."
datafile <- file.path(workdir,"Figure5.csv")

data <- read.csv(datafile, stringsAsFactors=FALSE,row.names=NULL)

## Combine the count and percent column
np <- ifelse(!is.na(data$case_group), paste(data$case_group," (",data$p_val,")",sep=""), NA)

## The rest of the columns in the table. 
tabletext <- cbind(c("Size/group",data$casecount),
                   c("Exposure\n group\n",data$controlcount),
                   c("Comparison\n group\n",data$blah),
                   c("# of cases (overall risk)\n(Exposure group)\n",data$case_group),
                   c("# of cases (overall risk)\n(Comparison group)\n",data$control_group),
                   
                   c("        HR (95% CI)",data$CI)
)

pdf(file.path(workdir,"Figure5.pdf"),  onefile=FALSE, width=16, height=7)

forestplot(labeltext=tabletext, 
           graphwidth = unit(90, 'mm'),
           graph.pos=6,
          
          is.summary=c(TRUE,TRUE,rep(FALSE, 6), TRUE,rep(FALSE,10)),
       
           mean=c(NA,data$RR), 
           lower=c(NA,data$down), upper=c(NA,data$up),

          title ="Five-year risk of incident pancreatic cancer in patients with type 2 diabetes, with and without tobacco use disorder \n(Comparison between propensity-score matched groups)", 

           #xticks = seq(exp(-0.26),exp(1.65),exp(0.06)), ###range of x axis
           #xticks = seq(0,2.25,0.25),
           xticks=log(c(0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3)),
           
           #xticks=10^(seq(-1,1,0.1)),
           xlog = TRUE,
            xlab="Hazard Ratio (HR)", ##name of x axis

           #### Add horizontal lines on the plot
           hrzl_lines=list("2" = gpar(lwd = 1.2, lty=1, col='black'),
                          "3" = gpar(lwd = 0.9, lty='longdash', col='black'),
                          "10" = gpar(lwd = 0.9, lty='longdash', col='black')
                         # "15" = gpar(lwd = 0.9, lty='longdash', col='black'),
                         # "21" = gpar(lwd = 0.9, lty='longdash', col='black')
                          #"10" = gpar(lwd = 0.9, lty='longdash', col='black'),
                          #"13" = gpar(lwd = 0.9, lty='longdash', col='black')
                          #"16" = gpar(lwd = 0.9, lty='longdash', col='black')
                           #"5" = gpar(lwd = 0.9, lty='longdash', col='black')
                          #"6" = gpar(lwd = 0.7, lty='longdash', col='black'),
                          #"10" = gpar(lwd = 0.9, lty=1, col='black'),
                          #"11" = gpar(lwd = 0.7, lty='longdash', col='black')
                           #"11" = gpar(lwd = 0.7, lty=5, col='black')
                           
           ),
          
          #txt_gp=fpTxtGp(label=list(gpar(cex=1.5,fontface='bold'),gpar(cex=1.5),gpar(cex=1.5),gpar(cex=1.5),gpar(cex=1.5),gpar(cex=1.5),gpar(cex=1.5)),
          txt_gp=fpTxtGp(label=list(gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9)),
                         ticks=gpar(cex=0.9),
                         xlab=gpar(cex=0.9,col='black',fontface='bold'),
                         #xlab=gpar(cex = 1.8),
                         title=gpar(cex = 1.3)),
          #clip=c(0.001, 4.5), 
          
          col=fpColors(box="black", lines="black", zero = "black"),
          lwd.zero = 001,
          lwd.xaxis = 0.7,
          mar = unit(c(0,0,0,0), "mm"),
          zero=1, cex=0.01, lineheight = unit(2, "mm"), boxsize=0.2, colgap=unit(3,"mm"),
          lwd.ci=0.8, ci.vertices=TRUE, ci.vertices.height = 0.15)

dev.off()

