# CliquePercolationMethod-R
Clique Percolation Method (CPM) is an algorithm for finding overlapping communities within networks, intruduced by Palla et al. (2005, see references). This implementation in R, firstly detects communities of size k, then creates a clique graph. Each community will be represented by each connected component in the clique graph.

# Algorithm
The algorithm performs the following steps:

1- first find all cliques of size k in the graph <br />
2- then create graph where nodes are cliques of size k <br />
3- add edges if two nodes (cliques) share k-1 common nodes <br />
4- each connected component is a community <br />

# Main Implementations
* __clique.community.R__ : Basic implementation with some bug fix from an old version (see section *Notes*)
* __clique.community.opt.R__ : Optimized version with reduction of search space (see section *Notes*)
* __clique.community.opt.par.R__ : Optimization via parallelization (see section *Notes*)
 
It requires:
```
install.packages("igraph")
install.packages("doParallel")
install.packages("foreach")
```

# Further Notes
Additional info about this implemetation is available on: http://infernusweb.altervista.org/wp/?p=1479


# Results on an experiment
Using the Zachary network as a benchmark, and running the three implementations on a Processor	Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz, 2401 Mhz, 4 Core(s), 8 Logical Processor(s), it is possible to compare the elapsed of the different implementations:
```
> g <- make_graph("Zachary") #the karate network
> #Execution of the different implementation of the algorithm
> ptm <- proc.time()
> res1<-clique.community(g,3)
> proc.time() - ptm
   user  system elapsed 
   3.47    0.02    3.49 
> ptm <- proc.time()
> res2<-clique.community.opt(g,3)
> proc.time() - ptm
   user  system elapsed 
   1.78    0.00    1.78 
> ptm <- proc.time()
> res3<-clique.community.opt.par(g,3)
> proc.time() - ptm
   user  system elapsed 
   0.06    0.00    0.09 
```


# Reference
Palla, Gergely, Imre Derényi, Illés Farkas, and Tamás Vicsek. "Uncovering the overlapping community structure of complex networks in nature and society." Nature 435, no. 7043 (2005): 814-818.
