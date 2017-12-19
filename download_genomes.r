library(biomartr)
library(jsonlite)

findSynonyms <- function(species_name) {
  synonyms = list()
  species_name_no_spaces = gsub(" ","+",species_name, fixed=TRUE)
  query = paste("http://webservice.catalogueoflife.org/col/webservice?name=", species_name_no_spaces, "&format=json&response=full", sep = "")
  dbentry = fromJSON(query, flatten=TRUE)
  if (length(dbentry$results) == 0) {
    print(paste("Unfortunately, no results were found for ", species_name, ". Please check your spelling."), sep="")
  } else {
    for (i in 1:length(dbentry$results)) {
      name = paste(dbentry$results[i,]$name)
      if (name == species_name) {
        status = paste(dbentry$results[i,]$name_status)
        if (status == "synonym") {
          #print(paste("Adding", dbentry$results[i,]$accepted_name.name))
          synonyms = c(synonyms,c(paste(dbentry$results[i,]$accepted_name.name)))
        } else { #accepted name
          for (j in 1:length(dbentry$results[i,]$synonyms[[1]]$name)) {
            #print(paste("Adding", dbentry$results[i,]$synonyms[[1]]$name[j]))
            synonyms = c(synonyms,c(paste(dbentry$results[i,]$synonyms[[1]]$name[j])))
          }
        }
      }
    }
  }
  return(synonyms)
}

checkAvailable <- function(name) {
  res = FALSE
  db = "NULL"
  if (is.genome.available(name, db="refseq")) {
    res = TRUE
    db ="refseq"
  } else if (is.genome.available(name, db = "genbank")) {
    res = TRUE
    db = "genbank"
  }# else if (is.genome.available(name, db = "ensembl")) {
  #  res = TRUE
  #} else if (is.genome.available(name, db = "ensemblgenomes")) {
  #  res = TRUE
  #}
  return(list("found" = res, "db" = db))
}

createGenomeTable <- function(genomePaths) {
  fileConn<-file("genomes.table")
  writeLines(unlist(genomePaths, use.names = FALSE), fileConn)
  close(fileConn)
}

retrieveGenomes <- function(species_names) {
  taxQuery = list("", length(species_names))
  dbQuery = list("", length(species_names))
  #check availability (database and synonyms)
  for (i in 1:length(species_names)){
    if (nchar(species_names[i]) > 0) {
      availCheck = checkAvailable(species_names[i])
      if (availCheck$found) {
        taxQuery[i] = species_names[i]
        dbQuery[i] = availCheck$db
        print(paste(species_names[i],": This genome is available"))
      } else{
        print(paste(species_names[i],": This genome is not available, searching for species name synonyms..."))
        names = findSynonyms(species_names[i])
        found = FALSE
        if (length(names) > 0) {
          for (j in 1:length(names)) {
            if (nchar(names[j]) > 0) {
              print(paste("  Trying with name", names[j]))
              availCheck = checkAvailable(names[j])
              if (availCheck$found) {
                taxQuery[i] = names[j]
                dbQuery[i] = availCheck$db
                found = TRUE
                break
              }
            }
          }
        }
        if (found) {
          print(paste(" Genome has been found for a synonym."))
        } else {
          print(" ARGH! NO GENOME HAS BEEN FORUND FOR THIS TAXON!!! :-(")
        }
      }
    }
  }
  
  genomePaths = list("",length(species_names))
  
  #download genomes
  for (i in 1:length(species_names)){
    if (nchar(species_names[i]) > 0) {
      print(paste(taxQuery[i], dbQuery[i]))
      path = getGenome(db = dbQuery[i], organism = taxQuery[i])
      if (path == "Not available") { # check for misclassified species
        newQuery = paste("[", sub(" .*", "", taxQuery[i]), "]", " ", sub(".* ", "", taxQuery[i]), sep = "")
        taxQuery[i] = newQuery
        path = getGenome(db = dbQuery[i], organism = taxQuery[i])
      }
      genomePaths[i] = paste(substr(path,1,nchar(path)-3), species_names[i], sep = "\t");
    }
  }
  createGenomeTable(genomePaths)
  print("Genome table has been written to genomes.table")
}

fileName <- "/run/user/1000/gvfs/sftp:host=bridge-login,user=luttersh/hits/fast/sco/supermatrixData/empiricalData/yeast23_2494/genomes/species_names"
conn <- file(fileName,open="r")
species_names <-readLines(conn)
close(conn)

retrieveGenomes(species_names)

