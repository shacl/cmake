program main
  use iso_c_binding
  implicit none
  real :: dummy
  integer, parameter :: size = c_sizeof(dummy)

  if (size == 8) then
     stop 0
  else
     write(*,*) "size: ", size
     stop 1
  endif
end program main
