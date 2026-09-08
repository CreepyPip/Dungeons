//
//  inventory.cpp
//  Dungeons
//
//  Created by Семён Зайцев on 08.09.2026.
//

#include "inventory.hpp"

void Inventory::InBag(std::string object) {
	Bag.push_back(object);
};

std::string* Inventory::OutBag() {
	return Bag.data();
};
