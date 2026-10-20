//
//  Enemies.c
//  Dungeons
//
//  Created by Семён Зайцев on 14.09.2026.
//

#include "Enemies.h"

char* generateDungeon(int width, int height, int density) {
	char* A = generateMaze(width, height, density);
	double enemyChance = (50.0 / (double)(height*width))*100.0;
	
	for (int i = 1; i < height; i++) {
		for (int j = 1; j < width; j++) {
			int index = i*width+j;
			if (width == 200 && A[index-width] == 'E') {
				A[index] = '$';
			} else 
			if (A[index] != '#' && A[index] != '?' && A[index] != 'E' && A[index] != 'S' && rand() % 100 < enemyChance) {
				A[index] = '&';
			}  
		}
	}
	
	return A;
}
