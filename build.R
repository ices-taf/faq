library(icesTAF)
library(rmarkdown)
library(tools)

scripts <- dir("R", pattern = ".Rmd", full.names = TRUE)

for (script in scripts) {
  dirname <- file_path_sans_ext(basename(script))
  mkdir(dirname)
  rmarkdown::render(script, output_dir = dirname, output_file = "README.md")
}
