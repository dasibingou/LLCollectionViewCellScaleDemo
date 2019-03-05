//
//  LLScallFlowLayout.m
//  LLCollectionViewCellScaleDemo
//
//  Created by linling on 2019/3/5.
//  Copyright © 2019 llmodule. All rights reserved.
//

#import "LLScallFlowLayout.h"

@interface LLScallFlowLayout ()

/**
 cell 布局属性集
 */
@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *arrAttributes;

@end

@implementation LLScallFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width - 28, 103);
    self.minimumLineSpacing = 8;
    
    // 决定第一张图片所在的位置
    CGFloat margin = (self.collectionView.frame.size.width - self.itemSize.width) / 2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, margin);
    
}

// 返回所有的 cell 布局数组
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*self.itemSize.width;
    bigRect.origin.x = rect.origin.x - self.itemSize.width;
    
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        //这里只对高度进行缩放，因为cell左右边距14过小，会导致宽度缩放的时候两个cell的LineSpacing大于8，导致3个cell不在一个屏幕内，那就不是我们想要的效果了
        attributes.transform = CGAffineTransformMakeScale(1, scale);
    }
    return arr;
} // return an array layout attributes instances for all the views in the given rect

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//
//    //计算整体的中心点的值
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
//    //这里不能使用contentOffset.x 因为手指一抬起来，contentOffset.x就不会再变化，按照惯性滚动的不会被计算到其中
//    //CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
//
//    //计算可视区域
//    CGFloat visibleX = proposedContentOffset.x;
//    CGFloat visibleY = proposedContentOffset.y;
//    CGFloat visibleW = self.collectionView.bounds.size.width;
//    CGFloat visibleH = self.collectionView.bounds.size.height;
//    //获取可视区域cell对应的attributes对象   每个cell唯一对应一个attribute对象
//    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:CGRectMake(visibleX, visibleY, visibleW, visibleH)];
//
//    //比较出最小的偏移
//    int minIdx = 0;//假设最小的下标是0
//    UICollectionViewLayoutAttributes *minAttr = arrayAttrs[minIdx];
//    //循环比较出最小的
//    for(int i = 1; i < arrayAttrs.count; i++){
//        //计算两个距离
//        //1、minAttr和中心点的距离
//        CGFloat distance1 = ABS(minAttr.center.x - centerX);
//        //2、计算出当前循环的attr对象和centerX的距离
//        UICollectionViewLayoutAttributes *obj = arrayAttrs[i];
//        CGFloat distance2 = obj.center.x - centerX;
//        //3、比较
//        if (distance2 < distance1) {
//            minIdx = i;
//            minAttr = obj;
//        }
//    }
//
//    //计算出最小的偏移值
//    CGFloat offsetX = minAttr.center.x - centerX;
//    return CGPointMake(offsetX + proposedContentOffset.x, proposedContentOffset.y);
    
//} // return a point at which to rest after scrolling - for layouts that want snap-to-point scrolling behavior


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
} // return YES to cause the collection view to requery the layout for geometry information

//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

@end
