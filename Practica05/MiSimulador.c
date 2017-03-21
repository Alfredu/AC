#include "CacheSim.h"

//Escrito por Aleix Sanchis i Nicolás Francisquelo. 

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */
 struct t_linea{
	unsigned int tag; //Almacenamos aquí el tag de cada linia de cache
	char valid; //Para saber si el contenido de la linea es valido;
 };

struct t_linea cache[128]; //Nuestra cache será un array de 128 lineas. 4k / 32 bytes/linea = 128 lineas;
/*
	
*/
/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al comen�ar cada un dels tests.
 * */
void init_cache ()
{
    totaltime=0.0;
	/* Escriu aqui el teu codi */
	int i;
	for(i=0; i<128;i++){
		cache[i].valid = false;
	}

}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int linea_mc;
	unsigned int tag;
	unsigned int miss;	   // boolea que ens indica si es miss
	unsigned int replacement;  // boolea que indica si es reempla�a una linia valida
	unsigned int tag_out;	   // TAG de la linia reempla�ada
	float t1,t2;		// Variables per mesurar el temps (NO modificar)
	
	t1=GetTime();
	/* Escriu aqui el teu codi */

	tag = (address & 0xFFFFF000)>>12; //Hacemos la mascara y shifteamos para cojer el TAG
	linea_mc = (address & 0xFE0)>>5; //Lo mismo para la linea
	byte = (address & 0x1F); //Y para el offset dentro de la linea;

	bloque_m = address>>5;/*El bloque de memoria es la direccion menos
							los bits de byte*/

	struct t_linea linia = cache[linea_mc];
	if(linia.tag == tag && linia.valid == true){ //si hay hit...
		miss = false;
		replacement = false;
	}
	else{
		miss = true;
		if(linia.valid == true){ //Si reemplazamos una linia valida
			replacement = true;
			tag_out = linia.tag;
		}
		else{
			replacement = false;
		}
		cache[linea_mc].tag = tag;
		cache[linea_mc].valid = true;
	}













	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual. Tamb� mesurem el temps d'execuci�
	 * */
	t2=GetTime();
	totaltime+=t2-t1;
	test_and_print (address, byte, bloque_m, linea_mc, tag,
			miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
  
  
}
