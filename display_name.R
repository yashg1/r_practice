#Function to combine first and last names
display_name <- function(p){
  stopifnot(is.list(p))
  first_name <- as.character(p$FirstName)
  last_name <- as.character(p$Surname)
  duplicated_index <- which(duplicated(last_name))
  #duplicated_name <- last_name[duplicated(last_name)]
  first_charac = substr(first_name,1,3)
  ##
  dis_name <- vector(mode='character', length=nrow(p))
  ##
  dis_name <- paste(first_name,last_name, sep = "")
  temp <- str_replace_all(dis_name,fixed(" "), "")
  temp <- str_replace_all(temp,"[[:punct:]]", "")
  dis_name <- str_to_lower(temp)
  p <- cbind(dis_name,p)
  new <- list("dis_name" = dis_name,"new_list" = p)
  return(new)
}
  
  ## Old Code
  #dis_name[first_name %in% ""] <- last_name[first_name %in% ""]
  ##
  # dis_name[duplicated_index] <- paste(first_charac[duplicated_index],last_name[duplicated_index], sep = ".")
  # next_duplicate <- duplicated_index-1
  # dis_name[next_duplicate] <- paste(first_charac[next_duplicate],last_name[next_duplicate], sep = ".")
  ##
  #dis_name[dis_name %in% ""] <- last_name[dis_name %in% ""] 
  

