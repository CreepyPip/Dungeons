//
//  inventory.hpp
//  Dungeons
//
//  Created by Семён Зайцев on 08.09.2026.
//

#ifndef inventory_hpp
#define inventory_hpp

#include <stdio.h>
#include <string>
#include <vector>
#include <fstream>

// Класс хранения полученных предметов
class Inventory {
	std::vector<std::string> Bag; // Сумка на забег
	std::vector<std::string> Chest; // Сундук хранения всех предметов
	
public:
	Inventory();
	void InBag(std::string object); // Метод складывания в сумку
	std::string OutBag(int index); // Метод получения того, что хранится в сумке
	void FreeBag(); // Очистка сумки
	void FreeChest(); // Очистка сундука
	void InChest(std::string objects); // Метод складывания в сундук
	std::string OutChest(int index); // Метод получения того, что хранится в сундуке
	int GetCount() const; // Получение кол-ва элементов в сумке
	int GetCountChest() const; // Получение кол-ва элементов в сумке
};

#endif /* inventory_hpp */
