// https://gist.github.com/gcr/1075131

#include <stdio.h>
#include <string.h>
#include <math.h>

int k;

int main(void)
{
    float A=0, B=0, i, j, z[1760];
    char b[1760];
    printf("\x1b[2J");
    for(; ; ) {
        memset(b,32,1760);
        memset(z,0,7040);
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
                int x = 40 + 30 * mess*(cosi*cosj2*cosB-t*sinB),
                    y = 12 + 15 * mess*(cosi*cosj2*sinB +t*cosB),
                    o = x+80*y,
                    N = 8*((sinj*sinA-sini*cosj*cosA)*cosB-sini*cosj*sinA-sinj*cosA-cosi *cosj*sinB);
                if(22>y&&y>0&&x>0&&80>x&&mess>z[o]){
                    z[o]=mess;
                    b[o]=".,-~:;=!*#$@"[N>0?N:0];
                }
            }
        }
        printf("\x1b[d");
        for(k=0; 1761>k; k++)
            putchar(k%80?b[k]:10);
        A += (float)0.04;
        B += (float)0.02;
    }

    return 0;
}
