search_string_gen <- function(x,term_sep){
split_string <- unlist(strsplit(x," "))
x_temp <- paste(split_string,collapse = term_sep)

lower_case <- str_to_lower(split_string)
lower_case <- paste("#",lower_case,sep = "",collapse = term_sep)
upper_case <- str_to_upper(split_string)
upper_case <- paste("#",upper_case,sep = "",collapse = term_sep)
title_case <- str_to_title(split_string)
title_case <- paste("#",title_case,sep = "",collapse = term_sep)

temp <- paste(x_temp,lower_case,upper_case,title_case,sep = term_sep, collapse = term_sep) 
return(temp)
    }
  