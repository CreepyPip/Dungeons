//
//  generate.c
//  maze
//
//  Created by Семён Зайцев on 26.08.2026.
//

#include "generate.h"




char* generateMaze(int width, int height, int density) {
	
	char* A = malloc(width * height * sizeof(char));
	if (A == NULL) return NULL;
	
	for (int i = 0; i < height * width; i++) {
		A[i] = '#';
	}
	
	// Кол-во контрольных точек
	int checkpoints = ((width*height)/50) + 1;
	// Количество выставленных точек
	int count = 1;
	// Массив контрольных точек
	int* points = malloc((checkpoints + 2) * sizeof(int));
	
	// Точка выхода
	int b = (rand() % (width-2)) + 1; // Выход в случайном месте верхней стенки
	// Выход
	A[b] = 'E';
	// Точка идёт в массив
	points[0] = b + width;
	// Точка входа
	b = width * height - (rand() % (width-2));
	// Вход
	A[b] = 'S';
	
	// Шанс установки контрольной точки
	double chance = ((double)checkpoints / ((double)width*(double)height)) * 100;
	// Цикл установок контрольных точек
	for (int i = 1; i < height - 1; i++) {
		for (int j = 1; j < width - 1; j++) {
			int index = i*width+j;
			if (A[index - width] == 'E' || A[index + width] == 'S') {
				A[index] = ' ';
			}
			if (checkpoints != 0 && rand() % 100 < chance && A[index] != ' ' && i != 1 && i != height - 1) {
				A[index] = ' ';
				points[count] = index;
				count = count + 1;
				checkpoints = checkpoints - 1;
				break;
			}
		}
	}
	// Добавляем вход
	points[count] = b - width;
	
	// Цикл создания прохода
	for (int c = 0; c < count; c++) {
		int there = points[c];
		int minus = points[c];
		int larger = points[c + 1];
		
		while (there != points[c+1]) {

			while (minus - width > 0) {
				minus = minus - width;
			}
						
			while (larger - width > 0) {
				larger = larger - width;
			}
			
			if (larger - minus == 0) {
				if (there < points[c + 1]) {
					A[there+width] = ' ';
					there = there+width;
				} 
				if (there > points[c + 1]) {
					A[there-width] = ' ';
					there = there-width;
				}
			}
			
			if (larger - minus < 0) {
				A[there-1] = ' ';
				there = there - 1;
				minus = minus - 1;
			}
			
			if (larger - minus > 0) {
				A[there+1] = ' ';
				there = there + 1;
				minus = minus + 1;
			}
		}
	}
	
	// Цикл шумов
	for (int i = 1; i < height - 1; i++) {
		for (int j = 1; j < width - 1; j++) {
			int index = i*width+j;
			
			if (((A[index - width] == ' ' || 
				  A[index - 2 * width] == ' ' || 
				 A[index - 1] == ' ' || 
				 A[index - (width - 1)] == ' ' || 
				 A[index - (width - 2)] == ' ' || 
				 A[index + width] == ' ' || 
				 A[index + 2 * width] == ' ' || 
				 A[index + width + 2] == ' ' ||
				 A[index + width + 1] == ' ') && 
				 rand() % 100 < density) ||
				rand() % 100 < density/1.5) {
				A[index] = ' ';
			}
		}
	}
	
	// Генерация сундуков
	for (int i = 1; i < height - 1; i++) {
		for (int j = 1; j < width - 1; j++) {
			int index = i*width+j;
			
			if ((A[index - width] == ' ' || 
				 A[index] == ' ' || 
				 A[index - 1] == ' ' || 
				 A[index - (width - 1)] == ' ' || 
				 A[index - (width - 2)] == ' ' || 
				 A[index + width] == ' ' ||  
				 A[index + width + 2] == ' ' ||
				 A[index + width + 1] == ' ') && 
				rand() % 100 < 1) {
				A[index] = '?';
			}
		}
	}
	
	free(points);
	
	return A;
};

void freeMaze(char* maze) {
	free(maze);
};
