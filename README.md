# RandFortran
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
                    Number of data sets:      1000
                Average Mean           :        0.4997445425
                Average Variance       :        0.0829500662
                Standard Error of Mean :        0.0008970770
             Standard Error of Variance:        0.0002355136
                Minimum Mean           :        0.3943651410
                Maximum Mean           :        0.5831039347
                Minimum Variance       :        0.0573404053
                Maximum Variance       :        0.1075781793
```
On my Windows PC, the Fortran program compiled with `gfortran -O3 -march=native` takes 0.06s, and the R program takes 14s, about 200 times longer.
