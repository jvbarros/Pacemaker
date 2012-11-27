#######################################################################################
# Example Using R with GeoData and LinkGeoData
#######################################################################################

#####################################################################################
#SETTING ENVIRONMENT
#####################################################################################
rm(list = ls())
ls()

library("ggplot2")
library("RMySQL")

#####################################################################################
#IMPORTING DATA AND RECODING
#####################################################################################

######### if you are using MYSQL DATA BASE

# 1. Create a Connection

con <- dbConnect(MySQL(), user="jacson_barros", password="p8z77-v", dbname="susdb", host="ec2-50-19-4-203.compute-1.amazonaws.com")

sql <- "select  N_AIH, ANO_CMPT , MES_CMPT , DT_INTER, DT_SAIDA, DIAS_PERM, MUNIC_RES , 
                tab.UF, tab.nm_municipio, CEP , NASC , IDADE, SEXO , PROC_REA , DIAG_PRINC, DIAG_SECUN , 
                VAL_SH, VAL_SP , VAL_TOT , US_TOT 
          from T2010 aih , censodb.tab_municipio tab 
         where proc_rea in ( '0406010650', '0406010684')  
           and aih.munic_res = substr(tab.cd_municipio,1,6) LIMIT 10000;"

df <- dbGetQuery( con , sql)

head( df)

## Tips to use dbAply() -- > http://goo.gl/AXhSM

dbDisconnect(con)

## Summary by group UF

tapply(df$VAL_TOT, df$UF, summary)





