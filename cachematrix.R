## Matrix inversion is usually a costly computation and there may be some benefit 
## to caching the inverse of a matrix rather than computing it repeatedly
## The below functions will be used to cache the inverse of a matrix

## This function creates a special matrix that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
    ## Initialize matrix inverse object to null
    matinverse <- NULL
    
    ## set the value of the matrix
    set <- function(y) {
      x <<- y
      matInverse <<- NULL
    }
    
    ## get the matrix
    get <- function() x
    
    ## set the matrix inverse 
    setinverse <- function(minverse) matinverse <<- minverse
    
    ## get the matrix inverse
    getinverse <- function() matinverse
    
    ## return the function details
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## This function computes and returns the inverse of the special matrix

cacheSolve <- function(x, ...) {
    ## check to see whether the matrix inverse is already available
    matinverse <- x$getinverse()
    
    ## display a friendly message about using cached data and return the inverse
    if(!is.null(matinverse)) {
      message("getting cached data")
      return(matinverse)
    }
    
    ## get the input matrix value
    data <- x$get()
    
    ## calculate matrix inverse
    matinverse <- solve(data, ...)
    
    ## cache the inverse 
    x$setinverse(matinverse)
    
    ## return the inverse
    matinverse
}
