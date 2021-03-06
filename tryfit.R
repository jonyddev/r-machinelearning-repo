library(glmnet)
library(e1071)
#1500
numTrain <- 299

cvfit = cv.glmnet(densYchanA[1:numTrain, ], threshA[1:numTrain, 1])
predicted <- predict(cvfit, newx = densYchanA[-(1:numTrain),], s = "lambda.min")
rmse <- sqrt(mean((predicted - threshA[-(1:numTrain), 1])^2))

par(mfrow = c(4,5))
i <- 0
for (i in (numTrain+1):length(samples))
{
    plot(
         samples[[i]][[population]]@densitiesA[[as.character(numFeatures)]]$x,
         samples[[i]][[population]]@densitiesA[[as.character(numFeatures)]]$y,
         type = 'o'
        );
    abline(v = threshA[i, 1], col = 'red', lwd = 2, lty = 2)
    abline(v = predicted[i-299], col = 'blue', lwd = 2, lty = 2)

    if ((i - numTrain) %% 20 == 0)
    {
        readline()
    }

}
