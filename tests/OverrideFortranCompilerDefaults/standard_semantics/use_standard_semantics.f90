module foo
  implicit none

contains

integer function bar()
  implicit none
  bar = 1
  return
end function bar

end module

integer function foo_mp_bar()
  implicit none
  foo_mp_bar = 0
  return
end function

program use_standard_semantics
end program
