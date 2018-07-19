program main
  use iso_c_binding
  implicit none
  integer :: size

  size = c_sizeof(size)

  if (size /= 8) then
     write(*,*) "size: ", size
     stop 1
  endif
end program main
