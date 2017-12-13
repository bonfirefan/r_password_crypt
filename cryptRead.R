####Encryption functions
library("digest")
# read encypted data frame from file
read.aes <- function(filename,key) {
  require(digest)
  dat <- readBin(filename,"raw",n=1000)
  aes <- AES(key,mode="ECB")
  raw <- aes$decrypt(dat, raw=TRUE)
  txt <- rawToChar(raw[raw>0])
  read.csv(text=txt, stringsAsFactors = F)
}

# read credentials
load("mykey.RData") # whatever you named your key RData file
logins <- read.aes("mycredentials.txt", mykey)
