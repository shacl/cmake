program main
  use iso_c_binding
  implicit none
  integer, parameter :: size = c_sizeof(size)

  if (size == 8) then
     stop 0
  else
     write(*,*) "size: ", size
     stop 1
  endif
end program main
