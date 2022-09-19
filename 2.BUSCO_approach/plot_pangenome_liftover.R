### Thesis plots ###
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

#### 2pg p (A) ####
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
  ylab("Lift-over of BUSCO genes")+
  theme(legend.position="none")

#### 2pg s (B) ####
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
  ylab("Lift-over of BUSCO genes")+
  theme(legend.position="none")

#### 2pg asm ####
pg2_asm <- read_excel("2pg_asm.xlsx")
pg2_asm_summary <- data_summary(pg2_asm, varname="liftover",groupnames=c("asm","direction"))
(pg2_asm_summary)

pg2_asm_summary$asm <- factor(pg2_asm_summary$asm, levels=c("asm5", "asm10", "asm15", "asm20"))

plot_2pg_asm <- ggplot(pg2_asm_summary,
                     aes(x=as.factor(asm), 
                         y=liftover))+
  geom_bar(stat="identity", position ="dodge")+
  geom_errorbar(aes(ymin= liftover-sd, ymax= liftover+sd), width=.1, position=position_dodge(.9))+
  facet_grid(cols = vars(direction))+
  scale_fill_manual(values=colorsmt)+
  scale_y_continuous(labels = scales::percent, limits = c(0, 1))+
  xlab("POA parameter preset")+
  ylab("Lift-over of BUSCO genes")+
  theme(legend.position="none")

### BED vs start positions lift-over 2pg ###
BED_start <- read_excel("BED_start.xlsx")

plot_BED_start <- ggplot(BED_start,
                     aes(x=as.factor(p), 
                         y=liftover, fill=method))+
  geom_bar(stat="identity", position ="dodge")+
  geom_errorbar(aes(ymin= liftover-sd, ymax= liftover+sd), width=.1, position=position_dodge(.9))+
  facet_grid(cols = vars(direction))+
  scale_fill_manual(values=colorsmt)+
  scale_y_continuous(labels = scales::percent, limits = c(0, 1))+
  xlab("Minimum mapping identity [%]")+
  ylab("Lift-over of BUSCO genes")+
  theme(legend.position="right")
  
#### 6pg 4 parameter sets ####
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
  ylab("Lift-over of BUSCO genes")+
  theme(legend.position="none")

# for A4 size plots, all width 210 mm
ggsave(plot_2pg_p, file="2pg_A.svg", width= 210, height = 149, units = "mm")
ggsave(plot_2pg_s,file="2pg_B.svg", width= 210, height = 149, units = "mm")
ggsave(plot_6pg_4sets,file="6pg_4sets.png", width= 210, height = 149, units = "mm")
ggsave(plot_BED_start,file="BED_start_2pg.svg", width= 210, height = 149, units = "mm")
ggsave(plot_2pg_asm,file="2pg_asm.png", width= 210, height = 149, units = "mm")


