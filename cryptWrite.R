####Encryption functions
library("digest")

# write encrypted data frame to file
write.aes <- function(df,filename, key) {
  require(digest)
  zz <- textConnection("out","w")
  write.csv(df,zz, row.names=F)
  close(zz)
  out <- paste(out,collapse="\n")
  raw <- charToRaw(out)
  raw <- c(raw,as.raw(rep(0,16-length(raw)%%16)))
  aes <- AES(key,mode="ECB")
  aes$encrypt(raw)
  writeBin(aes$encrypt(raw),filename)  
}

# create key
mykey <- as.raw( sample(1:16, 16))
save(mykey,file = "mykey.RData")

# implementation
credentials <- as.data.frame(list("user" = "myuser", "pwd" = "mypassword"))
write.aes(df = credentials, filename = "mycredentials.txt", key = mykey)