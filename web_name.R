#Function to combine first and last names
web_name <- function(p){
  #stopifnot(is.list(p))
  first_name <- as.character(p$FirstName)
  last_name <- as.character(p$Surname)
  duplicated_name <- last_name[duplicated(last_name)]
  if(first_name %in% ""){
    print("a")
    dis_name = last_name
  }
  else if (any(last_name %in% duplicated_name)) {
  print("b")
  first_charac = substr(first_name,1,1)
  dis_name = paste(first_charac,duplicated_name, sep = ".")
  }
  else{
    print("C")
  dis_name =  last_name[!duplicated(last_name)] 
  }
  return(dis_name)
}