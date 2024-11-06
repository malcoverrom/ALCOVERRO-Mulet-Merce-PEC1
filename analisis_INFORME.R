## -------------------------------------------
if (!require("readr", quietly = TRUE)) install.packages("readr")
dades <- read_csv("/Users/merce/Desktop/Master/Analisis de dades òmiques. PEC1/human_cachexia.csv")


## -------------------------------------------
str(dades)


## -------------------------------------------
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("SummarizedExperiment")
library(SummarizedExperiment)


## -------------------------------------------
colnames(dades)
dades_metadades <- dades[, 1:2] 
dades_matriu <- as.matrix(dades[, -c(1:2)]) 


## -------------------------------------------
dim(dades_metadades)
dim(dades_matriu)


## -------------------------------------------
SE<- SummarizedExperiment(assays = list(counts = dades_matriu), rowData = dades_metadades)
save(SE, file = "human_cachexia_data.Rda")


## -------------------------------------------
dim(SE)
head(assay(SE, "counts"))


## -------------------------------------------
rowData(SE)
colData(SE)
summary(assay(SE, "counts"))


## -------------------------------------------
df_comp <- data.frame(dades_metadades)
df_comp <- cbind(df_comp, dades_matriu)

dim(df_comp) 
head(df_comp) 


## -------------------------------------------
df_comp$Muscle.loss <- as.factor(df_comp$Muscle.loss)
str(df_comp$Muscle.loss)  


## -------------------------------------------
resultats_anova <- data.frame(Variable = character(), p_value = numeric(), stringsAsFactors = FALSE)


for (metabolit in colnames(dades_matriu)) {
    anova_result <- tryCatch({
        with(df_comp, aov(get(metabolit) ~ Muscle.loss))
    }, error = function(e) {
        NULL
    })
    
   
    if (!is.null(anova_result)) {
        p_value <- summary(anova_result)[[1]][["Pr(>F)"]][1]
        
        resultats_anova <- rbind(resultats_anova, data.frame(Variable = metabolit, p_value = p_value))
    }
}


resultats_significatius <- subset(resultats_anova, p_value < 0.05)
print(resultats_significatius)


## -------------------------------------------
library(ggplot2)

for (metabolit in resultats_significatius$Variable) {
    p <- ggplot(df_comp, aes(x = Muscle.loss, y = .data[[metabolit]])) +
        geom_boxplot() +
        labs(title = paste("Distribució de", metabolit, "segons Muscle loss"),
             x = "Muscle loss",
             y = metabolit) +
        theme_minimal()
    
    print(p)
}


