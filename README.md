# getandcleandata
Repositório para o curso online 'Getting and Cleanin Data'.

O script 'run_analysis.R' le os arquivos: 'subject_test.txt', 'X_test.txt', 'y_test.txt', 'subject_train.txt', 'X_train.txt' e 'y_train.txt' que se encontram nas pastas 'test' e 'train' para criar as variáveis 'data.frame' para juntar os dois conjuntos de dados em um arquivo só chamado de 'full.data'

Considera-se que a pasta descompactada 'UCI HAR Dataset' se encontra no diretório raiz. Com o data.frame 'full.data' criado as colunas são nomeadas com as informações das propriedades medidas e calculadas que se encontram no arquivo 'features.txt'e são trocados os nomes das propriedades com as informações encontradas em 'activity_labels.txt'

Finalmente os dados são organizados para criar a tabela com os valores medios das propriedades medidas. O resultado é armazenado na variável 'tidy.data'
