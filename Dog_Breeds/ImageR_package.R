# Package: Imager
# Test file

train_sample <- load.image('train_sample/000bec180eb18c7604dcecc8fe0dba07.jpg')

plot(train_sample)


# Convert to data.frame

sampleDF <- as.data.frame(trSampleAll[[1]])

summary(trSampleAll[[1]])
