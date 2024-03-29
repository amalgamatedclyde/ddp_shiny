shinyServer(function(input, output) {
  
  x <- seq(from=0, to=20, by=0.1)
  degree <- sample(seq(1:5), 1)
  constant <- 10
  deg5 <- unlist(sample(list(c(0.001, 0.1, 1, 0.4, 0.4), c(-0.001, 0.1, 1, 0.4, 0.4), c(-0.001, 0.1, 1, -20, 0.4)), 1))
  deg4 <- unlist(sample(list(c(0, 0.1, 1, 0.4, 0.4), c(0, 0.1, 1, 0.4, 0.4), c(0, 0.1, 1, -20, 0.4)), 1))
  deg3 <- unlist(sample(list(c(0, 0, 1, 0.4, 0.4), c(0, 0, 1, 0.4, 0.4), c(0, 0, 1, -20, 0.4)), 1))
  deg2 <- unlist(sample(list(c(0, 0, 0, 0.4, 0.4), c(0, 0, 0, 0.4, 0.4), c(0, 0, 0, -20, 0.4)), 1))
  deg1 <- unlist(sample(list(c(0, 0, 0, 0, 0.4), c(0, 0, 0, 0, 0.4), c(0, 0, 0, 0, 0.4)), 1))
  
  if(degree==5){
    a <- deg5[1]
    b <- deg5[2] 
    c <- deg5[3] 
    d <- deg5[4] 
    e <- deg5[5]  
  }
  if(degree==4){
    a <- deg4[1]
    b <- deg4[2] 
    c <- deg4[3] 
    d <- deg4[4] 
    e <- deg4[5]  
  }
  if(degree==3){
    a <- deg3[1]
    b <- deg3[2] 
    c <- deg3[3] 
    d <- deg3[4] 
    e <- deg3[5]  
  }
  if(degree==2){
    a <- deg2[1]
    b <- deg2[2] 
    c <- deg2[3] 
    d <- deg2[4] 
    e <- deg2[5]  
  }
  if(degree==1){
    a <- deg1[1]
    b <- deg1[2] 
    c <- deg1[3] 
    d <- deg1[4] 
    e <- deg1[5]  
  }
  y <-  a*(x)^5 + b*(x-10)^4 + c*(x-10)^3 + d*(x)^2 + c*(x) + constant

  output$plot1 <- renderPlot({
    # par(mar = c(5.1, 4.1, 0, 1))
    sd <- input$sd
    set.seed(314159)
    noise <- rnorm(length(x), mean=0, sd=sd)
    noisy.poly <- y + noise
    plot(x,noisy.poly,col='deepskyblue4',xlab='x',main='Polynomial With Normally Distributed Noise')
    model <- lm(noisy.poly ~ poly(x, as.integer(input$degree)))
    predicts <- predict(model, data.frame(x=x))
    rss <<- round(sum((residuals(model))^2))
    if(input$poly){
      legend("topleft",c("Observ.","Signal","Predicted"), col=c("deepskyblue4","red","green"), lwd=3)
      lines(x,y,col='firebrick1',lwd=3)
    }
    if(input$lm){
      predicted.intervals <- predict(model,data.frame(x=x),interval='confidence', level=0.99)
      lines(x,predicted.intervals[,1],col='green',lwd=3)
#       lines(x,predicted.intervals[,2],col='black',lwd=1)
#       lines(x,predicted.intervals[,3],col='black',lwd=1)
    }
  },height=600, width=600)

  
  # output$summ <- renderPrint(summary(lm(noisy.poly ~ poly(x, input$degree))))
#   predicts <- predict(model, data.frame(x=x))
#   rss <- sum((predicts-y)^2)
  # if(rss)makeReactiveBinding(rss)

    output$rss <- renderTable(if(input$show_rss){
      data.frame("Degree"= input$degree, "Noise"= input$sd,
                 "RSS" = format(round(rss,3), scientific = T))}, include.rownames = FALSE)
                                       
  
  
  # eventReactive(eventExpr, valueExpr, event.env = parent.frame(), event.quoted = FALSE, value.env = parent.frame(), value.quoted = FALSE, label = NULL, domain = getDefaultReactiveDomain(), ignoreNULL = TRUE)  

                           
  
})