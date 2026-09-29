//
//  infinityMode.swift
//  Dungeons
//
//  Created by Семён Зайцев on 24.09.2026.
//

import Foundation

class infinityMode {
	private(set) var level = -1
	
	private let defaultItemScore = 0.2
	
	private let itemsScores: [String:Double] = [
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
	
	func score(_ items: [String]) -> Double {
		var totalScore = 0.0
		for i in items {
			totalScore += itemsScores[i] ?? defaultItemScore
		}
		return totalScore
	}
	
	func levelPlus() {
		level += 1
	}
}
