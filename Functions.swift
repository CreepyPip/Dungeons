//
//  Functions.swift
//  Dungeons
//
//  Created by Семён Зайцев on 10.09.2026.
//

import Foundation

var originalTermios = termios()

func enableRawMode() {
	tcgetattr(STDIN_FILENO, &originalTermios)
	var newTermios = originalTermios
	
	newTermios.c_lflag &= ~UInt(ICANON)
	newTermios.c_lflag &= ~UInt(ECHO)
	
	tcsetattr(STDIN_FILENO, TCSANOW, &newTermios)
}

func disableRawMode() {
	tcsetattr(STDIN_FILENO, TCSANOW, &originalTermios)
}

func randomItems() -> String {
	let item = Int.random(in: 0..<100)
	if (item >= 0 && item <= 15) {
		return "Ржавый меч"
	}
	if (item >= 16 && item <= 35) {
		return "Ржавая броня"
	}
	if (item >= 36 && item <= 46) {
		return "Маленький мешок с монетами"
	}
	if (item >= 47 && item <= 52) {
		return "Средний мешок с монетами"
	}
	if (item >= 53 && item <= 57) {
		return "Большой мешок с монетами"
	}
	if (item >= 58 && item <= 70) {
		return "Чьи-то кости"
	}
	if (item >= 71 && item <= 75) {
		return "Почти новый меч"
	}
	if (item >= 76 && item <= 80) {
		return "Почти новая броня"
	}
	if (item >= 81 && item <= 95) {
		return "Мусор"
	}
	
	return "Пустой"
}
