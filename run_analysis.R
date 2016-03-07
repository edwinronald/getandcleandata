## ============================================================================

## Getting and Cleaning Data
## Curso online da Universidade Johns Hopkins por meio da plataforma Coursera
## Script criado para o tratamento de dados obtidos experimentalmente. Ele lê,
## organiza e apresenta os dados fornecidos na seção 'Assignments' referente ao
## Projeto do Curso
## Author: Edwin Campos / 07 de Março de 2016

## ============================================================================

## PARTE 1: Merges the training and the test sets to create one data set

## Criando as variaveis a partir dos dados fornecidos em 'test'

## Conjunto de dados para 'test'

x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")

## Conjunto de atividades para 'test'

y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")

## The subject who performed the activity in 'test'

s.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Criando as variáveis a partir dos dados fornecidos em 'train'

## Conjunto de dados para 'train'

x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")

## Conjunto de atividades para 'train'

y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## The subject who performed the activity in 'train'

s.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Juntando os dados em 'test'

data.test <- cbind(s.test, y.test, x.test)

## Juntando os dados em 'train'

data.train <- cbind(s.train, y.train, x.train)

## Juntando todos os dados: 'test' e 'train'

full.data <- rbind(data.test, data.train)

## Para identificar quais as propriedades medidas dentro de todo o conjunto de
## dados faz-se necessário obter os nomes das propriedades do arquivo 'features'
## e assignar esses nomes aos cabeçalhos das colunas

## Obtendo os nomes das propriedades medidas em 'features'

features.data <- read.table("./UCI HAR Dataset/features.txt")

## Criando um vetor com os nomes das propriedades

chr.features <- as.character(features.data$V2)

## Nomeando as colunas dos dados

colnames(full.data) <- c("Subject", "Activity", chr.features)

## PARTE 4: Appropriately labels the data set with descriptive variable names

## Criando um vetor com as posições que contem essas propriedades

## Carregando a libraria

library(stringr)

## Para os nomes que contem 'mean'

mean.nomes <- grep("-mean()[^?F]", chr.features, value = FALSE)

## Para os nomes que contem 'std'

std.nomes <- grep("-std()", chr.features, value = FALSE)

## Criando o vetor com todas as posições e ordenando os valores

meanstd.nomes <- sort(c(mean.nomes, std.nomes))

## ============================================================================

## PARTE 2: Extracts only the measurements on the mean and standard deviation
## for each measurement

## Para extrair unicamente osa dados contendo a media e o desvio padrão foi 
## necesário conhecer quais os numeros das colunas que contem essas propriedades

## Subtraindo os dados de interesse

meanstd.data <- subset(full.data, select = c(1, 2, meanstd.nomes + 2))

## ============================================================================

## PARTE 3: Uses descriptive activity names to name the activities in the data
## set

## Para identificar melhor os dados é necessário renomear as atividades que se
## encontram apenas numeradas no conjunto de dados fazendo uso das informações
## contidas em 'activity_labels'

## Trocando os numeros de identificação das atividades por nomes

meanstd.data$Activity[meanstd.data$Activity == 1] <- "Walking"

meanstd.data$Activity[meanstd.data$Activity == 2] <- "Walking Upstairs"

meanstd.data$Activity[meanstd.data$Activity == 3] <- "Walking Downstairs"

meanstd.data$Activity[meanstd.data$Activity == 4] <- "Sitting"

meanstd.data$Activity[meanstd.data$Activity == 5] <- "Standing"

meanstd.data$Activity[meanstd.data$Activity == 6] <- "Laying"

## ============================================================================

## PARTE 5: From the data set in step 4, creates a second, independent tidy
## data set with the average of each variable for each activity and each subject

## Agrupando e ordenando o conjunto de dados para obter a media

ordered.data <- group_by(meanstd.data, Subject, Activity)

## Calculando a media dos dados

tidy.data <- summarise_each(ordered.data, funs(mean))

## Cirando arquivo com extensão '.txt'

write.table(tidy.data, file = "tidy.data.txt", row.names = FALSE)

## Visualizando os resultados

View(tidy.data)
