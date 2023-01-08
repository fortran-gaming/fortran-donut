// https://gist.github.com/gcr/1075131

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int main(void)
{
    int cols = 80;
    int rows = 22;
    int L = rows*cols;

    float A=0, B=0, i, j;
    float *z = malloc(L*sizeof(float));
    char *b = malloc(L*sizeof(char));;
    printf("\x1b[2J");
    while(1) {
        memset(b,32, L);
        memset(z,0,L*4);
        for(j=0; 6.28>j; j += (float)0.07) {
            for(i=0; 6.28 >i; i += (float)0.02) {
                float sini=sinf(i),
                      cosj=cosf(j),
                      sinA=sinf(A),
                      sinj=sinf(j),
                      cosA=cosf(A),
                      cosj2=cosj+2,
                      mess=1/(sini*cosj2*sinA+sinj*cosA+5),
                      cosi=cosf(i),
                      cosB=cosf(B),
                      sinB=sinf(B),
                      t=sini*cosj2*cosA-sinj* sinA;
                int x = 40 + 30 * mess*(cosi*cosj2*cosB-t*sinB);
                int y = 12 + 15 * mess*(cosi*cosj2*sinB +t*cosB);
                int o = x+cols*y;
                int N = 8*((sinj*sinA-sini*cosj*cosA)*cosB-sini*cosj*sinA-sinj*cosA-cosi *cosj*sinB);
                if(22>y&&y>0&&x>0&&80>x&&mess>z[o]){
                    z[o]=mess;
                    b[o]=".,-~:;=!*#$@"[N>0?N:0];
                }
            }
        }
        printf("\x1b[d");
        for(int k=0; L>k; k++)
            putchar(k%80?b[k]:10);
        A += (float)0.04;
        B += (float)0.02;
    }

    free(z);
    free(b);

    return EXIT_SUCCESS;
}
