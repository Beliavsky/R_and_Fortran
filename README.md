# R and Fortran

Here are some R and Fortran code equivalents, with the R code listed first.
### loops, conditionals, and output
```R
# R
for (i in -1:1) {
	if (i > 0) {
	  cat(i, "positive\n")
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
### create array
```R
v = c(2, 4, 6) # R: create array of 3 integers
```
```Fortran
v = [2, 4, 6] ! Fortran: v should be allocatable or already have size 3
```
### access array element
```R
v[2, 1, 5] # R
```
```Fortran
v(2, 1, 5) ! Fortran
```
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
### maximum of array
```R
max(v) # R
```
```Fortran
maxval(v) ! Fortran
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
allocate(x(5, 6, 7), source = 0.0)
```
### choose a value
```R
ifelse(condition, 3, 4) # R: return 3 if condition is TRUE, otherwise 4
```
```Fortran
merge(3, 4, condition) ! Fortran
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
Simulation Results:
-------------------
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


