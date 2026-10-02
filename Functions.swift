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
	
	let url = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerChest.sosal")
	
	try? nothing.write(to: url, atomically: true, encoding: .utf8)
}

// Запись в файл
func inFile(_ arr: [String],_ money: Double) {
	var arra = arr
	if arra[arra.count-1] != "" {arra.append("")}
	let text = arra.joined(separator: "\n")
	let moneyS = String(money)
	
	let url = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerChest.sosal")
	
	let fileHandle = try! FileHandle(forWritingTo: url)
	defer { fileHandle.closeFile() }
	fileHandle.seekToEndOfFile()
	fileHandle.write(text.data(using: .utf8)!)
	
	let url2 = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerMoney.sosal")
	
	
	let nothing = ""
	try? nothing.write(to: url2, atomically: true, encoding: .utf8)
	
	let fileMoney = try? FileHandle(forWritingTo: url2)
	defer { fileMoney?.closeFile() }
	fileMoney?.seekToEndOfFile()
	fileMoney?.write(moneyS.data(using: .utf8)!)
}

// Чтение файла
func fromFile() -> [String] {
	var arr: [String] = []
	if let dir = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask).first {
		let fileURL = dir.appendingPathComponent("PlayerChest.sosal")
		
		if let savedText = try? String(contentsOf: fileURL, encoding: .utf8) {
			arr = savedText.components(separatedBy: "\n")
		}
	}
	
	var arr2: [String] = []
	
	for i in 0..<arr.count {
		if arr[i] != "" {arr2.append(arr[i])}
	}
	
	return arr2
}

func moneyFromFile() -> Double {
	var money: String = ""
	if let dir = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask).first {
		let fileURL = dir.appendingPathComponent("PlayerMoney.sosal")
		
		if let savedText = try? String(contentsOf: fileURL, encoding: .utf8) {
			money = savedText
		}
	}
	
	return Double(money) ?? 0.0
}

func view(_ A: [[String]],_ x: Int,_ y: Int) {
	// Переменные для границ экрана
	var xh = x-10
	var xl = x+10
	var yl = y-10
	var yr = y+10
	
	// Проверка границ
	while (xh < 0) {
		xh += 1
	}
	while (xl > 200) {
		xl -= 1
	}
	while (yl < 0) {
		yl += 1
	}
	while (yr > 100) {
		yr -= 1
	}
	
	// Вывод на экран вида игрока
	for i in xh..<xl {
		for j in yl..<yr {
			print(A[i][j], terminator: " ")
		}
		print()
	}
}

func freeFileBelt() {
	let nothing = ""
	
	var url = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerBelt.sosal")
	
	try? nothing.write(to: url, atomically: true, encoding: .utf8)
	
	url = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerMoney.sosal")
	
	try? nothing.write(to: url, atomically: true, encoding: .utf8)
}

// Запись в файл
func inFileBelt(_ arr: [String],_ money: Double) {
	var arra = arr
	if !arra.isEmpty{ if arra[arra.count-1] != "" {arra.append("")}}
	let text = arra.joined(separator: "\n")
	let moneyS = String(money)
	
	let url = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerBelt.sosal")
	
	let fileHandle = try! FileHandle(forWritingTo: url)
	defer { fileHandle.closeFile() }
	fileHandle.seekToEndOfFile()
	fileHandle.write(text.data(using: .utf8)!)
	
	let url2 = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayerMoney.sosal")
	
	let fileMoney = try? FileHandle(forWritingTo: url2)
	defer { fileMoney?.closeFile() }
	fileMoney?.seekToEndOfFile()
	fileMoney?.write(moneyS.data(using: .utf8)!)
}

// Чтение файла
func fromFileBelt() -> [String] {
	var arr: [String] = []
	if let dir = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask).first {
		let fileURL = dir.appendingPathComponent("PlayerBelt.sosal")
		
		if let savedText = try? String(contentsOf: fileURL, encoding: .utf8) {
			arr = savedText.components(separatedBy: "\n")
		}
	}
	
	
	var arr2: [String] = []
	
	for i in 0..<arr.count {
		if arr[i] != "" {arr2.append(arr[i])}
	}
	
	return arr2
}



func randomItemInfMode() -> [String] {
	let poisons: [String] = ["Зелье скрытности", "Зелье здоровья", "Зелье защиты", "Зелье силы"]
	var returnPoisons: [String] = []
	
	let count = Int.random(in: 0..<3)
	for _ in 0...count {
		returnPoisons.append(poisons[Int.random(in: 0..<4)])
	}
	
	return returnPoisons
}

// Чтение файла
func fromFileRecord() -> [String] {
	var arr: [String] = []
	if let dir = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask).first {
		let fileURL = dir.appendingPathComponent("PlayersRecords.sosal")
		
		if let savedText = try? String(contentsOf: fileURL, encoding: .utf8) {
			arr = savedText.components(separatedBy: "\n")
		}
	}
	
	
	var arr2: [String] = []
	
	for i in 0..<arr.count {
		if arr[i] != "" {arr2.append(arr[i])}
	}
	
	return arr2
}

func inFileRecord(_ score: Double,_ name: String) {
	let scoreInFile = String(score) + " " + name
	let nothing = ""
	var arr: [String] = []
	let dir = FileManager.default.urls(for: .autosavedInformationDirectory, in: .userDomainMask)[0]
		.appendingPathComponent("PlayersRecords.sosal")
	
	if let savedText = try? String(contentsOf: dir, encoding: .utf8) {
		arr = savedText.components(separatedBy: "\n")
	}
	
	
	var arr2: [String] = []
	var count = 0
	
	for i in 0..<arr.count {
		if arr[i] != "" {
			let numberString = arr[i].filter { $0.isNumber }
			let number = Double(numberString)!
			
			if number < score {
				arr2.append(arr[i] + "\n")
				count += 1
			} else {
				break
			}
		}
	}
	
	arr2.append(scoreInFile + "\n")
	
	for i in count..<arr.count {
		if arr[i] != "" {
			arr2.append(arr[i] + "\n")
		}
	}
	
	try? nothing.write(to: dir, atomically: true, encoding: .utf8)
	
	for i in 0..<arr2.count {
		let fileMoney = try? FileHandle(forWritingTo: dir)
		defer { fileMoney?.closeFile() }
		fileMoney?.seekToEndOfFile()
		fileMoney?.write(arr2[i].data(using: .utf8)!)
	}
	
}
