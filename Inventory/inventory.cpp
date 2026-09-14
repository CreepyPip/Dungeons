//
//  inventory.cpp
//  Dungeons
//
//  Created by Семён Зайцев on 08.09.2026.
//

#include "inventory.hpp"

Inventory::Inventory() {}

void Inventory::InBag(std::string object) {
	Bag.push_back(object);
};

std::string Inventory::OutBag(int index) {
	if (index <= GetCount()){
		return Bag[index];
	}
	return "";
};

int Inventory::GetCount() const {
	return (int)Bag.size();
};

int Inventory::GetCountChest() const {
	return (int)Chest.size();
};

void Inventory::FreeBag() {
	Bag.clear();
};

void Inventory::FreeChest() {
	Chest.clear();
};

void Inventory::InChest(std::string object) {
	Chest.push_back(object);
};

std::string Inventory::OutChest(int index) {
	if (index <= GetCount()){
		return Chest[index];
	}
	return "";
};
