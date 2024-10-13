! File: simulation_corrected_fmt_minval_maxval.f90
! Description: Simulate niter sets of n uniformly distributed random numbers
!              and compute the standard error of the estimated means and variances.
!              Also, print the average, minimum, and maximum of the computed means and variances
!              with aligned labels and decimal points. Additionally, print the number of
!              observations per data set and the number of data sets.

module SimulationModule
    implicit none
    ! Define double precision
    integer, parameter :: dp = kind(1.0d0)
    public :: dp, compute_mean, compute_stddev, simulate_uniform_se
contains

    ! Function to compute the mean of an array
    function compute_mean(data, n) result(mean_val)
        real(kind=dp), intent(in) :: data(:)
        integer, intent(in) :: n
        real(kind=dp) :: mean_val
        mean_val = sum(data) / real(n, kind=dp)
    end function compute_mean

    ! Function to compute the standard deviation of an array
    function compute_stddev(data, n, mean_val) result(stddev)
        real(kind=dp), intent(in) :: data(:)
        integer, intent(in) :: n
        real(kind=dp), intent(in) :: mean_val
        real(kind=dp) :: stddev
        if (n > 1) then
            stddev = sqrt( sum( (data - mean_val)**2 ) / real(n - 1, kind=dp) )
        else
            stddev = 0.0_dp
        endif
    end function compute_stddev

    ! Subroutine to perform the simulation
    subroutine simulate_uniform_se(n, niter, avg_mean, avg_variance, se_mean, &
        se_variance, min_mean, max_mean, min_variance, max_variance)

        ! Input arguments
        integer, intent(in) :: n        ! Number of random numbers in each set
        integer, intent(in) :: niter    ! Number of iterations

        ! Output arguments
        real(kind=dp), intent(out) :: avg_mean, avg_variance, se_mean, &
           se_variance, min_mean, max_mean, min_variance, max_variance

        ! Local variables
        real(kind=dp), allocatable :: means(:), variances(:), data(:)
        real(kind=dp) :: mean_val, var_val, stddev_means, stddev_vars
        integer :: i

        ! Allocate arrays to store means and variances
        allocate(means(niter), variances(niter), data(n))

        ! Seed the random number generator (optional)
        call random_seed()

        ! Perform the simulation over niter iterations
        do i = 1, niter
            ! Generate n uniformly distributed random numbers in [0,1)
            call random_number(data)
            ! Compute mean of the current set
            mean_val = compute_mean(data, n)
            ! Compute variance of the current set
            var_val = compute_stddev(data, n, mean_val)**2
            ! Store the computed mean and variance
            means(i) = mean_val
            variances(i) = var_val
        end do

        ! Compute average mean and average variance
        avg_mean = compute_mean(means, niter)
        avg_variance = compute_mean(variances, niter)

        ! Compute standard deviations of means and variances
        stddev_means = compute_stddev(means, niter, avg_mean)
        stddev_vars = compute_stddev(variances, niter, avg_variance)

        ! Compute standard errors
        se_mean = stddev_means / sqrt(real(niter, kind=dp))
        se_variance = stddev_vars / sqrt(real(niter, kind=dp))

        ! Find minimum and maximum of means and variances using minval and maxval
        min_mean = minval(means)
        max_mean = maxval(means)
        min_variance = minval(variances)
        max_variance = maxval(variances)
    end subroutine simulate_uniform_se
end module SimulationModule

program main
    use SimulationModule
    implicit none
    ! Define format string parameters
    character(len=*), parameter :: int_fmt = "(A40, I10)", real_fmt = "(A40, F20.10)"
    ! Variables
    integer :: n, niter
    real(kind=dp) :: avg_mean, avg_variance, se_mean, se_variance
    real(kind=dp) :: min_mean, max_mean, min_variance, max_variance

    ! Set parameters for simulation
    n = 100          ! Number of random numbers in each set
    niter = 10**6    ! Number of iterations

    ! Call the simulation subroutine
    call simulate_uniform_se(n, niter, avg_mean, avg_variance, se_mean, &
        se_variance, min_mean, max_mean, min_variance, max_variance)

    ! Print the results with aligned formatting
    write(*, int_fmt) "Number of observations per data set:", n
    write(*, int_fmt) "Number of data sets:", niter
    write(*, real_fmt) "Average Mean           :", avg_mean
    write(*, real_fmt) "Average Variance       :", avg_variance
    write(*, real_fmt) "Standard Error of Mean :", se_mean
    write(*, real_fmt) "Standard Error of Variance:", se_variance
    write(*, real_fmt) "Minimum Mean           :", min_mean
    write(*, real_fmt) "Maximum Mean           :", max_mean
    write(*, real_fmt) "Minimum Variance       :", min_variance
    write(*, real_fmt) "Maximum Variance       :", max_variance
end program main
