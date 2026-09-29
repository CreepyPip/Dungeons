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
#include <unordered_map>

// Класс хранения полученных предметов
class Inventory {
	std::vector<std::string> Bag; // Сумка на забег
	std::vector<std::string> Chest; // Сундук хранения всех предметов
	std::vector<std::string> Belt;
	double money = 0;
	
	const std::unordered_map<std::string, double> ItemPrices = {
		{"Ржавый меч", 1.0},
		{"Ржавая броня", 2.0},
		{"Маленький мешок с монетами", 3.0},
		{"Средний мешок с монетами", 5.0},
		{"Большой мешок с монетами", 8.0},
		{"Почти новый меч", 10.0},
		{"Почти новая броня", 13.0},
		{"Золото", 20.0},
		{"Чьи-то кости", 0.1},
		{"Мусор", 0.2}
	};
	
public:
	Inventory();
	void InBag(std::string object); // Метод складывания в сумку
	std::string OutBag(int index); // Метод получения того, что хранится в сумке
	void FreeBag(); // Очистка сумки
	void FreeChest(); // Очистка сундука
	void InChest(std::string objects); // Метод складывания в сундук
	std::string OutChest(int index); // Метод получения того, что хранится в сундуке
	void DeleteFromChest(int index);
	int GetCount() const; // Получение кол-ва элементов в сумке
	int GetCountChest() const; // Получение кол-ва элементов в сумке
	double GetMoney();
	void AddMoney(double new_money);
	void PutMoney(double putting);
	void InBelt(std::string object);
	std::string OutBelt(int index);
	int GetCountBelt() const;
	void DeleteItemFromBelt(int index);
	void Price(int index);
};

#endif /* inventory_hpp */
