# R and Fortran

Here are some R and Fortran code equivalents, with the R code listed first.

```
v = c(2, 4, 6)
v = [2, 4, 6] ! v should be allocatable or already have size 3
```

```
v[v > 3]
pack(v, v > 3
```

Example of simple R and Fortran programs that compute the means and variances of sets of uniform random variates and
some statistics on those quantities.

Sample R output:

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

Sample Fortran output:

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
