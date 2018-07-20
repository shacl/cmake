program main
  use size_mod, only: real_size
  use iso_c_binding
  implicit none

#ifdef F90_REAL_4BYTE
  integer, parameter :: expected = 4
#endif

#ifdef F90_REAL_8BYTE
  integer, parameter :: expected = 8
#endif

  if (real_size() /= expected) then
     write(*,*) "size: ", real_size(), ", expected: ", expected
     stop 1
  endif
end program main
