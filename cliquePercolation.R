clique.community <- function(graph, k) {
  clq <- cliques(graph, min=k, max=k)
  edges <- c()
  for (i in seq_along(clq)) {
    for (j in seq_along(clq)) {
      if ( length(unique(c(clq[[i]], clq[[j]]))) == k+1 ) {
        edges <- c(edges, c(i,j))
      }
    }
  }
  clq.graph <- simplify(graph(edges))
  V(clq.graph)$name <- seq_len(vcount(clq.graph))
  comps <- decompose.graph(clq.graph)
  
  lapply(comps, function(x) {
    unique(unlist(clq[ V(x)$name ]))
  })
}