//
//  Dealer.swift
//  Dungeons
//
//  Created by Семён Зайцев on 24.09.2026.
//

import Foundation

func dealer(_ inv: InventoryBridge) {
	var chest = inv.outChest()!
	var belt = inv.outBelt()!
	if chest.isEmpty {chest = fromFile()}
	if belt.isEmpty {belt = fromFileBelt()}
	if !chest.isEmpty {
		for i in 0..<chest.count {
			inv.inChest(chest[i])
		}
	}
	
	if !belt.isEmpty {
		for i in 0..<belt.count {
			inv.inBelt(belt[i])
		}
	}
	if inv.getMoney() == 0.0 {inv.addMoney(moneyFromFile())}
	print("У вас на счету \(inv.getMoney()) \n")
	
	print("1. Продать")
	print("2. Купить")
	print("3. Выйти")
	
	let sell = "1"
	let buy = "2"
	let exit = "3"
	var input = readLine()
	while (input != sell && input != buy && input != exit) {
		input = readLine()
	}
	
	switch input {
		case sell:
			while (true) {
				chest = inv.outChest()
				if !chest.isEmpty {
					for i in 0..<chest.count {
						print(i+1, ".", chest[i])
					}
				}
				print("Введите не целое число, чтобы выйти")
				let inp = readLine()!
				
				if Int(inp) != nil {
					if Int(inp)! - 1 >= 0 && Int(inp)! - 1 < chest.count {
						inv.addMoney(itemsScores[chest[Int(inp)! - 1]] ?? defaultItemScore)
						inv.deleteItem(fromChest: Int32(inp)!)
						freeFile()
						inFile(inv.outChest(), inv.getMoney())
					}
				}else {break}
			}
		case buy:
			while (true) {
				
				for i in 0..<poisons.count {
					print(i+1, ".", poisons[i], "(\(poisonsPrice[i]))")
				}
				print("")
				print("Введите не целое число, чтобы выйти")
				let inp = readLine()!
				
				if Int(inp) != nil {
					if Int(inp)! - 1 >= 0 && Int(inp)! - 1 < poisons.count {
						if inv.getMoney() - poisonsPrice[Int(inp)!-1] >= 0 {
							inv.putMoney(poisonsPrice[Int(inp)!-1])
							inv.inBelt(poisons[Int(inp)!-1])
							freeFileBelt()
							inFileBelt(inv.outBelt(), inv.getMoney())
						}
					}
				}else {break}
			}
		default:
			return
	}
}
