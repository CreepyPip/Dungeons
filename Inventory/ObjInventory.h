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

@end


#endif /* ObjInventory_h */
