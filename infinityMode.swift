//
//  infinityMode.swift
//  Dungeons
//
//  Created by Семён Зайцев on 24.09.2026.
//

import Foundation

class infinityMode {
	private(set) var level = -1
	
	func score(_ items: [String]) -> Double {
		var totalScore = 0.0
		for i in items {
			totalScore += itemsScores[i] ?? defaultItemScore
		}
		return round(totalScore*10)/10
	}
	
	func levelPlus() {
		level += 1
	}
}
