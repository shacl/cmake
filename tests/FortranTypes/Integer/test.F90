program main
  use size_mod, only: integer_size
  use iso_c_binding
  implicit none

#ifdef F90_INT_4BYTE
  integer, parameter :: expected = 4
#endif

#ifdef F90_INT_8BYTE
  integer, parameter :: expected = 8
#endif

  if (integer_size() /= expected) then
     write(*,*) "size: ", integer_size(), ", expected: ", expected
     stop 1
  endif
end program main
