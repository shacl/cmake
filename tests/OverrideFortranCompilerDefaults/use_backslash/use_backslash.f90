program main
  use iso_fortran_env
  implicit none

  open(unit=42, file="terminal_output", status="unknown")
  write(42,'(A)') "hello\nworld"
  close(42)
end program main
