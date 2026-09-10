//
//  ObjInventory.h
//  Dungeons
//
//  Created by Семён Зайцев on 10.09.2026.
//

#ifndef ObjInventory_h
#define ObjInventory_h

#import <Foundation/Foundation.h>

@interface InventoryBridge : NSObject

- (void)InBag:(NSString*) item;
- (NSArray<NSString *> *)OutBag;
- (void)FreeBag;
- (void)InChest:(NSString*) item;

@end


#endif /* ObjInventory_h */
