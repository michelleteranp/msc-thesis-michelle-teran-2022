### Thesis plots: lift-over of BUSCO genes in pangenomes constructed with different parameter settings ###
# navigate to working directory

library(readxl)
library(ggplot2)
library(plyr)

# function to calculate summary statistics
data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

# create color palet
colorsmt <- c("#0072B2","#009E73","#E69F00", "#CC79A7", "#999999", "#D55E00")
# To use for fills, add
#scale_fill_manual(values=colorsmt)
# To use for line and point colors, add
#scale_colour_manual(values=colorsmt)

#### Pangenomes with two genomes (B73AGPv04 and Mo18W) - parameter p [minimum percent identity] (A) ####
pg2_p <- read_excel("2pg_p.xlsx")
pg2_p_summary <- data_summary(pg2_p, varname="liftover",groupnames=c("p","direction"))
(pg2_p_summary)

plot_2pg_p <- ggplot(pg2_p_summary,
                     aes(x=as.factor(p), 
                         y=liftover))+
  geom_bar(stat="identity", position ="dodge")+
  geom_errorbar(aes(ymin= liftover-sd, ymax= liftover+sd), width=.1, position=position_dodge(.9))+
  facet_grid(cols = vars(direction))+
  scale_fill_manual(values=colorsmt)+
  scale_y_continuous(labels = scales::percent, limits = c(0, 1))+
  xlab("Minimum mapping identity [%]")+
  ylab("Liftover average")+
  theme(legend.position="none")

#### 2pg s [segment length] (B) ####
pg2_s <- read_excel("2pg_s.xlsx")
pg2_s_summary <- data_summary(pg2_s, varname="liftover",groupnames=c("s","direction"))
(pg2_s_summary)

plot_2pg_s <- ggplot(pg2_s_summary,
                     aes(x=as.factor(s/1000), 
                         y=liftover))+
  geom_bar(stat="identity", position ="dodge")+
  geom_errorbar(aes(ymin= liftover-sd, ymax= liftover+sd), width=.1, position=position_dodge(.9))+
  facet_grid(cols = vars(direction))+
  scale_fill_manual(values=colorsmt)+
  scale_y_continuous(labels = scales::percent, limits = c(0, 1))+
  xlab("Segment length in thousands")+
  ylab("Liftover average")+
  theme(legend.position="none")

#### Pangenomes with 6 genomes and 4 parameter sets ####
pg6_4sets <- read_excel("6pg_4sets.xlsx")
pg6_summary <- data_summary(pg6_4sets, varname="liftover",groupnames=c("set","direction"))
(pg6_summary)

pg6_summary$direction_f = factor(pg6_summary$direction, levels = c("B73 to Mo18W", "Mo18W to B73", "B73 to B97", "B97 to B73"))

plot_6pg_4sets <- ggplot(pg6_summary,
                     aes(x=as.factor(set), 
                         y=liftover))+
  geom_bar(stat="identity", position ="dodge")+
  geom_errorbar(aes(ymin= liftover-sd, ymax= liftover+sd), width=.1, position=position_dodge(.9))+
  facet_grid(cols = vars(direction_f))+
  scale_fill_manual(values=colorsmt)+
  scale_y_continuous(labels = scales::percent, limits = c(0, 1))+
  xlab("Parameter set")+
  ylab("Liftover of BUSCO genes")+
  theme(legend.position="none")

# for A4 size plots, all width 210 mm
ggsave(plot_2pg_p, file="2pg_A.svg", width= 210, height = 149, units = "mm")
ggsave(plot_2pg_s,file="2pg_B.svg", width= 210, height = 149, units = "mm")
ggsave(plot_6pg_4sets,file="6pg_4sets.png", width= 210, height = 149, units = "mm")
