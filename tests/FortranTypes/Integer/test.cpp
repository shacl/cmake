extern "C" {
int integer_size();
}

int main(){

#ifdef F90_INT_4BYTE
  int value = 4;
#endif

#ifdef F90_INT_8BYTE
  int value = 8;
#endif
  
  return integer_size() == value ? 0 : 1;
}
