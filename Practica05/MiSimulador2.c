#include "CacheSim.h"
#include <stdio.h>

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */

 struct t_linea{
	 unsigned int tag;
	 char valid;
 };

 struct t_set{
	 struct t_linea via[2];
	 char lastUsed;
	 char lruSize;
 };

 struct t_set cache[64];

int h; int m;


/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al comen�ar cada un dels tests.
 * */
void init_cache ()
{
	h=0;m=0;
    totaltime=0.0;
	/* Escriu aqui el teu codi */
	int i=0;
	for(i;i<64;i++){
		cache[i].lruSize = 0;
		cache[i].via[0].valid = false;
		cache[i].via[1].valid = false;
	}
}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int conj_mc;
	unsigned int via_mc;
	unsigned int tag;
	unsigned int miss;	   // boolea que ens indica si es miss
	unsigned int replacement;  // boolea que indica si es reempla�a una linia valida
	unsigned int tag_out;	   // TAG de la linia reempla�ada
	float t1,t2;		// Variables per mesurar el temps (NO modificar)
	
	t1=GetTime();
	/* Escriu aqui el teu codi */

	tag = (address & 0xFFFFF800) >> 11;
	conj_mc = (address & 0x7E0) >> 5;
	bloque_m = address >> 5;
	byte = (address & 0x1F);


	struct t_set set = cache[conj_mc];
	miss = set.lruSize == 0 || (set.lruSize== 1 && set.via[0].tag != tag) || (set.via[0].tag != tag && set.via[1].tag != tag); 
	replacement = (set.lruSize == 2) && miss;
	//No estoy orgulloso del "algoritmo" que viene a continuacion

	if(set.lruSize == 0){ //Primer acceso a ese set, va a la via 0
		via_mc = 0;
		cache[conj_mc].lruSize++;
		cache[conj_mc].lastUsed = 0;

		cache[conj_mc].via[0].tag = tag;
		cache[conj_mc].via[0].valid = true;
	}
	else if(set.lruSize == 1){ //Si hemos usado solo un set
		if(cache[conj_mc].via[0].tag == tag){//si estaba ya en la via 0
			via_mc = 0;
			cache[conj_mc].lastUsed = 0;
		}
		else{ //No estara en la via 1 ya que solo habiamos usado un set
			via_mc = 1;
			cache[conj_mc].lruSize++;
			cache[conj_mc].lastUsed = 1;
			cache[conj_mc].via[1].tag = tag;
		}
	}
	else{
		if(cache[conj_mc].via[0].tag == tag){
			cache[conj_mc].lastUsed = 0;
			via_mc = 0;
		}
		else if(cache[conj_mc].via[1].tag == tag){
			cache[conj_mc].lastUsed = 1;
			via_mc = 1;
		}
		else{
			/*Si habiamos usado la via 1 recientemente
			toca usar la 0 y viceversa*/
			via_mc = 1 - cache[conj_mc].lastUsed;
			cache[conj_mc].lastUsed = via_mc;

			tag_out = cache[conj_mc].via[via_mc].tag;
			cache[conj_mc].via[via_mc].tag = tag;
		}
	}

	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual. Tamb� mesurem el temps d'execuci�
	 * */

	if(miss) m++; else h++;
	t2=GetTime();
	totaltime+=t2-t1;
	test_and_print2 (address, byte, bloque_m, conj_mc, via_mc, tag,
			miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
	 printf("El numero de hits es: %d \nEl numero de misses es %d\n", h, m);
  
}
