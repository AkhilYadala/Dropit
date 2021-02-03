//
//  DropitBehaviour.m
//  Dropit
//
//  Created by akhil.y on 03/02/21.
//

#import "DropitBehaviour.h"

@interface DropitBehaviour()
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;
@end

@implementation DropitBehaviour

- (UIGravityBehavior *) gravity
{
    if(!_gravity)
    {
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}

- (UICollisionBehavior *)collider
{
    if(!_collider)
    {
        _collider = [[UICollisionBehavior alloc]init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}

- (void) addItem:(id <UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
}
- (void) removeItem:(id <UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
}
- (instancetype)init
{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    return self;
}
@end
