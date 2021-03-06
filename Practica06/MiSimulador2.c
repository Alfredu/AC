#include "CacheSim.h"

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */


struct t_linea{
	unsigned int tag; //Almacenamos aquí el tag de cada linia de cache
	char valid; //Para saber si el contenido de la linea es valido;
	char dirty; //Dancing
 };
struct t_linea cache[128]; //Nuestra cache será un array de 128 lineas. 4k / 32 bytes/linea = 128 lineas;

 int h; int m;

/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al comen�ar cada un dels tests.
 * */
void init_cache ()
{
	h=0;m=0;
	/* Escriu aqui el teu codi */
	int i;
	for(i=0; i<128;i++){
		cache[i].valid = false;
		cache[i].dirty = false;
	}


}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address, unsigned int LE)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int linea_mc;
	unsigned int tag;
	unsigned int miss;
	unsigned int lec_mp;
	unsigned int mida_lec_mp;
	unsigned int esc_mp;
	unsigned int mida_esc_mp;
	unsigned int replacement;
	unsigned int tag_out;

	
	
	/* Escriu aqui el teu codi */
	tag = (address & 0xFFFFF000)>>12; //Hacemos la mascara y shifteamos para cojer el TAG
	linea_mc = (address & 0xFE0)>>5; //Lo mismo para la linea
	byte = (address & 0x1F); //Y para el offset dentro de la linea;

	bloque_m = address>>5;/*El bloque de memoria es la direccion menos
							los bits de byte*/


	miss = !cache[linea_mc].valid || cache[linea_mc].tag!=tag;

	replacement = cache[linea_mc].valid && miss;

	lec_mp = miss;

	cache[linea_mc].dirty = (LE && !miss) || cache[linea_mc].dirty;

	esc_mp = replacement && cache[linea_mc].dirty;
	
	mida_lec_mp = 32 * lec_mp;	
	mida_esc_mp = 32 * esc_mp;

	if(miss){
		if(replacement){
			tag_out = cache[linea_mc].tag;
		}
			cache[linea_mc].valid = true;
			cache[linea_mc].dirty = LE;
			cache[linea_mc].tag = tag;
	}

	if(miss) m++; else h++;
	
	


	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual
	 * */
	test_and_print (address, LE, byte, bloque_m, linea_mc, tag,
			miss, lec_mp, mida_lec_mp, esc_mp, mida_esc_mp,
			replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
	printf("Numero de hits: %d\nNumero de miss: %d\n", h,m);
  
  
}
