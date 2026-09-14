//
//  Enemies.swift
//  Dungeons
//
//  Created by Семён Зайцев on 12.09.2026.
//

import Foundation

func arrangementEnemies(_ dungeon: [[String]]) -> [[String]] {
	let enemyChance = 50.0 / 20000.0
	var resDung = dungeon
	
	for i in 0..<200 {
		for j in 0..<100 {
			if (resDung[i][j] != "#" && resDung[i][j] != "?" && resDung[i][j] != "E" && resDung[i][j] != "S") &&
				(Double.random(in: 0.0...1.0) < enemyChance) {
				resDung[i][j] = "&"
			}
		}
	} 
	return resDung
}

func ifEnemy(_ A: [[String]],_ x: Int,_ y: Int) {
	var xh = x-10
	var xl = x+10
	var yl = y-10
	var yr = y+10
}
