#include <string>
#include <iostream>

extern "C" {

void func_c() {
  try{
    throw std::runtime_error("runtime error");
  }
  catch(...) {}
}

}
