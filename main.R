library(igraph)
source("c")

g <- graph(c(1,2,1,3,1,4,2,3,3,4,4,5,4,6,5,6,5,8,5,7,6,8,6,7,7,8,7,9), directed=F)
plot(g)


res<-clique.community(g,3)


## Paint them to different colors
colbar <- rainbow( length(res)+1 )
for (i in seq(along=res)) {
  V(g)[ res[[i]] ]$color <- colbar[i+1]
}

## Paint the vertices in multiple communities to red
V(g)[ unlist(res)[ duplicated(unlist(res)) ] ]$color <- "red"

## Plot with the new colors
plot(g, layout=layout_with_fr, vertex.label=V(g)$name)
