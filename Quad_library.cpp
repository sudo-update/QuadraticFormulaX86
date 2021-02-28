#include <stdio.h>
#include <cstdlib>
extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);

void show_no_root() {
  printf("This equation has no real roots.\n");
}
void show_one_root(double root) {
  printf("The root of this equation is %8.6lf\n", root);
}
void show_two_root(double root1, double root2) {
  printf("The roots of this equation are:\n   %8.6lf\n     and\n   %8.6lf\n", root1, root2);
}
