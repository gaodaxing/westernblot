if(!require(magick)) install.packages("magick")
library(magick)
library(psych)
title="WB for STING in BJ cells"
antibody1="STING"
antibody2="Tubulin"
path1="/Volumes/USB/AI600 images/dx20180913DBR1 2018.09.13_11.53.09_Ch/dx20180913DBR1 2018.09.13_11.53.09_Ch+Marker.jpg"##crop the image first
path2="/Volumes/USB/AI600 images/dx20180913DBR1 2018.09.13_11.53.09_Ch/dx20180913DBR1 2018.09.13_11.53.09_Ch+Marker.jpg"
##add more antiodies
lanes=read.clipboard.tab()
lane=nrow(lanes)
blot1=image_read(path1)
blot1=image_scale(blot1,geometry_area(width=350))
blot1=image_border(blot1,"white","x20")
blot2=image_read(path2)
blot2=image_scale(blot2,geometry_area(width=350))
##blot2=image_border(blot2,"white","x20")
blots=c(blot1,blot2)
blot=image_append(blots,stack=T)

blot=image_border(blot,"white","150x260")##blank area size
blot=image_annotate(blot,title,size = 30,gravity="north")##title of western blot
blot=image_annotate(blot,paste("IB:",antibody1),size = 20,location="+20+280")##adjust "antibody" location
blot=image_annotate(blot,paste("IB:",antibody2),size = 20,location="+20+380")
for(i in 1:lane){
  blot=image_annotate(blot,as.character(lanes[i,1]),size=20,degrees=-90,location=paste("+",i*20+155,"+250",sep=""))##i*20+150 horizontal position
}

image_write(blot,paste(title, format(Sys.time(), "%b %d %Y")),format = "png",quality=100)
