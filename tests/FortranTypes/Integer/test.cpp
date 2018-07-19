int main(){
#ifdef F90_INT_8BYTE
  return 0;
#else
  return 1;
#endif
}
