clique.community.opt.par <- function(graph, k){
  
  if(!require(foreach)){
    install.packages("foreach")
    library(foreach)
  }
  
  ###################################
  ### STEP #1: Clique discovery
  ###################################

  clq <- cliques(graph, min=k, max=k)
  
  
  ###################################
  ### STEP #2: Clique-graph creation
  ###################################

  #find edges between cliques
  edges <- c()
  edges <- foreach (i=1:(length(clq)-1), .combine=c) %dopar% 
  {
    tmp_edg <- c()
    for (j in (i+1):length(clq)) {
      if ( length(unique(c(clq[[i]], clq[[j]]))) == k+1 ) {
        tmp_edg <- c(tmp_edg, c(i,j))
      }
    }
    return(tmp_edg)
  }

  #Create an empty graph and then adding edges
  clq.graph <- make_empty_graph(n = length(clq)) %>% add_edges(edges)
  clq.graph <- simplify(clq.graph)
  V(clq.graph)$name <- seq_len(vcount(clq.graph))
  
  
  comps <- decompose.graph(clq.graph)
  
  lapply(comps, function(x) {
    unique(unlist(clq[ V(x)$name ]))
  })
}


