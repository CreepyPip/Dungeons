//
//  ObjInventory.h
//  Dungeons
//
//  Created by Семён Зайцев on 10.09.2026.
//
//  Header моста между C++ и Swift

#ifndef ObjInventory_h
#define ObjInventory_h

#import <Foundation/Foundation.h>

@interface InventoryBridge : NSObject

- (void)InBag:(NSString*) item;
- (NSArray<NSString *> *)OutBag;
- (void)FreeBag;
- (void)FreeChest;
- (void)InChest:(NSString*) item;
- (NSArray<NSString *> *)OutChest;
- (double)GetMoney;
- (void)AddMoney:(double) newMoney;
- (void)PutMoney:(double) putting;
- (void)InBelt:(NSString*) item;
- (NSArray<NSString *> *)OutBelt;
- (void)DeleteItemFromBelt:(int) index;
- (void)DeleteItemFromChest:(int) index;

@end


#endif /* ObjInventory_h */
