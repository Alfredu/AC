#include "CacheSim.h"

void main(){
    int base = 0xeca100;
    int base2 = base + 10240;
    int i=0;
    for(i=0;i<10000;i++){
        reference(base + i*4);
        reference(base2 + i*4);
    }
    final();
}