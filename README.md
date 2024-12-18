# R and Fortran

Here are some R and Fortran code equivalents, with the R code listed first. The R and Fortran comment characters are `#` and `!`.
### sequence
```R
# R
-2:3 # -2 -1 0 1 2 3
```
```Fortran
! Fortran
integer :: i
[(i, i=-2, 3)] ! implied do-loop
```
### repeat a value
```R
# R
rep(2, 3) # 2 2 2
```
```Fortran
! Fortran
integer :: i
[(2, i=1, 3)]
```
### loops, conditionals, and output
```R
# R
for (i in -1:1) {
	if (i > 0) {
	  cat(i, "positive\n") # \n is needed to get a new line after the output
	} else if (i == 0) {
	  cat(i, "zero\n")
	} else {
	  cat(i, "negative\n")
	}
}
```
```Fortran
! Fortran
implicit none
integer :: i
do i=-1,1
   if (i > 0) then
      print*,i, "positive"
   else if (i == 0) then
      print*,i, "zero"
   else
      print*,i, "negative"
   end if
end do
end
```
### while loop
```R
# R
sum = 0
i = 0
while (sum <= 10) {
  i = i + 1
  sum = sum + i
}
cat("Sum of 1 to", i, "is", sum, "\n")
# output:
# Sum of 1 to 5 is 15
```
```Fortran
! Fortran
integer :: i, isum
isum = 0
i = 0
do while (isum <= 10)
   i = i + 1
   isum = isum + i
end do
print*,"Sum of 1 to", i, "is", isum
end
```
### exponentiation
```R
# R
2^3, 2**3 # ^ is preferred, but both are valid
```
```Fortran
! Fortran
2**3
```
### create array
```R
v = c(2, 4, 6) # R create array of 3 floats
v = c(2L, 4L, 6L) # create array of 3 integers
```
```Fortran
! Fortran
integer, allocatable :: v(:)
v = [2, 4, 6]
```
### matrix transpose
```R
# R
t(x)
```
```Fortran
! Fortran
transpose(x)
```
### matrix multiplication
```R
# R
a %*% b
```
```Fortran
! Fortran
matmul(a, b)
```
### dot product
```R
# R
a %*% b
```
```Fortran
! Fortran
dot_product(a, b)
```
### access array element
```R
v[2, 1, 5] # R
```
```Fortran
v(2, 1, 5) ! Fortran
```
### negative indices
The lower bounds of R arrays are always 1. A negative array index means that the index is excluded.
```R
# R
x = c(10, 20, 30)
cat(x[-2], "\n")
# output:
# 10 30
```
Fortran arrays have lower bounds of 1 by default, but this can be overridden. A negative index has no special meaning.
### size of array
```R
length(v) # R
```
```Fortran
size(v) ! Fortran
```
### dimensions of array
```R
dim(v) # R
```
```Fortran
shape(v) ! Fortran
```
### sum of array
```R
sum(v) # R -- same in Fortran
```
### product of array
```R
prod(v) # R
```
```Fortran
product(v) ! Fortran
```
### maximum and minimum of array
```R
max(v), min(v) # R
```
```Fortran
maxval(v), minval(v) ! Fortran
```
### location of maximum and minimum of array
```R
# R
v = c(3, 8, 2, 10, 5)
cat(which.max(v), which.min(v), "\n")
# output:
# 4 3
```
```Fortran
! Fortran
integer :: v(5)
v = [3, 8, 2, 10, 5]
print*,maxloc(v, dim=1), minloc(v, dim=1)
end
``` 
### select elements satisfying a condition
```R
v[v > 3] # R: select elements of v exceeding 3
```
```Fortran
pack(v, v > 3) ! Fortran
```
### select the first row or column of a 2-D array
```R
x[1, ] # R: 1st row
x[, 1] # 1st column
```
```Fortran
x(1, :) ! Fortran: 1st row
x(:, 1) ! 1st column
```
### create array of zeros
```R
x = array(0.0, c(5, 6, 7)) # R: create 3-D array of dimensions [5, 6, 7] and set values to 0.0
```
```Fortran
! Fortran
real(kind=dp), allocatable :: x(:, :, :) ! dp is a double precision kind parameter
allocate(x(5, 6, 7), source = 0.0_dp)
```
### choose a value
```R
ifelse(condition, 3, 4) # R: return 3 if condition is TRUE, otherwise 4
```
```Fortran
merge(3, 4, condition) ! Fortran
```
### Boolean variables and operators: (! & |) in R, (.not. .and. .or.) in Fortran
```R
# R
x = TRUE
y = FALSE
cat(x, y, !x, !y, x & y, x | y, "\n")
# output:
# TRUE FALSE FALSE TRUE FALSE TRUE
```
```Fortran
! Fortran
logical :: x, y
x = .true.
y = .false.
print*, x, y, .not. x, .not. y, x .and. y, x .or. y
end
! output:
! T F F T F T
```
### concatenate strings
```R
# R
paste("ab", "cd") # gives "ab cd"
paste0("ab", "cd") # gives "abcd"
```
```Fortran
! Fortran
"ab" // " " // "cd"
"ab" // "cd"
```
### complex numbers
```R
# R
3.0 + 4.0i
```
```Fortran
! Fortran
(3.0d0, 4.0d0) ! d0 is used to give double precision, matching R
```
### complex conjugate
```R
# R
Conj(z) # note capitalization
```
```Fortran
! Fortran
congj(z)
```
### define and call a function
```R
# R
twice <- function(x) {
  return(2 * x)
}
cat(twice(c(3.0, 4.0)), "\n")
# output
# 6 8
```
```Fortran
! Fortran
elemental real function twice(x)
! elemental means the function can take a scalar or array input and return the same, like the R function
real, intent(in) :: x
twice = 2*x
end function twice
print*,twice([3.0, 4.0])
end
```
### create a constructor for a new data type and a function that acts on it
```R
# R
# Define a constructor function for the class RightTriangle
RightTriangle = function(x, y) {
  return(list(x = x, y = y))  # Create a list with attributes
}
# Define the hypotenuse method
hypotenuse = function(a) {
	return(sqrt(a$x^2 + a$y^2))
}
# Invoke it on an instance of RightTriangle
cat(hypotenuse(RightTriangle(1.5, 2.0)), "\n") # output: 2.5
```
```Fortran
! Fortran
program main
implicit none
! define type RightTriangle
type :: RightTriangle
   real :: x, y
end type
print*,hypotenuse(RightTriangle(1.5, 2.0)) ! output: 2.5
contains
! define hypotenuse function acting on type
real function hypotenuse(tri)
type(RightTriangle) :: tri
hypotenuse = sqrt(tri%x**2 + tri%y**2)
end function
end program main
```
### import from R library or Fortran module
```R
library(foo) # R
```
```Fortran
use foo ! Fortran
```
This repo has simple R and Fortran programs that compute the means and variances of sets of uniform random variates and
some statistics on those quantities.

Sample R output of `xsim_uniform.r`:

```
    Number of observations per data set:            100
    Number of data sets:                        1000000
    Average Mean:                                    0.5000192068
    Average Variance:                                0.0833360355
    Standard Error of Mean:                          0.0000288673
    Standard Error of Variance:                      0.0000075392
    Minimum Mean:                                    0.3677907574
    Maximum Mean:                                    0.6419923536
    Minimum Variance:                                0.0501358999
    Maximum Variance:                                0.1214716295
```

Sample Fortran output of `xsim_uniform.f90`:

```
    Number of observations per data set:       100
                    Number of data sets:   1000000
                Average Mean           :        0.4999585642
                Average Variance       :        0.0833183208
                Standard Error of Mean :        0.0000288502
             Standard Error of Variance:        0.0000075364
                Minimum Mean           :        0.3597154884
                Maximum Mean           :        0.6331273418
                Minimum Variance       :        0.0478706009
                Maximum Variance       :        0.1232975046
```
On my Windows PC, the Fortran program compiled with `gfortran -O3 -march=native` takes 0.9s, and the R program takes 14s.

The module `r.f90` defines some Fortran functions that emulate those of R. Compiling with `gfortran r.f90 xr.f90` and running gives

```
                    Real data:     1.0000     2.0000     3.0000     4.0000     5.0000     6.0000     7.0000     8.0000     9.0000    10.0000
                 Integer data:          1          2          3          4          5          6          7          8          9         10
            Mean of real_data:     5.5000
             Mean of int_data:     5.5000
Standard deviation of real_dat     3.0277
Standard deviation of int_data     3.0277
        Variance of real_data:     9.1667
         Variance of int_data:     9.1667
          Median of real_data:     5.5000
           Median of int_data:     5.5000
           Range of real_data:     1.0000    10.0000
            Range of int_data:          1         10
       Quantiles of real_data:     3.2500     5.5000     7.7500
        Quantiles of int_data:     3.2500     5.5000     7.7500
             IQR of real_data:     4.5000
              IQR of int_data:     4.5000
         Product of real_data:   3628800.0000
          Product of int_data:    3628800
```

and running the R script `xr.r` gives the same results:

```
                       Real data:     1.0000     2.0000     3.0000     4.0000     5.0000     6.0000     7.0000     8.0000     9.0000    10.0000 
                    Integer data:          1          2          3          4          5          6          7          8          9         10 
               Mean of real_data:     5.5000 
                Mean of int_data:     5.5000 
 Standard deviation of real_data:     3.0277 
  Standard deviation of int_data:     3.0277 
           Variance of real_data:     9.1667 
            Variance of int_data:     9.1667 
             Median of real_data:     5.5000 
              Median of int_data:     5.5000 
              Range of real_data:     1.0000    10.0000 
               Range of int_data:          1         10 
          Quantiles of real_data:     3.2500     5.5000     7.7500 
           Quantiles of int_data:     3.2500     5.5000     7.7500 
                IQR of real_data:     4.5000 
                 IQR of int_data:     4.5000 
            Product of real_data: 3628800.0000 
             Product of int_data:    3628800
```


