//
//  main.swift
//  Dungeons
//
//  Created by Семён Зайцев on 08.09.2026.
//

import Foundation
import Darwin

randomActive()
let height = 200
let width = 100
let dungeon = generateMaze(Int32(width), Int32(height), 30)

var A: [[String]] = []
var x = height - 2
var y = (width/2)-1

for i in 0..<height {
	var microArr: [String] = []
	for j in 0..<width {
		let pretrans = dungeon![j + i * width]
		if Int(exactly: pretrans)! == 35 {
			microArr.append("#")
		}
		if Int(exactly: pretrans)! == 32 {
			microArr.append(" ")
		}
		if Int(exactly: pretrans)! == 83 {
			microArr.append("S")
			y = j;
		}
		if Int(exactly: pretrans)! == 69 {
			microArr.append("E")
		}
		if Int(exactly: pretrans)! == 63 {
			microArr.append("?")
		}
	}
	
	A.append(microArr)
}

A[x][y] = "@"
enableRawMode()
var inGame = true
var outputItems: [String] = []

while(inGame){
	clearScreen()
	
	var xh = x-10
	var xl = x+10
	var yl = y-10
	var yr = y+10

	while (xh < 0) {
		xh += 1
	}
	while (xl > height) {
		xl -= 1
	}
	while (yl < 0) {
		yl += 1
	}
	while (yr > width) {
		yr -= 1
	}
	
	for i in xh..<xl {
		for j in yl..<yr {
			print(A[i][j], terminator: " ")
		}
		print()
	}
	
	if !outputItems.isEmpty {
		for i in 0..<outputItems.count {
			print(outputItems[i])
			if (outputItems[i] != "Пустой") {
				// Тут будет закидываться в сумку
			}
		}
	}
	outputItems.removeAll()
	
	var input: Int32
	
	repeat {
		input = getchar()
	} while (input != 119 && input != 97 && input != 115 && input != 100 && input != 101)
	
	if (input == 119) && (A[x-1][y] == "E") {
		inGame = false
	}
	
	if (input == 119) && (A[x-1][y] != "#" && A[x-1][y] != "?") {
		A[x][y] = " "
		x = x - 1
		A[x][y] = "@"
	}
	
	if (input == 97) && (A[x][y-1] != "#" && A[x][y-1] != "?") {
		A[x][y] = " "
		y = y - 1
		A[x][y] = "@"
	}
	
	if (input == 115) && (A[x+1][y] != "#" && A[x+1][y] != "?") && (A[x+1][y] != "S") {
		A[x][y] = " "
		x = x + 1
		A[x][y] = "@"
	}
	
	if (input == 100) && (A[x][y+1] != "#" && A[x][y+1] != "?") {
		A[x][y] = " "
		y = y + 1
		A[x][y] = "@"
	}
	
	
	if (input == 101) && (A[x][y+1] == "?" || A[x][y-1] == "?" || A[x+1][y] == "?" || A[x-1][y] == "?") {
		if A[x][y+1] == "?" {
			A[x][y+1] = " "
			outputItems.append(randomItems())
		}
		if A[x][y-1] == "?" {
			A[x][y-1] = " "
			outputItems.append(randomItems())
		}
		if A[x+1][y] == "?" {
			A[x+1][y] = " "
			outputItems.append(randomItems())
		}
		if A[x-1][y] == "?" {
			A[x-1][y] = " "
			outputItems.append(randomItems())
		}
	}
	
}

print("Вы дошли до конца")
disableRawMode()
