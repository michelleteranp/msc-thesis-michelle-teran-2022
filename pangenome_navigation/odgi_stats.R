### ODGI stats ###
# set working directory

# get paths for all sets and define the chromosome
set_names <- c("param_set_A", "param_set_B", "param_set_C", "param_set_D", "param_set_E", "param_set_F",
               "param_set_G","param_set_H", "param_set_H2", "param_set_H3", "param_set_I", "param_set_J", "param_set_K")
chr <- c("chr10")
for (i in 1:length(set_names)){
  paths_to_import <- paste0("B73_Mo18_parameter_sets/",set_names,"/",chr,"/multiqc_data/multiqc_odgi_stats.txt")
}
# import the stats files for the selected chromosome
for (i in 1:length(paths_to_import)) {
  fileName <- paths_to_import[[i]]
  dataName <- set_names[[i]]
  tempData <- read.delim(fileName, header = T)
  tempData$set_name <- c(paste0(set_names[i]),paste0(set_names[i]))
  tempData$chr <- c(chr,chr)
  tempData <- tempData[colnames(tempData[c(28,29,1:27)])]
  assign (dataName, tempData, envir = .GlobalEnv)
}

chr10_stats <- rbind(param_set_A, param_set_B, param_set_C, param_set_D, param_set_E, param_set_F,
              param_set_G, param_set_H, param_set_H2, param_set_H3, param_set_I, param_set_J,
              param_set_K)

chr10_stats_smooth <- subset(chr10_stats, Sample == "smooth")




