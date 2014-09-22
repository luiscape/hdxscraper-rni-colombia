## Scraper for RNI Colombia's Website.

# dependencies
library(XML)
library(RCurl)

# code dependencies
source('tool/code/write_tables.R')


###################################################
###################################################
######### Scraping data from RNI's website ########
###################################################
###################################################

# function that gets the list of documents from WHO
# website and assembles a nice data.frame
scrapeList <- function(url) {
  cat('----------------------------------------\n')
  cat('Scraping data from RNI-Colombia website.\n')
  cat('----------------------------------------\n')

  # getting the html
  doc <- htmlParse(url)

  # getting only the right fields from the page
  output <- data.frame(
    year =  xpathSApply(doc, '//*[@id="main"]/fieldset[2]/div[1]/table/tr/td[1]', xmlValue),
    number_of_victims =  xpathSApply(doc, '//*[@id="main"]/fieldset[2]/div[1]/table/tr/td[2]', xmlValue),
    number_of_events = xpathSApply(doc, '//*[@id="main"]/fieldset[2]/div[2]/table/tr/td[2]', xmlValue)
    )

  # results
  cat('-------------------------------\n')
  cat('Done!\n')
  cat('-------------------------------\n')
  return(output)
}

# running the function
updateList <- scrapeList('http://cifras.unidadvictimas.gov.co/Home/Vigencia_ocurrencia')

# writing output
write.csv(updateList, 'tool/data/data.csv', row.names = F)