clique.community.opt <- function(graph, k){
	require(igraph)

  ###################################
  ### STEP #1: Clique discovery
  ###################################
  
  clq <- cliques(graph, min=k, max=k) %>% lapply(as.vector)

  
  ###################################
  ### STEP #2: Clique-graph creation
  ###################################
  
  #find edges between cliques
  edges <- c()
  for (i in 1:(length(clq)-1)) {
    for (j in (i+1):length(clq)) {
      if ( length(unique(c(clq[[i]], clq[[j]]))) == k+1 ) {
        edges[[length(edges)+1]] <- c(i,j)
      }
    }
  }
  
  #Create an empty graph and then adding edges
  clq.graph <- make_empty_graph(n = length(clq)) %>% add_edges(unlist(edges))
  clq.graph <- simplify(clq.graph)
  V(clq.graph)$name <- seq_len(vcount(clq.graph))
  
  
  comps <- decompose.graph(clq.graph)
  
  lapply(comps, function(x) {
    unique(unlist(clq[ V(x)$name ]))
  })
}
