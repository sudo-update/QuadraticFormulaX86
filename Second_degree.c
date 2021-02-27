#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern double Quadratic();

int main(int argc, char* argv[]) {
  double result_of_Quadratic;
  result_of_Quadratic = 0.0;
  printf("Welcome to Quadratic Formula.\nA program by Sean Javiya.\n");
  result_of_Quadratic = Quadratic();
  printf("The main driver has recieved %8.6lf, and has decided to keep it.\n0 will be returned to the operating system.\nGoodbye.\n", result_of_Quadratic);
  return 0;
}
