library(shiny)

library(datasets)

shinyServer(function(input, output) {

    data <- reactive({
        dist <- switch(input$dist,
                       choise_all = choise_all,
                       choise_man = choise_man,
                       choise_aut = choise_aut,
                       choise_all)
        dist(input$minwt)
        dist(input$maxwt)
    })

    output$plot <- renderPlot({

        minwt <- input$minwt
        maxwt <- input$maxwt

        choise <- input$dist

        mpg <- mtcars$mpg [which(mtcars$wt >=minwt & mtcars$wt <= maxwt)]
        wt <- mtcars$wt [which(mtcars$wt >=minwt & mtcars$wt <= maxwt)]
        am <- mtcars$am[which(mtcars$wt >=minwt & mtcars$wt <= maxwt)]

        lm_all <- lm(mpg ~ wt)
        man_y <- mpg[which(am == 1)]
        man_x <- wt[which(am == 1)]

        aut_y <- mpg[which(am == 0)]
        aut_x <- wt[which(am == 0)]

        plot(wt,mpg,ylim=c(5,40),xlim=c(1,6),ylab=choise)

        if (choise != "choice_aut" & length(man_x) > 0){
            points(man_x,man_y,col="red")
            prediction <- predict(lm_all,data.frame(wt=man_x))
            segments(man_x, man_y, man_x, prediction,col="red")
        }

        if (choise != "choice_man" & length(aut_x) > 0){
            points(aut_x,aut_y,col="blue")
            prediction <- predict(lm_all,data.frame(wt=aut_x))
            segments(aut_x, aut_y, aut_x, prediction,col="blue")
        }

        abline(lm_all,col="black")

        if (choise == "choice_all") {
            models <- rownames(mtcars[which(mtcars$wt >=minwt & mtcars$wt <= maxwt),])
            mpgs <- mpg
            prediction <- predict(lm_all,data.frame(wt=wt))
            wts <- wt
        }
        else if (choise == "choice_aut") {
            models <- rownames(mtcars[which(mtcars$wt >=minwt & mtcars$wt <= maxwt & mtcars$am == 0),])
            mpgs <- mtcars[which(mtcars$wt >=minwt & mtcars$wt <= maxwt & mtcars$am == 0),'mpg']
            prediction <- predict(lm_all,data.frame(wt=aut_x))
            wts <- mtcars[which(mtcars$wt >=minwt & mtcars$wt <= maxwt & mtcars$am == 0),'wt']
        }
        else {
            models <- rownames(mtcars[which(mtcars$wt >=minwt & mtcars$wt <= maxwt & mtcars$am == 1),])
            mpgs <- mtcars[which(mtcars$wt >=minwt & mtcars$wt <= maxwt & mtcars$am == 1),'mpg']
            prediction <- predict(lm_all,data.frame(wt=man_x))
            wts <- mtcars[which(mtcars$wt >=minwt & mtcars$wt <= maxwt & mtcars$am == 1),'wt']
        }

        cars <- data.frame(matrix(models,ncol=1,nrow=length(models))
                           ,matrix(mpgs,ncol=1,nrow=length(mpgs))
                           ,matrix(prediction - mpgs,ncol=1,nrow=length(prediction))
                           ,matrix(wts,ncol=1,nrow=length(wts))
        )
        colnames(cars) <- c("Model","MPG","Delta","Weight")

        output$results <- renderTable({
            cars[with(cars, order(Delta)),]
        })
    })
})
