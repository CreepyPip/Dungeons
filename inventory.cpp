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
	return Bag[index];
};

int Inventory::GetCount() const {
	return (int)Bag.size();
}
