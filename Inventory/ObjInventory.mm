// Мост между C++ и Swift

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

- (void)InBag:(NSString*)item {
	std::string cppString([item UTF8String]);
	_cppInventory->InBag(cppString);
}

- (void)InChest:(NSString*)item {
	std::string cppString([item UTF8String]);
	_cppInventory->InChest(cppString);
}

- (void)FreeBag {
	_cppInventory->FreeBag();
}

- (void)FreeChest {
	_cppInventory->FreeChest();
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

- (NSArray<NSString *> *)OutChest {
	NSMutableArray *ChestArr = [NSMutableArray array];
	
	for (int i = 0; i < _cppInventory->GetCountChest(); i++){
		std::string item = _cppInventory->OutChest(i);
		NSString *nsItem = [NSString stringWithUTF8String:item.c_str()];
		[ChestArr addObject:nsItem];
	}
	
	return ChestArr;
}

- (double)GetMoney {
	return _cppInventory -> GetMoney();
}

- (void)AddMoney:(double) newMoney {
	_cppInventory -> AddMoney(newMoney);
}

- (void)PutMoney:(double) putting {
	_cppInventory -> PutMoney(putting);
}

- (void)InBelt:(NSString*)item {
	std::string cppString([item UTF8String]);
	_cppInventory->InBelt(cppString);
}

- (NSArray<NSString *> *)OutBelt {
	NSMutableArray *BeltArr = [NSMutableArray array];
	
	for (int i = 0; i < _cppInventory->GetCountBelt(); i++){
		std::string item = _cppInventory->OutBelt(i);
		NSString *nsItem = [NSString stringWithUTF8String:item.c_str()];
		[BeltArr addObject:nsItem];
	}
	
	return BeltArr;
}

- (void)DeleteItemFromBelt:(int) index {
	_cppInventory -> DeleteItemFromBelt(index - 1);
}

- (void)DeleteItemFromChest:(int) index {
	_cppInventory -> DeleteFromChest(index - 1);
}

@end
