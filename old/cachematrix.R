### Assignment: Caching the Inverse of a Matrix

# Test matrices
# matrix <- matrix(c(1:25), 5, 5) # error: matrix singular, can't be inverted 
# matrix <- matrix(rnorm(5*5,mean = 0, sd = 1), 5, 5)
# inverse <- solve(matrix)

#####
# makeCacheMatrix: creates special "matrix" object to cache its inverse.
  # assumes matrix supplied is invertible
  # use rnorm() for testing

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y       # assign value to x in diff environment 
    i <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) i <<- solve
  getsolve <- function() i
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}

######
# cacheSolve`: Computes inverse of the special "matrix" returned by 
# "makeCacheMatrix" above. If inverse has already been calculated 
# (and matrix has not changed), "cacheSolve" should retrieve 
# inverse from the cache.

cacheSolve <- function(x, ...) {
  i <- x$getsolve()
  if(!is.null(i)) {   # has inverse already been calculated?
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setsolve(i)
  i  ## Return a matrix that is the inverse of 'x'
}
