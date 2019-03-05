module abi

private

interface
  subroutine func_c() bind(c)
  end subroutine
end interface

public func

contains

subroutine func
  call func_c
end subroutine

end module

program main
  use abi, only: func

  call func
end program main
