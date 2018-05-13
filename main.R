library(igraph)
library(doParallel)


source("clique.community.R") #non-optimized implementation
source("clique.community.opt.R") #optimized implementation
source("clique.community.opt.par.R") #parallelised implementation


### Register Parallelisation (used by clique.community.opt.par())
cl <- makeCluster(4)
registerDoParallel(cl)
getDoParWorkers()


### Loading Benchmarks
#1 
g <- graph(c(1,2,1,3,1,4,2,3,3,4,4,5,4,6,5,6,5,8,5,7,6,8,6,7,7,8,7,9), directed=F)
#2
g <- make_graph("Zachary") #the karate network


#Execution of the different implementation of the algorithm
ptm <- proc.time()
res1<-clique.community(g,3)
proc.time() - ptm
ptm <- proc.time()
res2<-clique.community.opt(g,3)
proc.time() - ptm
ptm <- proc.time()
res3<-clique.community.opt.par(g,3)
proc.time() - ptm

identical(res1,res2)
identical(res2,res3)


### PLOT

#which one? the outcome is always the same
res <- res3

## Paint them to different colors
colbar <- rainbow( length(res)+1 )
for (i in seq(along=res)) {
  V(g)[ res[[i]] ]$color <- colbar[i+1]
}

## Paint the vertices in multiple communities to red
V(g)[ unlist(res)[ duplicated(unlist(res)) ] ]$color <- "red"

## Plot with the new colors
plot(g, layout=layout_with_fr, vertex.label=V(g)$name)


#REAL PERFORMANCE TEST
require(microbenchmark)
b1<-microbenchmark(t1<-clique.community(g,3),times = 100,unit = 'ms')
b2<-microbenchmark(t2<-clique.community.opt(g,3),times = 100,unit = 'ms')
b3<-microbenchmark(t2<-clique.community.opt.par(g,3),times = 100,unit = 'ms')
rbind(b1,b2,b3)
mean(b1$time)/mean(b2$time)
mean(b2$time)/mean(b3$time)
mean(b1$time)/mean(b3$time)