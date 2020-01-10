# R语言人脸识别


无意中在[R-bloggers](https://www.r-bloggers.com/)上看到了一篇~~终于可以自己操作的~~[关于人脸识别的文章](https://www.r-bloggers.com/human-face-detection-with-r/)！自己也来试了试，嘿嘿，这小猪脸也被识别成人脸了，猪年就是不一样呀！

![抓猪炫](https://github.com/hoasxyz/mdphotos/raw/master/Terry%20Lin/%E6%8A%93%E7%8C%AA%E7%82%AB.jpeg)

<!--more-->

安装的两个包都挺大的，感觉这个[项目](https://github.com/bnosac/image)不只有人脸识别。

以下的代码还得学习呀！

```c
# install.packages("magick")
# install.packages("image.libfacedetection", repos = "https://bnosac.github.io/drat")
library(magick)
library(image.libfacedetection)
image <- image_read("https://github.com/hoasxyz/mdphotos/raw/master/Terry%20Lin/%E6%8A%93%E7%8C%AA%E7%82%AB.jpg")
faces <- image_detect_faces(image)
faces
plot(faces, image, border = "red", lwd = 7, col = "white")

allfaces <- Map(
  x      = faces$detections$x,
  y      = faces$detections$y,
  width  = faces$detections$width,
  height = faces$detections$height,
  f = function(x, y, width, height){
    image_crop(image, geometry_area(x = x, y = y, width = width, height = height))
  })
allfaces <- do.call(c, allfaces)
allfaces
```

`allfaces`是出了一个动态图，具体的操作都很简单，这里就不贴了。