# CliquePercolationMethod-R
Clique Percolation Method (CPM) is a gephi plugin for finding overlapping communities. This method is used for finding overlapping communities, firstly by detecting communities of size k, then forming a clique graph based of cliques of size k. This plugin is designed to work with Gephi and will transform a graph to the clique graph of size k.

#Algorithm
The algorithm performs the following steps:

1- first find all cliques of size k in the graph <br />
2- then create graph where nodes are cliques of size k <br />
3- add edges if two nodes (cliques) share k-1 common nodes <br />
4- each connected component is a community <br />

#Notes
An old and rather inefficient implementation of this algorithm can be found here: http://igraph.wikidot.com/community-detection-in-r#toc0
However, since version 0.6, vertices and edge are indexed from one in R iGraph and then that implementation produces the following error:
```
Error in .Call("R_igraph_create", as.numeric(edges) - 1, as.numeric(n),  : 
  At type_indexededgelist.c:117 : cannot create empty graph with negative number of vertices, Invalid value
In addition: Warning message:
In max(edges) : no non-missing arguments to max; returning -Inf
Called from: .Call("R_igraph_create", as.numeric(edges) - 1, as.numeric(n), 
    as.logical(directed), PACKAGE = "igraph")
```
The code here proposes a modified and working version with an example ready to be run.
And yet, the implementation is still inefficient due to the clique algorithm. 

#Reference
Palla, Gergely, Imre Derényi, Illés Farkas, and Tamás Vicsek. "Uncovering the overlapping community structure of complex networks in nature and society." Nature 435, no. 7043 (2005): 814-818.
