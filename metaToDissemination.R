meta.df = read.csv(file = "meta_data_new.csv", header = TRUE,
  stringsAsFactors = FALSE)

fullMeta.df = subset(meta.df, subset = !is.na(SO) & !is.na(TOPIC) &
  (!is.na(SCORECARD_A) | !is.na(SCORECARD_B)) & (!is.na(ORDER_A) |
    !is.na(ORDER_B)))

if(any(duplicated(fullMeta.df)))
    stop("Duplicated DATA_KEY")

soSplitFile = function(data){
  so.lst = split(x = data, f = factor(data$SO))
  soNames = tolower(names(so.lst))
  for(i in seq_along(soNames)){
    cat(names(so.lst)[i], ":", NROW(so.lst[[i]]), "variables. \n")
    write.csv(so.lst[[i]],
              file = paste0("./dashboard_", soNames[i], "/",
              soNames[i], "_dissemination.csv"), row.names = FALSE,
              na = "")
  }
}

soSplitFile(fullMeta.df)
