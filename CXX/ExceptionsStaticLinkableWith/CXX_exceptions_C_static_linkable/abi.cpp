#include <stdexcept>

extern "C" {

void func_c() {
  try{
    throw std::runtime_error("runtime error");
  }
  catch(...) {}
}

}
