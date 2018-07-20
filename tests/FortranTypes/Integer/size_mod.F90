module size_mod
  use, intrinsic :: iso_c_binding
  implicit none

contains

  function integer_size() result(s) bind(c,name="integer_size")
    integer :: defint
    integer(c_int) :: s

    s = c_sizeof(defint)
  end function

end module
