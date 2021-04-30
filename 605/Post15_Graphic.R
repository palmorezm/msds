# Plotting 3d
# 2d plot displayed as 3d 
level <- function(t, c){
  10/(t^3) - 220*(t) + c
}
x <- y <- seq(-1, 1, length= 20)
z <- outer(x, y, level)
persp(x, y, z, col="aquamarine", shade = .25)
# It is a bit overkill since
# it could have been modeled in 2d
# As shown here with a similar function
curve(7800-1050/x^3-220*x, 0.5,35)

# However there is a time to make 3d plots
# Consider this example:

heart <- function(x, y){
  x^2 + y^2 + 2
}
x <- y <- seq(-1, 1, length= 150)
z <- outer(x, y, heart)
persp(x, y, z, col="magenta", shade = .05)

