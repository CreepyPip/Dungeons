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
	if (index < GetCount()){
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

void Inventory::DeleteFromChest(int index) {
	Chest.erase(Chest.begin() + index);
};

std::string Inventory::OutChest(int index) {
	if (index < GetCountChest()){
		return Chest[index];
	}
	return "";
};

double Inventory::GetMoney() {
	return money;
};

void Inventory::AddMoney(double new_money) {
	money += new_money;
};

void Inventory::PutMoney(double putting) {
	money -= putting;
};

void Inventory::InBelt(std::string object) {
	Belt.push_back(object);
};

std::string Inventory::OutBelt(int index) {
	if (index < GetCountBelt()){
		return Belt[index];
	}
	return "";
};

int Inventory::GetCountBelt() const {
	return (int)Belt.size();
};

void Inventory::DeleteItemFromBelt(int index) {
	Price(index);
	Belt.erase(Belt.begin() + index);
};

void Inventory::Price(int index) {
	std::string item = Belt[index];
	
	auto it = ItemPrices.find(item);
	
	if (it != ItemPrices.end()) {
		money += it->second; 
	}
	
};
