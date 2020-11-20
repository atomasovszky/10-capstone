installPackages <- function() {
  missingPackages = getMissingPackages()
  if (length(missingPackages) > 0) {
    withCallingHandlers(lapply(missingPackages, installWithVersionIfExists), warning = function(w) stop(w))
  }
}

getMissingPackages <- function() {
  Filter(
    x = parseRequirements(),
    f = function(x) !(x[1] %in% installed.packages()[,"Package"] &&
    (is.na(x[2]) || x[2] == installed.packages()[x[1], "Version"])))
}

installWithVersionIfExists <- function(x) {
  if (is.na(x[2])) {
    install.packages(x[1])
  } else {
    devtools::install_version(x[1], version = x[2])
  }
}

parseRequirements <- function() {
  lines <- trimws(dropComments(readLines("packages.txt")))
  nonemptyLines <- lines[lines != ""]
  lapply(lines, getPackageAndVersion)
}

getPackageAndVersion <- function(line) {
  c(unlist(strsplit(line, "==")), NA)[1:2]
}

dropComments <- function(str) gsub("(#.*$)", "", str)
