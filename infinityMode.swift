//
//  infinityMode.swift
//  Dungeons
//
//  Created by Семён Зайцев on 24.09.2026.
//

import Foundation

class infinityMode {
	private(set) var level = 0
	
    static private let defaultItemScore: Double = 0.2
    
    static private let itemScores: [String:Double] = [
        "Ржавый меч": 1.0,
        "Ржавая броня": 2.0,
        "Маленький мешок с монетами": 3.0,
        "Средний мешок с монетами": 5.0,
        "Большой мешок с монетами": 8.0,
        "Почти новый меч": 10.0,
        "Почти новая броня": 13.0,
        "Золото": 20,
        "Чьи-то кости": 0.1
    ]
    
    let score: ([String]) -> Double = { $0.reduce(0) { $0 + (itemScores[$1] ?? defaultItemScore) } }
	
    func levelPlus(amount: Int = 1) {
		level += amount
	}
}
