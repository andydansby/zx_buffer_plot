
// Online C Compiler - Build, Compile and Run your C programs online in your favorite browser

#include<stdio.h>
#include<stdlib.h>



void bresenham (int x1, int x2, int y1, int y2)
{
    int fraction = 0;
    int dy = 0;
    int dx = 0;
    int stepy = 0;
    int stepx = 0 ;

    dy = y2 - y1;
    dx = x2 - x1;
   
    //stepy = (dy < 0) ? -1 : 1;
    if (dy < 0) { stepy = -1;   }
    if (dy > 0) { stepy = 1;    }
   
    //stepx = (dx < 0) ? -1 : 1;
    if (dx < 0) { stepx = -1;   }
    if (dx > 0) { stepx = 1;    }
   
   
    printf("\n");
    printf("stepY = %d",stepy);
    printf("\n");
    printf("stepX = %d",stepx);
   
    dx = abs(dx);
    dy = abs(dy);
    printf("\n");
    printf("dy = %d",dy);
    printf("\n");
    printf("dx = %d",dx);
    printf("\n");

    //plot starting point
    //gfx_x = x1;
    //gfx_y = y1;
    //rtunes_pixel();

    if (dx > dy)
    {
        printf("\nDX Larger\n");
        
        fraction = dy - (dx >> 1);
        printf("fraction = %d\n",fraction);
        do
        {
            //gfx_x = x1;
            //gfx_y = y1;
            //rtunes_pixel();
            printf("x1 = %d    ",x1);
            printf("y1 = %d    ",y1);
            printf("x2 = %d    ",x2);
            printf("y2 = %d    ",y2);
            printf("\n");

            if (fraction >= 0)
            {
                y1 += stepy;
                fraction -= dx;
            }
            x1 += stepx;
            fraction += dy;
        }while (x1 != x2);
    }
   
    else
    {
        printf("\nDY Larger\n");
        fraction = dx - (dy >> 1);
        printf("fraction = %d\n",fraction);
        do
        {
            //gfx_x = x1;
            //gfx_y = y1;
            //rtunes_pixel();
           
            printf("x1 = %d    ",x1);
            printf("y1 = %d    ",y1);
            printf("x2 = %d    ",x2);
            printf("y2 = %d    ",y2);
            printf("\n");

            if (fraction >= 0)
            {
                x1 += stepx;
                fraction -= dy;
            }
            y1 += stepy;
            fraction += dx;
        }while (y1 != y2);
    }
}







int main()
{
    printf("Welcome to Online IDE!! Happy Coding :)");
    //bresenham (int x1, int x2, int y1, int y2)
    bresenham (0, 5, 5, 5);//case 1 DX Larger
    //bresenham (5, 0, 5, 5);//case 2 DX Larger
    //bresenham (5, 5, 0, 5);//case 3 DY Larger
    //bresenham (5, 5, 5, 0);//case 4 DY Larger
    //bresenham (0, 5, 0, 5);//case 5 DY Larger
    //bresenham (0, 5, 5, 0);//case 6 DY Larger
    //bresenham (5, 0, 0, 5);//case 7 DY Larger
    //bresenham (5, 0, 5, 0);//case 8 DY Larger
    //bresenham (0, 512, 0, 512);//case 8 DY Larger
   
    return 0;
}