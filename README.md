# Website ProgrammingCafe

Source code of the website of the EUR Programming Cafe. The project is based on the source code of [the Open Science Community Rotterdam](https://github.com/osc-rotterdam/osc-rotterdam.github.io/tree/master).

This website is developed using [_R_](https://cran.r-project.org/), [`blogdown v1.1`](https://github.com/rstudio/blogdown), and [Hugo v0.81.0](https://gohugo.io/). 


# Usage

Please work in the development-branch. To publish your last changes, perform the following steps:

1. `blogdown::build_site()` in R to build the new public folder
2. `commit` your changes in development folder
3. `push` all changes and resolve all merge conflicts
4. `save` the public folder somewhere
5. `switch` to the main branch
6. `add` the content of the public folder to the main branch 
