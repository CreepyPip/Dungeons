//
//  generate.h
//  maze
//
//  Created by Семён Зайцев on 26.08.2026.
//

#ifndef generate_h
#define generate_h

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <stdbool.h>

char* generateMaze(int width, int height, int density);
void freeMaze(char* maze);

#endif /* generate_h */
