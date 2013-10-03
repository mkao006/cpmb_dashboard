########################################################################
## Title: Full implementation of the FAO score card package
## Date: 2013-09-19
########################################################################

scorecardFAO = function(variable, data, file, startYear, endYear,
  baselineYear, layout = c("benchmark", "timeseries")){

  layout = match.arg(layout)

  ## Create the preembles of the latex document
  cat("\\documentclass{article}
       \\usepackage{faoscorecard}
       \\usepackage[left=0.2in,right=0.2in,top=.2in,bottom=1in]{geometry}
       \\renewcommand\\rmdefault{PTSansNarrow-TLF}
       \\makeatletter
       \\newcommand\\textsubscript[1]{\\@textsubscript{\\selectfont#1}}
       \\def\\@textsubscript#1{{\\m@th\\ensuremath{_{\\mbox{\\fontsize\\sf@size\\z@#1}}}}}
       \\newcommand\\textbothscript[2]{%
       \\@textbothscript{\\selectfont#1}{\\selectfont#2}}
       \\def\\@textbothscript#1#2{%
       {\\m@th\\ensuremath{%
       ^{\\mbox{\\fontsize\\sf@size\\z@#1}}%
       _{\\mbox{\\fontsize\\sf@size\\z@#2}}}}}
       \\def\\@super{^}\\def\\@sub{_}
       \\catcode`^\\active\\catcode`_\\active
       \\def\\@super@sub#1_#2{\\textbothscript{#1}{#2}}
       \\def\\@sub@super#1^#2{\\textbothscript{#2}{#1}}
       \\def\\@@super#1{\\@ifnextchar_{\\@super@sub{#1}}{\\textsuperscript{#1}}}
       \\def\\@@sub#1{\\@ifnextchar^{\\@sub@super{#1}}{\\textsubscript{#1}}}
       \\def^{\\let\\@next\\relax\\ifmmode\\@super\\else\\let\\@next\\@@super\\fi\\@next}
       \\def_{\\let\\@next\\relax\\ifmmode\\@sub\\else\\let\\@next\\@@sub\\fi\\@next}
     \\renewcommand\\scorecardname{Dashboard}
     \\renewcommand\\listofscorecardsname{List of Dashboards}
     \\makeatother
     \\begin{document}
     \\listofscorecards
     \\clearpage", file = file, append = FALSE)

  for(i in unique(data$areaCode)){
    print(unique(data[which(data$areaCode == i), "areaName"]))
    cat("\\clearpage", file = file, append = TRUE)
    if(layout == "benchmark"){
      cat("\\colorlet{scorecardcolor}{blue!50!pink}
           \\begin{scorecard}{lccccccc}
           \\caption{",
          unique(data[data$areaCode == i, "areaName"]),
          " Dashboard} \\\\
          \\scorecardcolhead{1}{c}{Indicator Name and unit} & 
          \\scorecardcolhead{2}{c}{Baseline} & 
          \\scorecardcolhead{2}{c}{Current} & 
          \\scorecardcolhead{1}{c}{Target} &
          \\scorecardcolhead{1}{c}{Trend} \\\\
          \\scorecardcolhead{1}{c}{} &
          \\scorecardcolhead{1}{c}{Value} & 
          \\scorecardcolhead{1}{c}{Year} & 
          \\scorecardcolhead{1}{c}{Value} & 
          \\scorecardcolhead{1}{c}{Year} &
          \\scorecardcolhead{1}{c}{} &
          \\scorecardcolhead{1}{c}{}
          \\endfirsthead
          \\caption[]{",
          unique(data[data$areaCode == i, "areaName"]),
          " Dashboard (continued)} \\\\
          \\scorecardcolhead{1}{c}{Indicator Name and unit} & 
          \\scorecardcolhead{2}{c}{Baseline} & 
          \\scorecardcolhead{2}{c}{Current} & 
          \\scorecardcolhead{1}{c}{Target} &
          \\scorecardcolhead{1}{c}{Trend} \\\\
          \\scorecardcolhead{1}{c}{} &
          \\scorecardcolhead{1}{c}{Value} & 
          \\scorecardcolhead{1}{c}{Year} & 
          \\scorecardcolhead{1}{c}{Value} & 
          \\scorecardcolhead{1}{c}{Year} &
          \\scorecardcolhead{1}{c}{} &
          \\scorecardcolhead{1}{c}{}
          \\endhead
          \\hline
          \\endfoot\n",
          file = file, append = TRUE)
      dataToScorecardsFAO(countryCode = i,
                          baselineYear = baselineYear,
                          startYear = startYear,
                          endYear = endYear,
                          data = data,
                          file = file,
                          variable = variable,
                          addPoints = FALSE,
                          layout = layout)
      cat("\n \\end{scorecard}",
          file = file, append = TRUE)    
    } else if(layout == "timeseries"){
      cat("\\colorlet{scorecardcolor}{magenta!50!yellow}
           \\small
           \\begin{scorecard}{>{\\raggedright}p{3cm}cccccccccccccc}
           \\caption{Trends for ",
          unique(data[data$areaCode == i, "areaName"]),
          "} \\\\
          \\scorecardcolhead{1}{c}{Indicator Name} &",
          paste("\\scorecardcolhead{1}{c}{", startYear:endYear, "}",
                sep = "", collapse = " &\n"),
          "& \\scorecardcolhead{1}{c}{Trend}

          \\endfirsthead
          \\caption[]{Trends for ",
          unique(data[data$areaCode == i, "areaName"]),
          " (continued)} \\\\
          \\scorecardcolhead{1}{c}{Indicator Name} &",
          paste("\\scorecardcolhead{1}{c}{", startYear:endYear, "}",
                sep = "", collapse = " &\n"),          
          "&\\scorecardcolhead{1}{c}{Trend} 
          \\endhead
          \\hline
          \\endfoot",
          file = file, append = TRUE)
      dataToScorecardsFAO(countryCode = i,
                          baselineYear = baselineYear,
                          startYear = startYear,
                          endYear = endYear,                          
                          data = data,
                          file = file,
                          variable = variable,
                          addPoints = FALSE,
                          layout = layout)
      cat("\n \\end{scorecard} ", file = file, append = TRUE)    
    }
  }
  cat("\n \\end{document}", file = file, append = TRUE)
}

dataToScorecardsFAO = function(countryCode, variable, data, file,
  startYear, endYear, baselineYear, layout, addPoints = FALSE){

  topic = ""
  for(i in variable){
    tmp.df = subset(data, areaCode == countryCode &
      variable == i & Year %in% startYear:endYear)
    if(topic != unique(tmp.df$topic)){
      topic = unique(tmp.df[tmp.df$variable == i, "topic"])
      cat(paste("\\scorecardsubhead{", topic, "}\\\\ \n"),
          file = file, append = TRUE)
    }
    cat(unique(tmp.df$indicatorName), file = file, append = TRUE)
    cat(" & ", file = file, append = TRUE)
    if(layout == "benchmark"){
      ## Print the baseline and current year
      baselineYear = unlist(subset(tmp.df[!is.na(tmp.df$value), ],
        Year == max(Year), select = Year))
      baseValue = unlist(subset(tmp.df[!is.na(tmp.df$value), ],
        Year == baselineYear, select = value))
      cat(ifelse(length(baseValue) == 0L, "",
                 formatC(baseValue, digits = 2, format = "fg")),
          file = file, append = TRUE)
      cat(" & ", file = file, append = TRUE)
      cat(baselineYear, file = file, append = TRUE)
      cat(" & ", file = file, append = TRUE)
      
      maxYear = unlist(subset(tmp.df[!is.na(tmp.df$value), ],
        Year == max(Year), select = Year))
      maxValue = unlist(subset(tmp.df[!is.na(tmp.df$value), ],
        Year == maxYear, select = value))
      cat(ifelse(length(maxValue) == 0L, "",
                 formatC(maxValue, digits = 2, format = "fg")),
          file = file, append = TRUE)
      cat(" & ", file = file, append = TRUE)      
      cat(maxYear, file = file, append = TRUE)
      cat(" & ", file = file, append = TRUE)
      ## TODO (Michael): Insert code for targets
      cat(" & ", file = file, append = TRUE)

      ## Make the sparkline
      spark.df = tmp.df[tmp.df$Year %in% startYear:endYear, ]

      validValues = which(!is.na(spark.df$value) &
        is.finite(spark.df$value))
      values = spark.df[validValues, "value"]
      years = spark.df[validValues, "Year"]
      if(length(values) > 5){
        x = (years - min(years))/(max(years) - min(years))
        max_value = (max(abs(values), na.rm = TRUE) * 1.2)
        max_value[max_value == 0] = 1
        new_values = values/max_value
        n.values = length(new_values)
        cat("\n \\begin{sparkline}{",
            length(new_values), "}", file = file, append = TRUE)
        cat("\n \\spark", paste(paste(x, new_values, sep = " "),
                                collapse = " "),
            "/", file = file, append = TRUE)
        cat("\n \\end{sparkline}", file = file, append = TRUE)
      }      
      
      cat("\\\\", file = file, append = TRUE)
    } else {
      
      spark.df = tmp.df[tmp.df$Year %in% startYear:endYear, ]
      cat(paste(gsub("NA|NaN", "",
                     formatC(spark.df$value, digit = 2, format = "fg")),
                collapse = "&"), file = file, append = TRUE)
      cat("&", file = file, append = TRUE)
      validValues = which(!is.na(spark.df$value) &
        is.finite(spark.df$value))
      values = spark.df[validValues, "value"]
      years = spark.df[validValues, "Year"]
      if(length(values) > 5){
        x = (years - min(years))/(max(years) - min(years))
        max_value = (max(abs(values), na.rm = TRUE) * 1.2)
        max_value[max_value == 0] = 1
        new_values = values/max_value
        n.values = length(new_values)
        cat("\n \\begin{sparkline}{",
            length(new_values), "}", file = file, append = TRUE)
        cat("\n \\spark", paste(paste(x, new_values, sep = " "),
                                collapse = " "),
            "/", file = file, append = TRUE)
        cat("\n \\end{sparkline}", file = file, append = TRUE)
      }
      cat("\\\\", file = file, append = TRUE)
    }
  }
}

sanitizeToLatex = function(str, html=FALSE, type=c("text","table")) {
    
    type = match.arg(type)
    
    result = as.character(str)
    
    result = gsub("\\\\-","TEX.BACKSLASH",result)
    result = gsub("\\\\","SANITIZE.BACKSLASH",result)
    result = gsub("$","\\$",result,fixed=TRUE)
    result = gsub(">","$>$",result,fixed=TRUE)
    result = gsub("<","$<$",result,fixed=TRUE)
    result = gsub("|","$|$",result,fixed=TRUE)
    result = gsub("{","\\{",result,fixed=TRUE)
    result = gsub("}","\\}",result,fixed=TRUE)
    result = gsub("%","\\%",result,fixed=TRUE)
    result = gsub("&","\\&",result,fixed=TRUE)
    result = gsub("_","\\_",result,fixed=TRUE)
    ## result = gsub("_", "\\textsubscript", result, fixed = TRUE)
    result = gsub("#","\\#",result,fixed=TRUE)
    result = gsub("^", ifelse(type == "table", "\\verb|^|",
                               "\\textsuperscript "), result,fixed = TRUE)
    result = gsub("~","\\~{}",result,fixed=TRUE)
    result = gsub("ÃƒÂ´","\\^{o}",result,fixed=TRUE)
    result = gsub("ô","\\^{o}",result,fixed=TRUE)
    result = gsub("ÃƒÂ¢","\\^{a}",result,fixed=TRUE)
    result = gsub("ÃƒÂ¨","\\`{e}",result,fixed=TRUE)
    result = gsub("è","\\`{e}",result,fixed=TRUE)
    result = gsub("ÃƒÂ©","\\'{e}",result,fixed=TRUE)
    result = gsub("é","\\'{e}",result,fixed=TRUE)
    result = gsub("Å","\\r{A}",result,fixed=TRUE)
    result = gsub("ç","\\c{c}",result,fixed=TRUE)
    result = gsub("SANITIZE.BACKSLASH","$\\backslash$",result,fixed=TRUE)
    result = gsub("TEX.BACKSLASH","\\-",result,fixed=TRUE)
    if(html) {
        result = gsub("( www.[0-9A-Za-z./\\-\\_]*)"," \\\\url{\\1}",result)
      	result = gsub("(http://(www.)*[0-9A-Za-z./\\-\\_]*)","\\\\url{\\1}",result)
      	dotSlash=grepl("\\url\\{.*\\.}",result)
      	result[dotSlash] = gsub("\\.\\}","\\}\\.",result[dotSlash])
    }
    
    ## special expressions
    result = gsub("km2", "km\\textsuperscript{2}", result, fixed = TRUE)
    result = gsub("m3", "m\\textsuperscript{3}", result, fixed = TRUE)
    result = gsub("CO2", "CO\\textsubscript{2}", result, fixed = TRUE)
    
    
    return(result)
}

translateQuantity = function(vec){
    type = mode(vec)
    if(type == "character"){
        if(!(all(unique(vec) %in%
                 c("hundred", "thousand", "ten thousand",
                   "hundred thousand", "million", "ten million",
                   "hundred million", "billion", "trillion", NA))))
            stop("Unrecognised name")
        transVec = double(length(vec))
        transVec[which(vec == "hundred")] = 100
        transVec[which(vec == "thousand")] = 1000
        transVec[which(vec == "ten thousand")] = 10000
        transVec[which(vec == "hundred thousand")] = 100000    
        transVec[which(vec == "million")] = 1e6
        transVec[which(vec == "ten million")] = 1e7
        transVec[which(vec == "hundred million")] = 1e8    
        transVec[which(vec == "billion")] = 1e9
        transVec[which(vec == "trillion")] = 1e12
    } else if(type == "numeric"){
        if(!(all(unique(vec) %in% c(1, 10, 100, 1e3, 1e4, 1e5, 1e6, 1e7,
                                    1e8, 1e9, 1e12, NA))))
            stop("The unit does not have a character name available to translate")
        transVec = character(length(vec))
        transVec[which(vec == 1)] = ""
        transVec[which(vec == 10)] = ""
        transVec[which(vec == 100)] = "hundred"
        transVec[which(vec == 1000)] = "thousand"
        transVec[which(vec == 10000)] = "ten thousand"
        transVec[which(vec == 1e5)] = "hundred thousand"
        transVec[which(vec == 1e6)] = "million"
        transVec[which(vec == 1e7)] = "ten million"
        transVec[which(vec == 1e8)] = "hundred million"
        transVec[which(vec == 1e9)] = "billion"
        transVec[which(vec == 1e12)] = "trillion"
    } else {
        stop("The type of vector can not be translated")
    }
    names(transVec) = names(vec)
    transVec
}
