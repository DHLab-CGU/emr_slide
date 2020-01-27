####################################################
# Install
####################################################

install.packages("devtools")
devtools::install_github("DHLab-CGU/emr")
library(emr)

####################################################
# Use case 1
####################################################
selectedPDA <- 
  selectCases(sample_MIMICIII, 
              SUBJECT_ID, ICD9_CODE, 
              ADMITTIME, "2015/10/01", 
              ICD, caseCondition = "^7470", 
              caseCount = 1, 
              CaseName = "PDA")
selectedPDA

elix <- 
  groupedDataLongToWide(
    sample_MIMICIII,SUBJECT_ID,
    ICD9_CODE,ADMITTIME, 
    "9999-10-01", groupDataType = Elix, 
    isDescription = T, 
    selectedCaseFile = selectedPDA)

library(tableone)
var_col <- 
  names(elix)[2:(length(elix)-1)]
table_Elix <- 
  CreateTableOne(vars = var_col,
                 strata = "selectedCase", 
                 data = as.data.frame(elix), 
                 factorVars = var_col)
table_Elix
####################################################
# Closer look
####################################################