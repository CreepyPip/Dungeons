//
//  Gameplay.swift
//  Dungeons
//
//  Created by Семён Зайцев on 23.09.2026.
//

import Foundation

func playingField(_ width: Int,_ height: Int,_ type: Bool,_ inv: InventoryBridge,_ fight: inFight,_ inf: infinityMode) -> Bool {
	
	// Генерируем подземелье
	let dungeon = generateDungeon(Int32(width), Int32(height), 30)
	
	
	// Массив для удобного хранения подземелья
	var A: [[String]] = []
	// Координаты игрока
	var x = height - 2
	var y = (width/2)-1
	
	// Перезаписываем
	for i in 0..<height {
		var microArr: [String] = []
		for j in 0..<width {
			let pretrans = dungeon![j + i * width]
			
			switch Int(exactly: pretrans)! {
				case 35:
					microArr.append("#")
				case 83:
					microArr.append("S")
					y = j
				case 69:
					microArr.append("E")
				case 63:
					microArr.append("?")
				case 38:
					microArr.append("&")
				default:
					microArr.append(" ")
			}
			
		}
		
		A.append(microArr)
	}
	
	// Местонахождение игрока
	A[x][y] = "@"
	enableRawMode() // Ввод "без подтверждения"
	var inGame = true // булевая для отображения поля
	var outputItems: [String] = [] // Массив для отображения собранного
	var itemsCount = 0 // переменная для цикла отображения собранного
	
	while(inGame){
		clearScreen() // Чистим экран при каждой иттерации
		
		view(A, x, y)
		
		// Отображение собранного из сунуков
		if !outputItems.isEmpty {
			for i in 0..<outputItems.count {
				print(outputItems[i])
			}
			itemsCount += 1
		}
		
		// Склаываем в сумку и чистим экран
		if (itemsCount == 3) {
			for i in 0..<outputItems.count {
				if (outputItems[i] != "Пустой") {
					inv.inBag(outputItems[i])
				}
			}
			itemsCount = 0
			outputItems.removeAll()
		}
		
		
		// Ввод пользователя
		var input: Int32
		let wKey = 119
		let aKey = 97
		let sKey = 115
		let dKey = 100
		let eKey = 101
		
		repeat {
			input = getchar()
		} while (input != wKey && input != aKey && input != sKey && input != dKey && input != eKey)
		
		if (input == wKey && A[x-1][y] == "&") || (input == aKey && A[x][y-1] == "&") || 
			(input == sKey && A[x+1][y] == "&") || (input == dKey && A[x][y+1] == "&") {
			let AA = fight.startBattle(A, x, y)
			if AA[0][0] != "False" {
				A = AA
			} else {
				inGame = false
			}
		}
		
		if (input == wKey) && (A[x-1][y] == "E") {
			if type != false {
				return true
			} else {
				_ = playingField(width, height, type, inv, fight, inf)
				inf.levelPlus()
				return false
			}
		}
		
		if (input == wKey) && (A[x-1][y] == " ") {
			A[x][y] = " "
			x = x - 1
			A[x][y] = "@"
		}
		
		if (input == aKey) && (A[x][y-1] == " ") {
			A[x][y] = " "
			y = y - 1
			A[x][y] = "@"
		}
		
		if (input == sKey) && (A[x+1][y] == " ") {
			A[x][y] = " "
			x = x + 1
			A[x][y] = "@"
		}
		
		if (input == dKey) && (A[x][y+1] == " ") {
			A[x][y] = " "
			y = y + 1
			A[x][y] = "@"
		}
		
		// Сундуки
		if (input == eKey) && (A[x][y+1] == "?" || A[x][y-1] == "?" || A[x+1][y] == "?" || A[x-1][y] == "?") {
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
			itemsCount = 0
		}
		
		let iE = ifEnemy(A, x, y)
		if iE[0][0] == "fight"{
			let AA = fight.startBattle(A, x, y)
			if AA[0][0] != "False" {
				A = AA
			} else {
				inGame = false
			}
		}
		else {A = iE}
	}
	return false
}
