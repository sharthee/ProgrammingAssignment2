<<<<<<< HEAD
Welcome to CS109: Data Science
=======
*[Official Course Page](http://cs109.org)*

## Assignments

* [Homework 0](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW0.ipynb): Hello, world ([solutions](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW0_solutions.ipynb))
* [Homework 1](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW1.ipynb): Which of two things is larger? ([solutions](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW1_solutions.ipynb))
* [Homework 2](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW2.ipynb): Desperately Seeking Silver ([solutions](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW2_solutions.ipynb))
* [Homework 3](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW3.ipynb): Bayesian Tomatoes ([solutions](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW3_solutions.ipynb))
* [Homework 4](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW4.ipynb): Do We Really Need Chocolate Recommendations? ([solutions](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW4_solutions.ipynb))
* [Homework 5](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW5.ipynb): Networks and Congress ([solutions](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/HW5_solutions.ipynb))

## Lecture Supplements

* [A gallery of statistical graphs with matplotlib](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/lec_03_statistical_graphs.ipynb) (see also the version with [default matplotlib styles](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/lec_03_statistical_graphs_mpl_default.ipynb))
* [A rubric for data wrangling and exploratory data analysis](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/lec_04_wrangling.ipynb)
* [Web Scraping and Parsing Demo](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/lec_04_scraping.ipynb)
* [Cross Validation: The Right and Wrong Way](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/lec_10_cross_val.ipynb)

## Labs

* [Lab 2: Web Scraping](https://github.com/cs109/content/tree/master/labs/lab2)
* [Lab 3: EDA, Pandas, Matplotlib](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab3/lab3full.ipynb)
* [Lab 4: Scikit-Learn, Regression, PCA](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab4/Lab4full.ipynb)
* [Lab 5: Bias, Variance, Cross-Validation](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab5/Lab5.ipynb)
* [Lab 6: Bayes, Linear Regression, and Metropolis Sampling](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab6/BayesLinear.ipynb)
* [Lab 7: Gibbs Sampling](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab7/GibbsSampler.ipynb)
* [Lab 8: MapReduce](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab8/lab8_mapreduce.ipynb)
* [Lab 9: Networks](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab9/lab_9.ipynb)
* [Lab 10: Support Vector Machines](http://nbviewer.ipython.org/urls/raw.github.com/cs109/content/master/labs/lab10/Lab_10.ipynb)


## Other Resources

* [Setting up Python](https://github.com/cs109/content/wiki/Installing-Python)
=======
### Introduction

This second programming assignment will require you to write an R
function that is able to cache potentially time-consuming computations.
For example, taking the mean of a numeric vector is typically a fast
operation. However, for a very long vector, it may take too long to
compute the mean, especially if it has to be computed repeatedly (e.g.
in a loop). If the contents of a vector are not changing, it may make
sense to cache the value of the mean so that when we need it again, it
can be looked up in the cache rather than recomputed. In this
Programming Assignment you will take advantage of the scoping rules of
the R language and how they can be manipulated to preserve state inside
of an R object.

### Example: Caching the Mean of a Vector

In this example we introduce the `<<-` operator which can be used to
assign a value to an object in an environment that is different from the
current environment. Below are two functions that are used to create a
special object that stores a numeric vector and caches its mean.

The first function, `makeVector` creates a special "vector", which is
really a list containing a function to

1.  set the value of the vector
2.  get the value of the vector
3.  set the value of the mean
4.  get the value of the mean

<!-- -->

    makeVector <- function(x = numeric()) {
            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setmean <- function(mean) m <<- mean
            getmean <- function() m
            list(set = set, get = get,
                 setmean = setmean,
                 getmean = getmean)
    }

The following function calculates the mean of the special "vector"
created with the above function. However, it first checks to see if the
mean has already been calculated. If so, it `get`s the mean from the
cache and skips the computation. Otherwise, it calculates the mean of
the data and sets the value of the mean in the cache via the `setmean`
function.

    cachemean <- function(x, ...) {
            m <- x$getmean()
            if(!is.null(m)) {
                    message("getting cached data")
                    return(m)
            }
            data <- x$get()
            m <- mean(data, ...)
            x$setmean(m)
            m
    }

### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.

In order to complete this assignment, you must do the following:

1.  Fork the GitHub repository containing the stub R files at
    [https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2)
    to create a copy under your own account.
2.  Clone your forked GitHub repository to your computer so that you can
    edit the files locally on your own machine.
3.  Edit the R file contained in the git repository and place your
    solution in that file (please do not rename the file).
4.  Commit your completed R file into YOUR git repository and push your
    git branch to the GitHub repository under your account.
5.  Submit to Coursera the URL to your GitHub repository that contains
    the completed R code for the assignment.

### Grading

This assignment will be graded via peer assessment.
>>>>>>> origin/master
