int main(){
#ifdef F90_REAL_8BYTE
  return 0;
#else
  return 1;
#endif
}
