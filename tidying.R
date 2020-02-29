#cleaning tweets - example 1
text1 <- text[1]
rttext1 <- rt1$text
cleanRT1 <- gsub('http.*','',rttext1)
cleanRT1 <- gsub('https.*','',cleanRT1)
cleanRT1 <- gsub("#.*","",cleanRT1)
cleanRT1 <- gsub("@.*","",cleanRT1)