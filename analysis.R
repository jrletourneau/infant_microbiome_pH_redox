# NICU pH and redox

library(tidyverse)

setwd("C:/Users/jeffr/Box Sync/project_davidlab/LAD_LAB_Personnel/Jeff/2 NICU/")
data <- read.csv("preliminary data 12-10-19.csv")
data[data$Subject=="PHO8", "Subject"] <- "PH08"

pr.plot <- ggplot(data=data, aes(x=Microlipid, y=pH, group=Subject)) +
  geom_point() + geom_line() #+
#  facet_wrap(~Subject, scales="free") + labs(x="Day of life (DOL)")
pr.plot
#ggsave("./figures/pH by DOL for each subject.svg", pr.plot, width=7, height=5)

pr2.plot <- ggplot(data=data, aes(x=DOL, y=redox, group=Subject)) +
  geom_point() + geom_line() +
 facet_wrap(~Subject, scales="free") + labs(x="Day of life (DOL)")
pr2.plot
#ggsave("./figures/redox by DOL for each subject.svg", pr2.plot, width=7, height=5)

corr6 <- cor.test(x=data$redox, y=data$pH, method = 'pearson')
corr6
# data:  data$redox and data$pH
# t = -0.27928, df = 69, p-value = 0.7809
# cor -0.03360208

pr3.plot <- ggplot(data=data, aes(x=pH, y=redox, group=Subject, color=Subject)) +
  geom_point() +
  annotate("text", x = 7, y = 350, label = "Pearson's r = -0.034\np = 0.781")
#+ facet_wrap(~Subject, scales="free")
pr3.plot
#ggsave("./figures/redox by pH.svg", pr3.plot, width=7, height=5)

subs <- unique(data$Subject)
data$pr.cor <- NA
data$pr.pval <- NA
for(sub in subs) {
  try(data[data$Subject==sub, "pr.cor"] <- cor.test(x=data[data$Subject==sub,"redox"],
                                                    y=data[data$Subject==sub,"pH"],
                                                    method = 'pearson')[4][[1]])
  try(data[data$Subject==sub, "pr.pval"] <- cor.test(x=data[data$Subject==sub,"redox"],
                                                    y=data[data$Subject==sub,"pH"],
                                                    method = 'pearson')[3])
}

labs <- unique(data$pr.cor)
labs <- c(labs[1:9], NA, labs[10]) 
labs.x <- c(6.8, 6, 6.75, 6, 6, 6, 7, 6.4, 7, 6.1, 6)
labs.y <- c(200, 200, 50, 150, 150, 230, 150, -100, -150, 180, 50)
subs <- as.character(subs)
labs.df <- data.frame(x=labs.x, y=labs.y, lab=round(labs,3), color=subs)

pr4.plot <- ggplot(data=data, aes(x=pH, y=redox, color=Subject)) +
  geom_point() +   facet_wrap(~Subject, scales="free") 
pr4.plot
#ggsave("./figures/redox by pH by subject.svg", pr4.plot, width=7, height=5)

pr5.plot <- ggplot(data=data, aes(x=Subject, y=pr.cor, color=Wt)) +
  geom_point(position=position_jitter()) 
pr5.plot

wt.plot <- ggplot(data=data, aes(x=cga, y=Wt, color=feedintol)) +
  geom_point() + geom_line() + facet_wrap(~Subject)
wt.plot



# Aggregate pH and redox
pH.data <- aggregate(x = data$pH, by = list(data$Subject, data$BGA, data$bw, data$matabx),
                     FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x)))
pH.data <- do.call(data.frame, pH.data)
pH.data$se <- pH.data$x.sd / sqrt(pH.data$x.n)
colnames(pH.data) <- c("Subject", "BGA", "bw", "matabx", "pH", "sd", "n", "se")

redox.data <- aggregate(x = data$redox, by = list(data$Subject, data$BGA, data$bw, data$matabx),
                     FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x)))
redox.data <- do.call(data.frame, redox.data)
redox.data$se <- redox.data$x.sd / sqrt(redox.data$x.n)
colnames(redox.data) <- c("Subject", "BGA", "bw", "matabx", "redox", "sd", "n", "se")

# Graph correlations 
corr <- cor.test(x=pH.data$pH, y=pH.data$BGA, method = 'pearson')
corr
# data:  pH.data$pH and pH.data$BGA
# t = -2.438, df = 9, p-value = 0.03749
# cor -0.6306714 

cor.plot <- ggplot(data=pH.data, aes(x=BGA, y=pH, label=Subject)) +
  geom_point() + labs(x="Birth gestational age (BGA)", y="Average pH") +
  annotate("text", x = 32.5, y = 6.5, label = "Pearson's r = -0.631\np = 0.037") + 
  geom_text(aes(label=Subject),hjust=0, vjust=0)
cor.plot

#ggsave("./figures/pH by BGA.svg", cor.plot, width=5, height=4)

corr3 <- cor.test(x=pH.data$pH, y=pH.data$bw, method = 'pearson')
corr3
# data:  pH.data$pH and pH.data$bw
# t = -2.3912, df = 9, p-value = 0.04048
# cor -0.623295

cor3.plot <- ggplot(data=pH.data, aes(x=bw, y=pH)) +
  geom_point() + labs(x="Birth weight (g)", y="Average pH") +
  annotate("text", x = 1200, y = 6.75, label = "Pearson's r = -0.623\np = 0.040")
cor3.plot

#ggsave("./figures/pH by bw.svg", cor3.plot, width=5, height=4)

corr2 <- cor.test(x=redox.data$redox, y=redox.data$BGA, method = 'pearson')
corr2
# data:  redox.data$redox and redox.data$BGA
# t = 2.4801, df = 8, p-value = 0.0381
# cor 0.6592939 

cor2.plot <- ggplot(data=redox.data, aes(x=BGA, y=redox)) +
  geom_point() + labs(x="Birth gestational age (BGA)", y="Average redox") +
  annotate("text", x = 32.5, y = 6.5, label = "Pearson's r = 0.659\np = 0.038")
cor2.plot

#ggsave("./figures/redox by BGA.svg", cor2.plot, width=5, height=4)

corr4 <- cor.test(x=redox.data$redox, y=redox.data$bw, method = 'pearson')
corr4
# data:  redox.data$redox and redox.data$bw
# t = 1.1625, df = 8, p-value = 0.2786
# cor 0.3801388 

cor4.plot <- ggplot(data=redox.data, aes(x=bw, y=redox)) +
  geom_point() + labs(x="Birth weight (g)", y="Average redox") +
  annotate("text", x = 1000, y = 150, label = "Pearson's r = 0.380\np = 0.279")
cor4.plot

#ggsave("./figures/redox by bw.svg", cor4.plot, width=5, height=4)

corr5 <- cor.test(x=redox.data$bw, y=redox.data$BGA, method = 'pearson')
corr5
# data:  redox.data$bw and redox.data$BGA
# t = 2.6256, df = 9, p-value = 0.02756
# cor 0.6585896

cor5.plot <- ggplot(data=redox.data, aes(x=BGA, y=bw)) +
  geom_point() + labs(x="Birth gestational age (BGA)", y="Birth weight (g)") +
  annotate("text", x = 32.5, y = 1000, label = "Pearson's r = 0.659\np = 0.028")
cor5.plot

#ggsave("./figures/bw by BGA.svg", cor5.plot, width=5, height=4)


# Maternal antibiotic use - pH
mabx.pH <- aggregate(x = pH.data$pH, by = list(pH.data$matabx),
                     FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x)))
mabx.pH <- do.call(data.frame, mabx.pH)
mabx.pH$se <- mabx.pH$x.sd / sqrt(mabx.pH$x.n)
colnames(mabx.pH) <- c("matabx", "pH", "sd", "n", "se")

mabx.pH.plot <- ggplot(mabx.pH, aes(x=matabx, y=pH)) +
  geom_errorbar(aes(ymin=pH, ymax=pH), width=0.5) +
  geom_errorbar(aes(ymin=pH-se, ymax=pH+se), width=0.25) +
  geom_point(data=pH.data, aes(x=matabx, y=pH))
mabx.pH.plot


# Maternal antibiotic use - redox
mabx.rdx <- aggregate(x = redox.data$redox, by = list(redox.data$matabx),
                     FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x)))
mabx.rdx <- do.call(data.frame, mabx.rdx)
mabx.rdx$se <- mabx.rdx$x.sd / sqrt(mabx.rdx$x.n)
colnames(mabx.rdx) <- c("matabx", "redox", "sd", "n", "se")

mabx.rdx.plot <- ggplot(mabx.rdx, aes(x=matabx, y=redox)) +
  geom_errorbar(aes(ymin=redox, ymax=redox), width=0.5) +
  geom_errorbar(aes(ymin=redox-se, ymax=redox+se), width=0.25) +
  geom_point(data=redox.data, aes(x=matabx, y=redox))
mabx.rdx.plot


