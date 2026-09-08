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

class Inventory {
	std::vector<std::string> Bag;
	
public:
	Inventory();
	void InBag(std::string object);
	std::string* OutBag();
};

#endif /* inventory_hpp */
