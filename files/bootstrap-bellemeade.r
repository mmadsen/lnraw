
# Bootstrap confidence intervals for Slatkin test
# 
# Embedded data:
# Data:  Belle Meade decorated ceramic frequencies (Lipo dissertation 2000)
# Data:  Steele et al. 2010, Journal of Archaeological Science 37, 1348–1358, tables 1 and 2
#
# Requires:  modified Slatkin program "slatkin-pe-only" using Madsen's modified source (github.com/mmadsen/SAA2012)
# Requires:  ggplot2, Rmisc libraries
# 
# (c) 2012 Mark E. Madsen, Creative Commons Attribution-Sharealike 3.0 license
#  http://creativecommons.org/licenses/by-sa/3.0/


setwd("~/Dropbox/Research/Dissertation Project/analysis/slatkin-power")
library("Rmisc")
library("ggplot2")

# The following are the frequencies of decorated ceramic types from the Belle Meade site, from Lipo's 2000 
# dissertation recollection.  The frequencies are aggregated from all collection units.  
bm_freq <- c(0.594, 0.295, 0.022, 0.009, 0.022, 0.010, 0.019, 0.011, 0.008, 0.002, 0.004, 0.002, 0.002)
steele_ost3 <- c(0.25862069,0.056034483,0.512931034,0.046695402,0.070402299,0.011494253,0,0.025143678,0.018678161)


bootslatkin <- function(repl, ssize, freqvec) {
  pe <- numeric(repl)
  # timing code
  ptm <- proc.time()
  
  for(i in 1:repl) {
    s <- sample(length(freqvec), ssize, replace=T, prob=freqvec)
    freq <- tabulate(s)
    cmd <- paste("~/bin/slatkin-pe-only 100000 ", paste(freq, collapse=" ")) 
    pe[i] <- as.numeric(system(cmd, intern=T))
  }
  
  # elapsed time
  # print(proc.time() - ptm)
  pe
}

bootstrap_for_ssvector <- function(repl, ssvec, freqvec) {
  mean <- numeric(length(ssvec))
  cint_low <- numeric(length(ssvec))
  cint_high <- numeric(length(ssvec))
  
  for(j in 1:length(ssvec)) {
    ss <- ssvec[j]
    bs <- bootslatkin(repl, ss, freqvec) 
    print(paste("Sample Size: ", ss))
    ci <- CI(bs, ci=0.95)
    cint_low[j] <- ci["lower"]
    cint_high[j] <- ci["upper"]
    mean[j] <- ci["mean"]
    
  } 
  df <- data.frame(cbind(ssvec, mean, cint_low, cint_high))
  df
}




replicates <- 1000
#samsize <- c(5, 10, 20)
#samsize <- c(20, 50, 100, 200, 500)
# The latter is going to take several hours to finish, start overnight
samsize <- c(20, 40, 60, 80, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1500)

ptm <- proc.time()

mean_pe <- bootstrap_for_ssvector(replicates,samsize,bm_freq)

errorbars <- aes(ymax = mean_pe$cint_high , ymin = mean_pe$cint_low )
unscaled_title <- "Bootstrapped Slatkin P_e by Sample Size"
u <- ggplot(mean_pe, aes(x = ssvec, y = mean)) 
u + geom_line() + scale_x_continuous(name = "Sample Size") + scale_y_continuous(name = "Mean P_e", limits=c(0,1)) + opts(title=unscaled_title) + geom_smooth(errorbars, stat="identity") 

ggsave(filename = "graphics/slatkin-bootstrap-mean-by-sample-size-bellemeade.pdf")


mean_pe_steele <- bootstrap_for_ssvector(replicates,samsize,steele_ost3)

errorbars <- aes(ymax = mean_pe_steele$cint_high , ymin = mean_pe_steele$cint_low )
unscaled_title <- "Bootstrapped Slatkin P_e by Sample Size"
u <- ggplot(mean_pe_steele, aes(x = ssvec, y = mean)) 
u + geom_line() + scale_x_continuous(name = "Sample Size") + scale_y_continuous(name = "Mean P_e", limits=c(0,1)) + opts(title=unscaled_title) + geom_smooth(errorbars, stat="identity")
ggsave(filename = "graphics/slatkin-bootstrap-mean-by-sample-size-steele-ost3.pdf")

print(proc.time() - ptm)