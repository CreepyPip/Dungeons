//
//  infinityMode.swift
//  Dungeons
//
//  Created by Семён Зайцев on 24.09.2026.
//

import Foundation

class infinityMode {
	private var level = 0
	
	func score(_ items: [String]) -> Double {
		var itemsScore = 0.0
		for i in 0..<items.count {
			switch items[i] {
				case "Ржавый меч": 
					itemsScore += 1.0
				case "Ржавая броня": 
					itemsScore += 2.0
				case "Маленький мешок с монетами": 
					itemsScore += 3
				case "Средний мешок с монетами": 
					itemsScore += 5
				case "Большой мешок с монетами": 
					itemsScore += 8
				case "Почти новый меч": 
					itemsScore += 10
				case "Почти новая броня": 
					itemsScore += 13
				case "Золото":
					itemsScore += 20
				case "Чьи-то кости":
					itemsScore += 0.1
				default:
					itemsScore += 0.2
			}
		}
		return itemsScore
	}
	
	func levelPlus() {
		level += 1
	}
	
	func getLevel() -> Int {
		return level
	}
}
