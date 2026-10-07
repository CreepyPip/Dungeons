//
//  Gameplay.swift
//  Dungeons
//
//  Created by Семён Зайцев on 23.09.2026.
//

import Foundation

let defaultItemScore = 0.2
let itemsScores: [String:Double] = [
	"Ржавый меч": 1.0,
	"Ржавая броня": 2.0,
	"Маленький мешок с монетами": 3.0,
	"Средний мешок с монетами": 5.0,
	"Большой мешок с монетами": 8.0,
	"Почти новый меч": 10.0,
	"Почти новая броня": 13.0,
	"Золото": 20.0,
	"Чьи-то кости": 0.1
]

class color {
	static let red = "\u{001B}[0;31m"
	static let reset = "\u{001B}[0;0m"
	static let green = "\u{001B}[0;32m"
	static var playerColor = reset
}

let enemyType = "\(color.red)&\(color.reset)"
let chestType = "\(color.green)?\(color.reset)"

let poisons: [String] = ["Зелье скрытности", "Зелье концентрации", "Зелье здоровья", "Зелье защиты", "Зелье силы"]
let poisonsPrice: [Double] = [15, 2, 8, 5, 5]

func playingField(_ width: Int,_ height: Int,_ inv: InventoryBridge,_ fight: inFight,_ inf: infinityMode,_ typeGame: Bool) -> Bool {
	
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
					microArr.append(chestType)
				case 38:
					microArr.append(enemyType)
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
		
		if (input == wKey && A[x-1][y] == enemyType) || (input == aKey && A[x][y-1] == enemyType) || 
			(input == sKey && A[x+1][y] == enemyType) || (input == dKey && A[x][y+1] == enemyType) {
			let AA = fight.startBattle(A, x, y, inv, typeGame)
			if AA[0][0] != "False" {
				A = AA
			} else {
				inGame = false
			}
		}
		
		if (input == wKey) && (A[x-1][y] == "E") {
			// Очистка памяти
			freeMaze(dungeon)
			return true
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
		if (input == eKey) && (A[x][y+1] == chestType || 
			A[x][y-1] == chestType || A[x+1][y] == chestType || 
			A[x-1][y] == chestType) {
			if A[x][y+1] == chestType {
				A[x][y+1] = " "
				outputItems.append(randomItems())
			}
			if A[x][y-1] == chestType {
				A[x][y-1] = " "
				outputItems.append(randomItems())
			}
			if A[x+1][y] == chestType {
				A[x+1][y] = " "
				outputItems.append(randomItems())
			}
			if A[x-1][y] == chestType {
				A[x-1][y] = " "
				outputItems.append(randomItems())
			}
			itemsCount = 0
		}
		
		let iE = ifEnemy(A, x, y)
		if iE[0][0] == "fight"{
			let AA = fight.startBattle(A, x, y, inv, typeGame)
			if AA[0][0] != "False" {
				A = AA
			} else {
				inGame = false
			}
		}
		else {A = iE}
	}
	// Очистка памяти
	freeMaze(dungeon)
	return false
}
