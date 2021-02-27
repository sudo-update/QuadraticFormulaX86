echo "Assemble Quadratic.asm"
nasm -f elf64 -l Quadratic.lis -g -gdwarf -o Quadratic.o Quadratic.asm

echo "Compile Quad_library.cpp using the gcc compiler"
gcc -c -Wall -m64 -no-pie -g -o Quad_library.o Quad_library.cpp

echo "Compile isfloat.cpp using the gcc compiler"
gcc -c -Wall -m64 -no-pie -g -o isfloat.o isfloat.cpp

echo "Compile Second_degree.c using the gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -g -o Second_degree.o Second_degree.c -std=c11

echo "Link the object files using the gcc linker"
#gcc -m64 -no-pie -o QuadraticFormula.out Second_degree.o isfloat.o Quad_library.o Quadratic.o -std=c11
g++ -m64 -no-pie -g -o QuadraticFormula.out Second_degree.o isfloat.o Quad_library.o Quadratic.o -std=c11
echo "Run the program QuadraticFormula:"
./QuadraticFormula.out

echo "The script file will terminate"
