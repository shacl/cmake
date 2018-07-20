module size_mod
  use, intrinsic :: iso_c_binding
  implicit none

contains

  function real_size() result(s) bind(c,name="real_size")
    real :: defreal
    integer(c_int) :: s

    s = c_sizeof(defreal)
  end function

end module
