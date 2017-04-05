
#' @title cluster2pattern
#'
#' @description Function to make patterns of continuous weights from clusters. 
#' @param clusters an cluster object
#' @param NP number of desired patterns
#' @param Data data used to make clusters object
#' @export
#' @examples \dontrun{
#'  cluster2pattern(clusters,NP,Data)
#'}


cluster2pattern <- function(
  clusters=NA, # an cluster object
  NP=NA, # number of desired patterns
  Data=NA # data used to make clusters object
  ){
	UseMethod("cluster2pattern",clusters)
}

#' @title cluster2pattern (kmeans)
#'
#' @description Function to make patterns of continuous weights from kmeans clusters. 
#' @param clusters an kmeans cluster object
#' @param NP number of desired patterns
#' @param Data data used to make clusters object
#' @export
#' @examples \dontrun{
#'  cluster2pattern(clusters,NP,Data)
#'}

cluster2pattern.kmeans <- function(
  clusters=NA, # an kmeans object
  NP=NA, # number of desired patterns
  Data=NA # data used to make clusters object
  ){

  nD<-length(Patterns$size)
  nG<-dim(Data)[1]
  tempP<-matrix(data=rep(0,nD*nG),nrow = nG,ncol =nD)
  rownames(tempP)<-rownames(Data)
  #for(x in 1:nD) {tempP[Patterns$cluster==x,x]<-rowMeans(Data[Patterns$cluster==x,])}
  for(x in 1:nD) {tempP[Patterns$cluster==x,x]<-apply(Data[Patterns$cluster==x,],1,cor,y=colMeans(Data[Patterns$cluster==x,]))}
  Patterns<-tempP
  class(Patterns)<-append(class(Patterns),"pclust")
}

#' @title cluster2pattern (hclust)
#'
#' @description Function to make patterns of continuous weights from hierarchical clusters. 
#' @param clusters an hclust object
#' @param NP number of desired patterns
#' @param Data data used to make clusters object
#' @export
#' @examples \dontrun{
#'  cluster2pattern(clusters,NP,Data)
#'}

cluster2pattern.hclust <- function(
  clusters=NA, # an hclust object
  NP=NA, # number of desired patterns
  Data=NA # data used to make hclust object
  ){

#  if(is.na(PatternData)){stop("Data used to make hclust object must also be provided.")}
  cut=cutree(clusters,k=NP)
  nG<-dim(Data)[1]
  tempP<-matrix(data=rep(0,NP*nG),nrow = nG,ncol=NP)
  rownames(tempP)<-rownames(Data)
  #for(x in 1:NP) {tempP[cut==x,x]<-rowMeans(Data[cut==x,])}
  for(x in 1:NP) {tempP[cut==x,x]<-apply(Data[cut==x,],1,cor,y=colMeans(Data[cut==x,]))}
  Patterns<-tempP

 class(Patterns)<-append(class(Patterns),"pclust")

}