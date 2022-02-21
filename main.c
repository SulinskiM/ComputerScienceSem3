#include <stdio.h>
#include <stdbool.h>
#include <xmmintrin.h>

struct element
{
	char a;
	unsigned int b;
};

typedef unsigned int bitboard;

typedef struct board {
	bitboard white_pieces;
	bitboard black_pieces;
	bitboard kings;
};

float srednia_harm(float* tablica, unsigned int n);
float srednia_arytmetyczna(float* tablica, unsigned int n);
float srednia_potegowa_2(float* tablica, unsigned int n);
float nowy_exp(float x);
float format_float(float x);
bool czy_pierwsza(unsigned int number);
int* wpisz_pierwsze(int* tablica, int n);
int silnia(int n);
int zapal(float Tx);
int strcmp(const char* str1, const char* str2);
void hahaha(unsigned char a, unsigned char b, unsigned char c, unsigned char d);
unsigned int zlicz_falszerstwa(char* wejscie, char klucz);
double* odleglosc(float x, float y, float z);
unsigned int NWD(unsigned int x, unsigned int y);
unsigned int NWW(unsigned int x, unsigned int y);
int polacz(int* tab1, int* tab2, int* tab3, int n1, int n2);
float liczba(unsigned short* n);
void przesun(unsigned long long *a, char n);
void dodaj(unsigned long long* a, unsigned long long* b);
void _mul_24(unsigned long long* in, unsigned long long* out);
void posortuj(int* tablica, int s, int w);
float liczba_pi(int n);
void sortuj(void* tablica, unsigned int n);
void* wystapienia(void* obszar, unsigned int n);
void float_to_FP24(float x);
char* parse_fen_element(char* fem, int* num, int* king);
int set_bitboards_from_fen(void* b, char* fen);
void zabawa();
float potega(float x, unsigned int n);
void wpisz(void* tab, int i, int j, int m, int a);
float srednia_kwadratowa(float a, float b, float c);
int mul_100(int liczba);
float power_2(float exponent);
float power_10(float exponent);
float valueFunction(float exponent);
float rootFunction();
int* addMatrix(int* matrixA, int* matrixB, unsigned int xA, unsigned int yA, unsigned int xB, unsigned int yB);
int determinant_2x2(int* matrix);
int determinant_3x3(int* matrix);
int determinant(int* matrix, unsigned int size);
int determinant_recursion(int* matrix, unsigned int size);
int* deletedMatrix(int* matrix, unsigned int size, unsigned int deleted);

void printMatrix(int* matrix, int x, int y)
{
	for (int i = 0; i < x; i++)
	{
		for (int j = 0; j < y; j++)
		{
			printf("	%d ", *matrix);
			matrix++;
		}
		printf("\n");
	}
	printf("\n");
	printf("\n");
}

int main()
{
	int matrixD[2][2] = {3, 4, 6, -3};
	int matrixA[3][3] = { 8, 2, 3, -4, 1, -6, 7, 8, 9 }, matrixB[3][3] = { 9, 8, 7, 6, 5, 4, 3, 2, 1 };
	int matrixW[6][6] = { 91, -2, -3, 4, 5, 6, 87, 88, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, -22, 23, 24, 25, 26, 27, 28, 29, 30, 31, -32, 33, 34, 35, 36};
	int matrixP[5][5] = { 1, 2, 3, 4, 5, 6, 7, -8, 9, 10, 11, -12, 13, 14, 15, 16, 17, 18, -19, 20, 21, 22, 23, 24, 25};
	int matrixY[4][4] = { -1, 2, 3, 4, 5, 6, -7, -8, -9, 10, 13, 12, 13, 14, 15, 16};
	int xA = 3, yA = 3, xB = 3, yB = 3;
	
	int determinantY = determinant_recursion(matrixW, 6);
	printf("Matrix determinant: %d \n", determinantY);
	

	/*for (int i = 0; i < xA; i++)
	{
		for (int j = 0; j < yA; j++)
			printf("%d ", matrixA[i][j]);
		printf("\n");
	}
	printf("\n");
	printf("\n");

	for (int i = 0; i < xB; i++)
	{
		for (int j = 0; j < yB; j++)
			printf("%d ", matrixB[i][j]);
		printf("\n");
	}
	printf("\n");
	printf("\n");

	int* matrixC = addMatrix(matrixA, matrixB, xA, yA, xB, yB);

	for (int i = 0; i < xA; i++)
	{
		for (int j = 0; j < yA; j++)
		{
			printf("%d ", *matrixC);
			matrixC++;
		}
		printf("\n");
	}
	//float wynik = valueFunction(0.932);
	//float root = rootFunction();
	//printf("Value: %f \n", wynik);
	//printf("Root: %f \n", root);

	//float potega = power_2(0.9432);
	//printf("%f \n", potega);
	//potega = power_10(0.9432);
	//printf("%f \n", potega);

	//float wynik = srednia_kwadratowa(3.0, 4.0, 5.0);
	//printf("%f \n", wynik);
	//float wynik = potega(5.1, 10);
	//printf("%f \n", wynik);
	/*int tab[10][10];

	for (int i = 0; i < 10; i++)
		for (int j = 0; j < 10; j++)
			tab[i][j] = 0;

	tab[2][4] = 1;
	tab[2][5] = 9;
	tab[3][4] = 16;

	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
			printf("	%d ", tab[i][j]);
		printf("\n");
	}

	printf("\n");
	printf("\n");

	wpisz(tab, 5, 3, 10, 19);

	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
			printf("	%d ", tab[i][j]);
		printf("\n");
	}

	/*zabawa();
	char* napis = "B:WK10,K15,18,24,27,28:B12,16,20,K22,K25,K29";
	int liczba, wartosc;
	int* c = &liczba;
	int* d = &wartosc;
	struct board tablica;
	struct board* wsk = &tablica;
	set_bitboards_from_fen(wsk, napis);
	char* b = parse_fen_element(napis + 3, c, d);

	printf("%d %d \n%s \n", liczba, wartosc, b);

	b = parse_fen_element(b + 1, c, d);

	printf("%d %d \n%s \n", liczba, wartosc, b);

	b = parse_fen_element(b + 1, c, d);

	printf("%d %d \n%s \n", liczba, wartosc, b);
	//float_to_FP24(0);
	/*char* tab = "gsdgfdgdfgdstretyfdgfdhdfsghfdastrtrtegcbdfhfdh";
	int n = 40;
	char* a = wystapienia(tab, n);
	char* t = a;
	char c = *a;
	a += 1;
	int b = *((int*)a);
	a += 4;

	for (int i = 0; i < 256; i++)
	{
		printf("%c %d %d\n", c, c, b);
		c = *a;
		a += 1;
		b = *((int*)a);
		a += 4;
	}
	sortuj(t, 256);
	c = *t;
	t += 1;
	b = *((int*)t);
	t += 4;

	for (int i = 0; i < 256; i++)
	{
		printf("%c %d %d\n", c, c, b);
		c = *t;
		t += 1;
		b = *((int*)t);
		t += 4;
	}*/
/*	struct element tab[10];

	tab[0].a = 12;
	tab[0].b = 0x00000003;
	tab[1].a = 11;
	tab[1].b = 12;
	tab[2].a = 15;
	tab[2].b = 443;
	tab[3].a = 18;
	tab[3].b = 7243;
	tab[4].a = 11;
	tab[4].b = 8743;
	tab[5].a = 10;
	tab[5].b = 43;
	tab[6].a = 5;
	tab[6].b = 943;
	tab[7].a = 127;
	tab[7].b = 643;
	tab[8].a = 14;
	tab[8].b = 243;
	tab[9].a = 19;
	tab[9].b = 73;

	for (int i = 0; i < 10; i++)
	{
		printf("%d %d\n", tab[i].a, tab[i].b);
	}
	printf("\n\n");
	sortuj(tab, 10);

	for (int i = 0; i < 10; i++)
	{
		printf("%d %d\n", tab[i].a, tab[i].b);
	}

	//printf("%f \n\n", liczba_pi(5800080));

	/*int tablica[10][10];

	posortuj(tablica, 10, 10);

	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
		{
			printf("%d ", tablica[i][j]);
		}
		printf("\n");
	}*/
	/*unsigned long long a = 0x0000012324343234;
	unsigned long long b = 0x0FFFFFFFFFFFFFFF;
	unsigned long long* c = &a;
	unsigned long long* d = &b;*/
	// __m128 a = 0x42342;
	//unsigned short a = 143;
	//unsigned short* n = &a;
	// float lic = liczba(n);
	//printf("%25llu \n", b);

	//przesun(b, 10);
	//dodaj(c, d);
	//_mul_24(c, d);

	//printf("%25llu ", b);

	/*int tab1[20] = {1, 2, 5, 6, 7, 43, 112};
	int tab2[20] = { 5, 6, 10, 16, 27 };
	int tab3[30];
	int n = polacz(tab1, tab2, tab3, 7, 5);

	for (int i = 0; i < 7; i++)
		printf("%d ", tab1[i]);
	printf("\n");
	for (int i = 0; i < 5; i++)
		printf("%d ", tab2[i]);
	printf("\n");
	for (int i = 0; i < n; i++)
		printf("%d ", tab3[i]);
	printf("\n");*/

	//int wynik = NWD(48, 60);
	//printf("%d \n", wynik);

	//int wynik2 = NWW(48, 60);
	//printf("%d \n", wynik2);
	//double* wynik = odleglosc(3.0, 4.0, 5.0);
	//printf("%f \n", *wynik);
	//int wynik = zlicz_falszerstwa(";{'tekst':sdasd,'szyfr':0xB1};{'tekst':sdasd,'szyfr':0xB1};{'tekst':sdasd,'szyfr':0xB2};", 177);
	//printf("%d \n", wynik);
	
	//int a = zapal(12.42);
	//int n = 20;
	//int s = silnia(n);

	//int tablica[10], n = 10;
	//wpisz_pierwsze(tablica, n);

	//int number = 17;

	//if (czy_pierwsza(number))
	//	printf("Liczba pierwsza!");
	//else
	//	printf("Liczba nie pierwsza!");

	//format_float(21.33);
	/*float* tablica = malloc(100);

	tablica[0] = 18.32;
	tablica[1] = 5.0;
	tablica[2] = 8.0;
	tablica[3] = 7.0;
	tablica[4] = 11.0;
	tablica[5] = 4.0;
	tablica[6] = 3.0;
	tablica[7] = 9.2421;
	tablica[8] = 8.2421;
	tablica[9] = 7.2421;
	tablica[10] = 6.2421;

	int n = 7;

	float wynik = srednia_harm(tablica, n);// nowy_exp(tablica[0]);  //srednia_harm(tablica, n);
	printf("Srednia harmoniczna: %f\n\n", wynik);

	wynik = srednia_arytmetyczna(tablica, n);
	printf("Srednia arytmetyczna: %f\n\n", wynik);

	wynik = srednia_potegowa_2(tablica, n);
	printf("Srednia potêdowa (^2): %f\n\n", wynik);

	for (int i = 0; i < n; i++)
		printf("%f\n", tablica[i]);
		*/
	return 0;
 }
