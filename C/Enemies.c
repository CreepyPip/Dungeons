//
//  Enemies.c
//  Dungeons
//
//  Created by Семён Зайцев on 14.09.2026.
//

#include "Enemies.h"

char* generateDungeon(int width, int height, int density) {
	char* A = generateMaze(width, height, density);
	double enemyChance = (50.0 / 20000.0)*100.0;
	
	for (int i = 1; i < 200; i++) {
		for (int j = 1; j < 200; j++) {
			int index = i*100+j;
			if (A[index] != '#' && A[index] != '?' && A[index] != 'E' && A[index] != 'S' && rand() % 100 < enemyChance) {
				A[index] = '&';
			}
		}
	}
	
	return A;
}
