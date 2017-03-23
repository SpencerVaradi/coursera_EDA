
# Examples from week 2
# ggplot2 part 2
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ,hwy,data = mpg,
      geom = c("point","smooth"))

qplot(hwy, data = mpg, fill = drv)

qplot(displ, hwy, data = mpg, facets = drv ~ ., color = cyl,
      geom = c("point","smooth"))

qplot(displ, hwy, data = mpg, color = drv) +
  geom_smooth(method = "lm")

qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)


pal <- colorRamp(c("blue","green","white"))
pal(0)
pal(1)
pal(.7)
pal(.4)
pal(seq(0,1,len = 10))

pal <- colorRampPalette(c("red","yellow"))
pal(1)
pal(10)


library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
pal <- colorRampPalette(cols)
image(volcano, col=pal(4))

x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x,y)
