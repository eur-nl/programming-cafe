# Website ProgrammingCafe

Source code of the website of the EUR Programming Cafe. The project is based on the source code of [the Open Science Community Rotterdam](https://github.com/osc-rotterdam/osc-rotterdam.github.io/tree/master).

This website is developed using [_R_](https://cran.r-project.org/), [blogdown v1.1](https://github.com/rstudio/blogdown), and [Hugo v0.81.0](https://gohugo.io/). 


# Usage

Please work in the development-branch. To publish your materials, perform the following steps:
1. `install` [R](https://cran.r-project.org/), [RStudio](https://posit.co/download/rstudio-desktop) and [blogdown](https://github.com/rstudio/blogdown)
2. `open` the RStudio project file that you can find in the development branch
3. `add` your content to the repository (e.g., your presentations)
4. `link` your content in the related event using md
5. `run` `blogdown::build_site()` in R to build the new public folder
2. `commit` your changes in development folder
3. `push` all changes and resolve all merge conflicts
4. `save` the public folder somewhere
5. `switch` to the main branch
6. `add` the content of the public folder to the main branch 
