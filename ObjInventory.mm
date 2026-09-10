#import "ObjInventory.h"
#import "inventory.hpp"

@implementation InventoryBridge {
	Inventory *_cppInventory;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_cppInventory = new Inventory();
	}
	return self;
}

- (void)dealloc {
	delete _cppInventory;
}

- (void)InBag:(NSString *)item {
	std::string cppString([item UTF8String]);
	_cppInventory->InBag(cppString);
}


- (NSArray<NSString *> *)OutBag {
	NSMutableArray *BagArr = [NSMutableArray array];

	for (int i = 0; i < _cppInventory->GetCount(); i++){
		std::string item = _cppInventory->OutBag(i);
		NSString *nsItem = [NSString stringWithUTF8String:item.c_str()];
		[BagArr addObject:nsItem];
	}
	
	return BagArr;
}

@end
