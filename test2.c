#include <stdio.h>
//Program that creates and multiplies 2 vectors to run on gem5
int main(){
	//Initialize variables
	int v1[100000];
	int v2[100000];
	int sum = 0;
	//Create Vectors
	for(int i = 0; i < 100000; i++){
		v1[i] = i;
		v2[i] = i;
	}
	//Multiply Vectors
	for(int i = 0; i < 100000; i++){
		sum += v1[i] * v2[i];
	}
	//Print the dot product
	printf("%d", sum);
	return 0;
}
