#include <stdio.h>
#include <stdlib.h>
#include <libelektro/libresistance.h>
#include <libelektro/libpower.h>
#include <libelektro/libcomponent.h>

int main()
{
    float voltage;
    int i;
    char conn;
    char component;
    int count;
    float *componentsresistance;
    float totalresistance;
	float current;
    float e12[3];
    int e12count;

    printf( "Ange spänningskälla[V]: " );
    scanf( "%f", &voltage );
    getchar();

    printf( "Ange komponenttyp: " );
    scanf( "%c", &component );
    getchar();

    printf( "Ange koppling (s för serie- och p för parallellkoppling): " );
    scanf( "%c", &conn );

    printf( "Ange antalet komponenter: " );
    scanf( "%d", &count );

    componentsresistance = (float*) malloc(count*sizeof(float));

    for (i = 0; i < count; i++)
    {
        printf( "Komponent %d[ohm]: ", i );
        scanf("%f", &componentsresistance[i]);
    }

    totalresistance = calc_resistans(count, conn, componentsresistance);
    printf("\nErsättningsresistans: %g ohm", totalresistance);
    
    /* LibPower */
    if(component == 'R' || component == 'r')
    {
        current = voltage/totalresistance;
        if(calc_power_r(voltage, totalresistance) == calc_power_i(voltage, current))
            printf("\nEffekt: %5.2f W", calc_power_i(voltage, current));
    }
    
    /* LibComponent */
    e12count = e_resistance(totalresistance, e12);
    printf("\nErsättningsresistanser i E12-serien kopplade i serie: ");

    for (i = 0; i < e12count; i++)
    {
        printf("%g, ", e12[i]);
    }

printf("\n");
return 1;
}
