# Development objectives (to-do list)
* `nice_t_test`
    * Add other optional corrections argument (other than Bonferroni)
    * Add option to specify `var.equal` argument for each test separately(?)
    * Add option to specify `robust.d` for a robust version of Cohen's D
    * Add option `bootstrapped.CI` to use a bootstrapped version of the 95% CI
* `nice_table`
    * `nice_lm`/`nice_slopes` integration: add meaningful error messages when using `lm` or `t.test`
    * Remove redundant code in flextable formatters by making it a function
    * Add optional arguments for table header and footnote
    * Tutorial: show how to add different levels of headers, etc.method with wrong model type
* `nice_slopes`
    * Add support for multiple moderators (like for `nice_mod`)
* `nice_qq`
    * Add support for only 1 group (like for nice_violin)
* `nice_varplot`
    * Add option to standardize or not
    * Also add option to annotate Levene test on the plot
* Plot functions
    * Make my own `ggplot2` theme to reuse in my functions and shorten the code
* `nice_contrasts`
    * Publish function
    * Check error with `iris` dataset
    * Need to accommodate: interactions/moderations in the models
    * Also add option to specify contrasts manually
* Fix recommended practices
    * Change for `vapply` instead of `sapply`
* All functions
    * Check for consistency among argument names like response/variable
        * Check at other functions to see what's most typically used
    * Add documentation for outputs
* Finish writing all function tests
* Write a manual
* Write a vignette
* Make a website
* Suggest collaboration with easystats
* Submit to CRAN