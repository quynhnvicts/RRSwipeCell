//
//  RRSwipeActionsView.m
//  RRSwipeCell
//
//  Created by Moch Xiao on 7/23/17.
//  Copyright © 2017 RedRain. All rights reserved.
//

#import "RRSwipeActionsView.h"
#import "RRSwipeAction.h"

@interface RRSwipeActionsView ()
@property (nonatomic, assign) CGSize maxSize;
@property (nonatomic, strong) NSArray<RRSwipeAction *> *actions;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation RRSwipeActionsView

- (instancetype)initWithMaxSize:(CGSize)size
                        actions:(NSArray<RRSwipeAction *> *)actions
                 collectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _maxSize = size;
    _actions = actions;
    _collectionView = collectionView;
    self.frame = CGRectMake(0, 0, size.width, size.height);
    [self commitInit];
    return self;
}

- (void)commitInit {
    NSInteger index = 0;
    CGFloat lastMinX = self.maxSize.width;
    for (RRSwipeAction *action in self.actions) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.backgroundColor = action.backgroundColor;
        [button setTitle:action.title forState:UIControlStateNormal];
        [button setTitleColor:action.titleColor forState:UIControlStateNormal];
        button.titleLabel.font = action.font;
        button.tag = index;
        button.frame = CGRectMake(lastMinX - action.width, 0, action.width, self.maxSize.height);
        [button addTarget:self action:@selector(_rr_handleClickAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button];
        lastMinX = button.frame.origin.x;
        _actionsWidth = self.maxSize.width - lastMinX;
        ++index;
    }
}

- (void)_rr_handleClickAction:(UIButton *)sender {
    self.actions[sender.tag].handler(self.collectionView);
}

@end
