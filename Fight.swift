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
	
	func startBattle(_ AA: [[String]],_ x: Int,_ y: Int,_ inv: InventoryBridge) -> [[String]] {
		var A = AA
		
		disableRawMode()
		let ff = fighting(inv)
		enableRawMode()
		if ff == false {
			return [["False"]]
		} else {
			if (x + 1 != height-1) { A[x + 1][y] = " " }
			if (x - 1 != 0) { A[x - 1][y] = " " }
			if (y + 1 != width-1) { A[x][y + 1] = " " }
			if (y - 1 != 0) { A[x][y - 1] = " " }
			view(A, x, y)
		}
		return A
	}
	
	private func inventoryInFight(_ inv: InventoryBridge) -> String {
		var returnText = ""
		let belt = inv.outBelt()!
		if !belt.isEmpty{
			for i in 0..<belt.count {
				print(i+1, belt[i])
			}
		} else {return ""}
		print(belt.count+1, "Выход из инвентаря")
		
		var input = readLine()!
		
		while Int(input) == nil && (Int(input)! <= 0 || Int(input)! > belt.count) {
			input = readLine()!
		}
		
		if Int(input)! != belt.count+1 {
			returnText = belt[Int(input)! - 1]
			inv.deleteItem(fromBelt: Int32(input)!)
		}
		
		return returnText
	}
	
	private func fighting(_ inv: InventoryBridge) -> Bool {
		var hpBot = 30
		var blow = false
		let minDamageFromBot = 0
		var maxDamageFromBot = 15
		var minDamage = 0
		var maxDamage = 15
		while (hpPlayer > 0 && hpBot > 0){
			clearScreen()
			battleField()
			
			print("Здоровье игрока ", hpPlayer)
			print("Здоровье бота ", hpBot, "\n")
			if !blow {
				print("1. Быстрый удар")
				print("2. Усиленный удар")
				print("3. Инвентарь")
				print("4. Бежать")
				
				var input = readLine()
				let fastHitInput = "1"
				let rfHitInput = "2"
				let inventory = "3"
				let runInput = "4"
				while input == nil || (input != fastHitInput && input != rfHitInput && input != runInput && input != inventory) {
					input = readLine()
				}
				
				switch input {
					case fastHitInput:
						let damage = Int.random(in: minDamage...maxDamage)
						hpBot = hpBot - damage
						print("Нанесено игроком ", damage)
						Thread.sleep(forTimeInterval: 1.0)
						break
					case rfHitInput:
						blow = true
						break
					case inventory:
						clearScreen()
						let itemFromBelt = inventoryInFight(inv)
						clearScreen()
						let poisons: [String] = ["Зелье скрытности", "Зелье здоровья", "Зелье защиты", "Зелье силы"]
						
						switch itemFromBelt {
							case poisons[0]:
								print("Побег")
								Thread.sleep(forTimeInterval: 1.5)
								return true
							case poisons[1]:
								print("Лечение")
								Thread.sleep(forTimeInterval: 1.0)
								hpPlayer += Int.random(in: 15...40)
							case poisons[2]:
								print("Повышение защиты")
								Thread.sleep(forTimeInterval: 1.0)
								maxDamageFromBot = 8
							case poisons[3]:
								print("Повышение силы")
								Thread.sleep(forTimeInterval: 1.0)
								minDamage = 5
								maxDamage = 25
							default:
								continue
						}
					freeFileBelt()
					inFileBelt(inv.outBelt(), inv.getMoney())
						
					default:
						let escape = Int.random(in: 0..<30)
						if escape > 20 {
							return true
						} else {
							print("Не удалось")
						}
						break
				}

				
			} else {
				Thread.sleep(forTimeInterval: 1.0)
				let damage = Int.random(in: minDamage+10...maxDamage+20)
				hpBot = hpBot - damage
				print("Нанесено игроком ", damage)
				Thread.sleep(forTimeInterval: 1.0)
				blow = false
			}
			Thread.sleep(forTimeInterval: 1.0)
			if hpBot <= 0 {break}
			let damageP = Int.random(in: minDamageFromBot...maxDamageFromBot)
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
