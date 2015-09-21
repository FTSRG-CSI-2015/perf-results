library(ggplot2)

path = "../results/"

result.file.names <- list.files(path = path)

results <- lapply(result.file.names, function(file.name){
  result <- read.csv(paste(path, file.name, sep = ""))
  stopifnot(colnames(result) == c("document.ID.1", "document.ID.2",
                                  "experiment.ID", "processing.time",
                                  "team.name"))
  result
})

full <- do.call(rbind, results)
write.csv(full, file="full.csv", row.names = T)

base <- ggplot(full)
base + geom_boxplot(aes(team.name, processing.time))
