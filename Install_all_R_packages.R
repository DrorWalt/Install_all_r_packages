# Author: Dror Walter
# Find and install all libraries in drive
# Date: 2019/08/21

# THE FUNCTIONS - uses NO libraries

list_all_packages<-function(drive='C:/') {
  options(stringsAsFactors = FALSE)
  content_list<-list()
  Rfiles <- list.files(drive, pattern = "\\.R$", recursive = TRUE, full.names = TRUE)

  for (i in 1:length(Rfiles)) {
    tryCatch({
      content_list[[i]]=c(Rfiles[i],readChar(Rfiles[i], file.info(Rfiles[i])$size))
    },error = function(e){})
  }
  myDF<-data.frame(do.call(rbind,content_list))
  
  myDFresults<-regmatches(myDF$X2,
                          gregexpr("library(\\S+)|\\S+::",myDF$X2))
  
  myDFresults_vect<-unlist(myDFresults)
  myDFresults_vect<-unique(myDFresults_vect)
  
  myDFresults_vect2<-gsub("library","",myDFresults_vect)
   myDFresults_vect2<-gsub("::","",myDFresults_vect2)
  myDFresults_vect3<-gsub("[^A-Za-z0-9]","",myDFresults_vect2)
  
  
  return(myDFresults_vect3)
}

## run the function on your drive of choice- in my case "D"
toinstall<-list_all_packages("D:/")

## install that vector - minus existing packages
install.packages(setdiff(toinstall,as.vector(installed.packages()[,1])))

## PROFIT!
