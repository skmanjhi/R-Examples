library(h2o)
localH2O = h2o.init()

# Run GLM of CAPSULE ~ AGE + RACE + PSA + DCAPS
prostatePath = system.file("extdata", "prostate.csv", package = "h2o")
prostate.hex = h2o.importFile(localH2O, path = prostatePath, key = "prostate.hex")
prostate.glm = h2o.glm(y = "CAPSULE", 
                       x = c("AGE","RACE","PSA","DCAPS"), 
                       data = prostate.hex, 
                       family = "binomial",
                       nfolds = 0, 
                       alpha = 0.5)

# Get fitted values of prostate dataset
prostate.fit = h2o.predict(object = prostate.glm, newdata = prostate.hex)
summary(prostate.fit)