! Description: Main program to demonstrate statistical functions from r_mod
program StatisticsExample
    use r_mod
    implicit none
    character (len=*), parameter :: fmt_cr = "(A30, *(1x,f10.4))", fmt_ci = "(A30, *(1x,i10))"
    integer, parameter :: n = 10
    integer :: i
    real(kind=dp) :: real_data(n)
    integer :: int_data(n)
    int_data = [(i, i=1, n)]
    real_data = real(int_data, kind=dp)
    write(*, fmt_cr) "Real data:", real_data
    write(*, fmt_ci) "Integer data:", int_data
    write(*, fmt_cr) "Mean of real_data:", mean(real_data)
    write(*, fmt_cr) "Mean of int_data:", mean(int_data)
    write(*, fmt_cr) "Standard deviation of real_data:", sd(real_data)
    write(*, fmt_cr) "Standard deviation of int_data:", sd(int_data)
    write(*, fmt_cr) "Variance of real_data:", var(real_data)
    write(*, fmt_cr) "Variance of int_data:", var(int_data)
    write(*, fmt_cr) "Median of real_data:", median(real_data)
    write(*, fmt_cr) "Median of int_data:", median(int_data)
    write(*, fmt_cr) "Range of real_data:", min_max(real_data)
    write(*, fmt_ci) "Range of int_data:", min_max(int_data)
    write(*, fmt_cr) "Quantiles of real_data:", quantile(real_data, [0.25_dp, 0.5_dp, 0.75_dp])
    write(*, fmt_cr) "Quantiles of int_data:", quantile(int_data, [0.25_dp, 0.5_dp, 0.75_dp])
    write(*, fmt_cr) "IQR of real_data:", IQR(real_data)
    write(*, fmt_cr) "IQR of int_data:", IQR(int_data)
    write(*, "(A30, *(1x,f14.4))") "Product of real_data:", prod(real_data)
    write(*, fmt_ci) "Product of int_data:", prod(int_data)
end program StatisticsExample
