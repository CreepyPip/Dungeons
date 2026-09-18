//
//  Fight.swift
//  Dungeons
//
//  Created by Семён Зайцев on 18.09.2026.
//

import Foundation


class inFight {
	var hpPlayer = 100
	
	init() {}
	
	func fighting() -> Bool {
		var hpBot = 30
		var blow = false
		while (hpPlayer <= 0 || hpBot <= 0){
			for i in 0..<9 {
				for j in 0..<9 {
					if (i == 0) || (i == 9) || (j == 0) || (j == 9) {
						print("#")
					}
					if (i == 3) && (j == 5) {
						print("&")
					}
					if (i == 5) && (j == 5) {
						print("@")
					}
				}
			}
			print("Здоровье игрока ", hpPlayer)
			print("Здоровье бота ", hpBot, "\n")
			if !blow {
				print("1. Быстрый удар")
				print("2. Усиленный удар")
				print("3. Бежать")
				
				
				var input = readLine()
				while input == nil || input != "1" || input != "2" || input != "3" {
					input = readLine()
				}
				
				if input == "1" {
					let damage = Int.random(in: 0...15)
					hpBot = hpBot - damage
				}
				
				if input == "2" {
					blow = true
				}
				
				if input == "3" {
					let escape = Int.random(in: 0..<30)
					if escape > 20 {
						return true
					} else {
						print("Не удалось")
					}
				}
			} else {
				let damage = Int.random(in: 10...35)
				hpBot = hpBot - damage
			}
		}
		
		if hpBot <= 0 {
			return true
		}
		
		return false
	}
}
