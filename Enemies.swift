//
//  Enemies.swift
//  Dungeons
//
//  Created by Семён Зайцев on 12.09.2026.
//

import Foundation

func enemyMove(_ A: [[String]],_ x: Int,_ y: Int) -> [Int] {
		if (A[x+1][y] == "@" || A[x-1][y] == "@" || A[x][y+1] == "@" || A[x][y-1] == "@") &&
			(Int.random(in: 0..<2)==1) {
			return [11111]
			
		}
		if A[x+1][y] == " " && Int.random(in: 0...4) < 1{
			return [x+1, y]
		}
		if A[x-1][y] == " " && Int.random(in: 0...4) < 1{
			return [x-1, y]
		}
		if A[x][y+1] == " " && Int.random(in: 0...4) < 1{
			return [x, y+1]
		}
		if A[x][y-1] == " " && Int.random(in: 0...4) < 1{
			return [x, y-1]
		}
		return []
	}
	
	func ifEnemy(_ A: [[String]],_ x: Int,_ y: Int) -> [[String]] {
		var B = A
		var xh = x-10
		var xl = x+10
		var yl = y-10
		var yr = y+10
		
		while (xh < 0) {
			xh += 1
		}
		while (xl > 200) {
			xl -= 1
		}
		while (yl < 0) {
			yl += 1
		}
		while (yr > 100) {
			yr -= 1
		}
		
		for i in xh..<xl {
			for j in yl..<yr {
				if A[i][j] == "&" {
					let em = enemyMove(A, i, j)
					if !em.isEmpty {
						if em[0] == 11111 {
							let ret: [[String]] = [["fight"]]
							return ret
						} else {
							B[i][j] = " "
							B[em[0]][em[1]] = "&"
						}
					}
				}
			}
		}
		return B
	}
