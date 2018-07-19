program main
  implicit none
  real :: dummy
  integer :: size

  size = storage_size(dummy)
  if (size /= 64) then
     write(*,*) "size: ", size / 8
  endif
end program main
