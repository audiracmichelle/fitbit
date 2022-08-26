# knit

rmarkdown::render(
  "./prep_minute_data.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/prep_minute_data.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

rmarkdown::render(
  "./flag_nonwear.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/flag_nonwear.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

rmarkdown::render(
  "./flag_valid_day.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/flag_valid_day.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

rmarkdown::render(
  "./plot_missingness.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/plot_missingness.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

rmarkdown::render(
  "./fitibble.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/fitibble.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

rmarkdown::render(
  "./plot_wear_heatmap.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/plot_wear_heatmap.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

rmarkdown::render(
  "./summaries.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/summaries.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

md_filename <- "./_knit/summaries.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")

rmarkdown::render(
  "./plot_time_use.Rmd", 
  output_dir = "./_knit"
)

md_filename <- "./_knit/plot_time_use.md"
md_txt <- readLines(md_filename)
md_txt <- gsub(paste0(getwd(), "/_knit/"), "./", md_txt)
cat(md_txt, file=md_filename, sep="\n")
