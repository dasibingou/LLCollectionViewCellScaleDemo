//
//  LLScaleScrollView.h
//  LLCollectionViewCellScaleDemo
//
//  Created by linling on 2019/3/5.
//  Copyright © 2019 llmodule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LLScaleScrollViewDelegate <NSObject>

@optional

/**
 滚动代理方法
 */
-(void)cardSwitchDidSelectedAt:(NSInteger)index;

@end

@interface LLScaleScrollView : UIView
/**
 当前选中位置
 */
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
/**
 设置数据源
 */
@property (nonatomic, strong) NSArray *items;
/**
 代理
 */
@property (nonatomic, weak) id<LLScaleScrollViewDelegate>delegate;

/**
 是否分页，默认为true
 */
@property (nonatomic, assign) BOOL pagingEnabled;

/**
 手动滚动到某个卡片位置
 */
- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
