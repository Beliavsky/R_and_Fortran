module r_mod
! emulate some R functions for descriptive statistics
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    public :: dp, mean, sd, var, median, min_max, quantile, IQR, prod

    ! Interfaces to overload functions for real and integer arguments
    interface mean
        module procedure mean_real
        module procedure mean_int
    end interface

    interface sd
        module procedure sd_real
        module procedure sd_int
    end interface

    interface var
        module procedure var_real
        module procedure var_int
    end interface

    interface median
        module procedure median_real
        module procedure median_int
    end interface

    interface min_max
        module procedure min_max_real
        module procedure min_max_int
    end interface

    interface quantile
        module procedure quantile_real
        module procedure quantile_int
    end interface

    interface IQR
        module procedure IQR_real
        module procedure IQR_int
    end interface

    interface prod
        module procedure prod_real
        module procedure prod_int
    end interface

contains

    ! Function to compute the mean for real(kind=dp) array
    function mean_real(x) result(mean_val)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp) :: mean_val
        mean_val = sum(x) / real(size(x), kind=dp)
    end function mean_real

    ! Function to compute the mean for integer array
    function mean_int(x) result(mean_val)
        integer, intent(in) :: x(:)
        real(kind=dp) :: mean_val
        mean_val = sum(real(x, kind=dp)) / real(size(x), kind=dp)
    end function mean_int

    ! Function to compute standard deviation for real(kind=dp) array
    function sd_real(x) result(sd_val)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp) :: sd_val, m
        integer :: n
        n = size(x)
        if (n > 1) then
            m = mean_real(x)
            sd_val = sqrt(sum((x - m)**2) / real(n - 1, kind=dp))
        else
            sd_val = 0.0_dp
        end if
    end function sd_real

    ! Function to compute standard deviation for integer array
    function sd_int(x) result(sd_val)
        integer, intent(in) :: x(:)
        real(kind=dp) :: sd_val, m
        integer :: n
        n = size(x)
        if (n > 1) then
            m = mean_int(x)
            sd_val = sqrt(sum((real(x, kind=dp) - m)**2) / real(n - 1, kind=dp))
        else
            sd_val = 0.0_dp
        end if
    end function sd_int

    ! Function to compute variance for real(kind=dp) array
    function var_real(x) result(var_val)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp) :: var_val
        var_val = sd_real(x)**2
    end function var_real

    ! Function to compute variance for integer array
    function var_int(x) result(var_val)
        integer, intent(in) :: x(:)
        real(kind=dp) :: var_val
        var_val = sd_int(x)**2
    end function var_int

    ! Function to compute median for real(kind=dp) array
    function median_real(x) result(median_val)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp) :: median_val
        integer :: n
        real(kind=dp), allocatable :: sorted_x(:)
        n = size(x)
        sorted_x = x
        call sort_real_array(sorted_x)
        if (mod(n, 2) == 1) then
            median_val = sorted_x((n + 1) / 2)
        else
            median_val = (sorted_x(n / 2) + sorted_x(n / 2 + 1)) / 2.0_dp
        end if
    end function median_real

    ! Function to compute median for integer array
    function median_int(x) result(median_val)
        integer, intent(in) :: x(:)
        real(kind=dp) :: median_val
        integer :: n
        integer, allocatable :: sorted_x(:)
        n = size(x)
        sorted_x = x
        call sort_int_array(sorted_x)
        if (mod(n, 2) == 1) then
            median_val = real(sorted_x((n + 1) / 2), kind=dp)
        else
            median_val = real(sorted_x(n / 2) + sorted_x(n / 2 + 1), kind=dp) / 2.0_dp
        end if
    end function median_int

    ! Function to compute min and max for real(kind=dp) array
    function min_max_real(x) result(range_vals)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp), dimension(2) :: range_vals
        range_vals(1) = minval(x)
        range_vals(2) = maxval(x)
    end function min_max_real

    ! Function to compute min and max for integer array
    function min_max_int(x) result(range_vals)
        integer, intent(in) :: x(:)
        integer, dimension(2) :: range_vals
        range_vals(1) = minval(x)
        range_vals(2) = maxval(x)
    end function min_max_int

    ! Function to compute quantiles for real(kind=dp) array using R's Type 7 method
    function quantile_real(x, probs) result(quantiles)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp), intent(in) :: probs(:)
        real(kind=dp), allocatable :: quantiles(:)
        real(kind=dp), allocatable :: sorted_x(:)
        integer :: n, i, j
        real(kind=dp) :: h, g
        n = size(x)
        sorted_x = x
        call sort_real_array(sorted_x)
        allocate(quantiles(size(probs)))
        do i = 1, size(probs)
            if (probs(i) >= 0.0_dp .and. probs(i) <= 1.0_dp) then
                h = (real(n - 1, kind=dp)) * probs(i) + 1.0_dp
                j = int(floor(h))
                g = h - real(j, kind=dp)
                if (j >= n) then
                    quantiles(i) = sorted_x(n)
                else if (j < 1) then
                    quantiles(i) = sorted_x(1)
                else
                    quantiles(i) = (1.0_dp - g) * sorted_x(j) + g * sorted_x(j + 1)
                end if
            else
                quantiles(i) = 0.0_dp
            end if
        end do
    end function quantile_real

    ! Function to compute quantiles for integer array using R's Type 7 method
    function quantile_int(x, probs) result(quantiles)
        integer, intent(in) :: x(:)
        real(kind=dp), intent(in) :: probs(:)
        real(kind=dp), allocatable :: quantiles(:)
        integer, allocatable :: sorted_x(:)
        integer :: n, i, j
        real(kind=dp) :: h, g
        n = size(x)
        sorted_x = x
        call sort_int_array(sorted_x)
        allocate(quantiles(size(probs)))
        do i = 1, size(probs)
            if (probs(i) >= 0.0_dp .and. probs(i) <= 1.0_dp) then
                h = (real(n - 1, kind=dp)) * probs(i) + 1.0_dp
                j = int(floor(h))
                g = h - real(j, kind=dp)
                if (j >= n) then
                    quantiles(i) = real(sorted_x(n), kind=dp)
                else if (j < 1) then
                    quantiles(i) = real(sorted_x(1), kind=dp)
                else
                    quantiles(i) = (1.0_dp - g) * real(sorted_x(j), kind=dp) + g * real(sorted_x(j + 1), kind=dp)
                end if
            else
                quantiles(i) = 0.0_dp
            end if
        end do
    end function quantile_int

    ! Function to compute interquartile range for real(kind=dp) array
    function IQR_real(x) result(iqr_val)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp) :: iqr_val
        real(kind=dp), allocatable :: qs(:)
        qs = quantile_real(x, [0.25_dp, 0.75_dp])
        iqr_val = qs(2) - qs(1)
    end function IQR_real

    ! Function to compute interquartile range for integer array
    function IQR_int(x) result(iqr_val)
        integer, intent(in) :: x(:)
        real(kind=dp) :: iqr_val
        real(kind=dp), allocatable :: qs(:)
        qs = quantile_int(x, [0.25_dp, 0.75_dp])
        iqr_val = qs(2) - qs(1)
    end function IQR_int

    ! Function to compute product for real(kind=dp) array
    function prod_real(x) result(prod_val)
        real(kind=dp), intent(in) :: x(:)
        real(kind=dp) :: prod_val
        prod_val = product(x)
    end function prod_real

    ! Function to compute product for integer array
    function prod_int(x) result(prod_val)
        integer, intent(in) :: x(:)
        integer :: prod_val
        prod_val = product(x)
    end function prod_int

    ! Subroutine to sort real(kind=dp) array
    subroutine sort_real_array(a)
        real(kind=dp), intent(inout) :: a(:)
        call quicksort_real(a, 1, size(a))
    end subroutine sort_real_array

    ! Subroutine to sort integer array
    subroutine sort_int_array(a)
        integer, intent(inout) :: a(:)
        call quicksort_int(a, 1, size(a))
    end subroutine sort_int_array

    ! Quicksort algorithm for real(kind=dp) array
    recursive subroutine quicksort_real(a, left, right)
        real(kind=dp), intent(inout) :: a(:)
        integer, intent(in) :: left, right
        integer :: i, j
        real(kind=dp) :: pivot, temp
        if (left < right) then
            pivot = a((left + right) / 2)
            i = left
            j = right
            do
                do while (a(i) < pivot)
                    i = i + 1
                end do
                do while (pivot < a(j))
                    j = j - 1
                end do
                if (i <= j) then
                    temp = a(i)
                    a(i) = a(j)
                    a(j) = temp
                    i = i + 1
                    j = j - 1
                end if
                if (i > j) exit
            end do
            call quicksort_real(a, left, j)
            call quicksort_real(a, i, right)
        end if
    end subroutine quicksort_real

    ! Quicksort algorithm for integer array
    recursive subroutine quicksort_int(a, left, right)
        integer, intent(inout) :: a(:)
        integer, intent(in) :: left, right
        integer :: i, j
        integer :: pivot, temp
        if (left < right) then
            pivot = a((left + right) / 2)
            i = left
            j = right
            do
                do while (a(i) < pivot)
                    i = i + 1
                end do
                do while (pivot < a(j))
                    j = j - 1
                end do
                if (i <= j) then
                    temp = a(i)
                    a(i) = a(j)
                    a(j) = temp
                    i = i + 1
                    j = j - 1
                end if
                if (i > j) exit
            end do
            call quicksort_int(a, left, j)
            call quicksort_int(a, i, right)
        end if
    end subroutine quicksort_int

end module r_mod
