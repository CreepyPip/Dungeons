//
//  Functions.swift
//  Dungeons
//
//  Created by Семён Зайцев on 10.09.2026.
//

import Foundation

// Переменная для функций работы терминала
var originalTermios = termios()

// Функция для ввода в терминал "без подтверждения"
func enableRawMode() {
	tcgetattr(STDIN_FILENO, &originalTermios)
	var newTermios = originalTermios
	
	newTermios.c_lflag &= ~UInt(ICANON)
	newTermios.c_lflag &= ~UInt(ECHO)
	
	tcsetattr(STDIN_FILENO, TCSANOW, &newTermios)
}

// Функция для отключения ввода в терминал "без подтверждения"
func disableRawMode() {
	tcsetattr(STDIN_FILENO, TCSANOW, &originalTermios)
}

// Функция получения предметов из сундуков
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
	if (item >= 76 && item <= 79) {
		return "Почти новая броня"
	}
	if (item >= 80 && item <= 94) {
		return "Мусор"
	}
	if (item == 95) {
		return "Золото"
	}
	
	return "Пустой"
}

// Очистка файла
func freeFile() {
	let nothing = ""
	
	let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerChest.sosal")
	
	try! nothing.write(to: url, atomically: true, encoding: .utf8)
}

// Запись в файл
func inFile(_ arr: [String]) {
	let text = arr.joined(separator: "\n")
	
	let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerChest.sosal")
	
	let fileHandle = try! FileHandle(forWritingTo: url)
	defer { fileHandle.closeFile() }
	fileHandle.seekToEndOfFile()
	fileHandle.write(text.data(using: .utf8)!)
	
	
}

// Чтение файла
func fromFile() -> [String] {
	var arr: [String] = []
	if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
		let fileURL = dir.appendingPathComponent("PlayerChest.sosal")
		
		if let savedText = try? String(contentsOf: fileURL, encoding: .utf8) {
			arr = savedText.components(separatedBy: "\n")
		}
	}
	
	return arr
}
