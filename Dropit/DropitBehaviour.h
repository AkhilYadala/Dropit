//
//  DropitBehaviour.h
//  Dropit
//
//  Created by akhil.y on 03/02/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DropitBehaviour : UIDynamicBehavior

- (void) addItem:(id <UIDynamicItem>)item;
- (void) removeItem:(id <UIDynamicItem>)item;

@end

NS_ASSUME_NONNULL_END
