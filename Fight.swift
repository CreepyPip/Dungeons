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
	
	private func battleField() {
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
	}
	
	func fighting() -> Bool {
		var hpBot = 30
		var blow = false
		while (hpPlayer > 0 && hpBot > 0){
			clearScreen()
			battleField()
			
			print("Здоровье игрока ", hpPlayer)
			print("Здоровье бота ", hpBot, "\n")
			if !blow {
				print("1. Быстрый удар")
				print("2. Усиленный удар")
				print("3. Бежать")
				
				var input = readLine()
				let fastHitInput = "1"
				let rfHitInput = "2"
				let runInput = "3"
				while input == nil || (input != fastHitInput && input != rfHitInput && input != runInput) {
					input = readLine()
				}
				
				if input == fastHitInput {
					let damage = Int.random(in: 0...15)
					hpBot = hpBot - damage
					print("Нанесено игроком ", damage)
					Thread.sleep(forTimeInterval: 1.0)
				}
				
				if input == rfHitInput {
					blow = true
				}
				
				if input == runInput {
					let escape = Int.random(in: 0..<30)
					if escape > 20 {
						return true
					} else {
						print("Не удалось")
					}
				}
			} else {
				Thread.sleep(forTimeInterval: 1.0)
				let damage = Int.random(in: 10...35)
				hpBot = hpBot - damage
				print("Нанесено игроком ", damage)
				Thread.sleep(forTimeInterval: 1.0)
				blow = false
			}
			Thread.sleep(forTimeInterval: 1.0)
			if hpBot <= 0 {break}
			let damageP = Int.random(in: 0..<15)
			hpPlayer = hpPlayer - damageP
			print("Нанесено игроку ", damageP)
			Thread.sleep(forTimeInterval: 1.0)
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
