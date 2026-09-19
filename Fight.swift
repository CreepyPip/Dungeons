//
//  Fight.swift
//  Dungeons
//
//  Created by Семён Зайцев on 18.09.2026.
//

import Foundation


class inFight {
	private var hpPlayer = 100
	
	init() {}
	
	func fighting() -> Bool {
		var hpBot = 30
		var blow = false
		while (hpPlayer > 0 && hpBot > 0){
			clearScreen()
			for i in 0..<9 {
				for j in 0..<9 {
					if (i == 0) || (i == 8) || (j == 0) || (j == 8) {
						print("#", terminator: " ")
					} else
					if (i == 3) && (j == 4) {
						print("&", terminator: " ")
					} else
					if (i == 5) && (j == 4) {
						print("@", terminator: " ")
					} else
					{
						print(" ", terminator: " ")
					}
				}
				print("")
			}
			print("Здоровье игрока ", hpPlayer)
			print("Здоровье бота ", hpBot, "\n")
			if !blow {
				print("1. Быстрый удар")
				print("2. Усиленный удар")
				print("3. Бежать")
				
				var input = readLine()
				while input == nil || (input != "1" && input != "2" && input != "3") {
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
				blow = false
			}
			if hpBot <= 0 {break}
			hpPlayer = hpPlayer - Int.random(in: 0..<15)
		}
		
		clearScreen()
		print("Здоровье игрока ", hpPlayer)
		print("Здоровье бота ", hpBot, "\n")
		
		print("Нажмите Enter")
		let _ = readLine()
		
		if hpPlayer <= 0 {
			return false
		}
		
		return true
	}
}
