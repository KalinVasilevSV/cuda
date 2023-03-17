#include <stdlib.h>
#include <stdio.h>
#include <vector>
#include <iostream>

__global__
void add(float *a, float *b, float *c, long size){
    for(int i = 0; i< size;i++)
        c[i] = a[i] * b[i];
}

int main(void)
{
    long size = 3;
    float *a, *b,*c;

    cudaMallocManaged(&a,sizeof(float)*size);
    cudaMallocManaged(&b,sizeof(float)*size);
    cudaMallocManaged(&c,sizeof(float)*size);

    for(int i=0;i<size;i++){
        a[i]=1.0;
        b[i]=2.0;
        c[i]=0.5;
    }

    add<<<1,1>>>(a,b,c,size);

    cudaDeviceSynchronize();

    for(int i=0;i<size;i++){
        printf("%f ",c[i]);
    }

    cudaFree(a);
    cudaFree(b);
    cudaFree(c);
}
