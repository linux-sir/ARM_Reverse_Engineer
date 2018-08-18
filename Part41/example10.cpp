#include <iostream>

int main(void){
	int myNumber = 16;
	int myNewNumber = myNumber ++;
	std::cout << myNewNumber << std::endl;
	std::cout << myNumber << std::endl;
	return 0;
}
