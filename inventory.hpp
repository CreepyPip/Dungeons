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

class Inventory {
	std::vector<std::string> Bag;
	std::vector<std::string> Chest;
	
public:
	Inventory();
	void InBag(std::string object);
	std::string OutBag(int index);
	void FreeBag();
	void FreeChest();
	void InChest(std::string objects);
	std::string OutChest(int index);
	int GetCount() const;
	int GetCountChest() const;
	void InFile();
	void FromFile();
	void CreateFile();
};

#endif /* inventory_hpp */
