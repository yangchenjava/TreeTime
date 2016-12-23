//
//  YCRankTableHeaderView.m
//  TreeTime
//
//  Created by yangc on 16/12/17.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "YCRankTableHeaderView.h"
#import "YCGlobalConst.h"

@interface YCRankTableHeaderView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation YCRankTableHeaderView

static NSString * const ID = @"YCRankTableHeaderView";
static int const COUNT = 10000;

+ (instancetype)tableHeaderView {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, YC_ScreenWidth, YC_Rank_H_TableHeader)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    UIImageView *image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_bg"]];
    [self addSubview:image_bg];
    UIImageView *image_text = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rank_text"]];
    [self addSubview:image_text];
    UIImageView *image_cup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leaf_cup"]];
    [self addSubview:image_cup];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout  alloc] init];
    layout.itemSize = CGSizeMake(135, 223);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:layout];
    collectionView.userInteractionEnabled = NO;
    collectionView.alpha = 0.f;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    [image_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [image_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(136);
        make.height.mas_equalTo(26);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.leading.mas_equalTo(self.mas_leading).offset(20);
    }];
    [image_cup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(116);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-20);
    }];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(135);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(image_cup.mas_centerX);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    UIImageView *image = [[UIImageView alloc] initWithFrame:cell.bounds];
    image.image = [UIImage imageNamed:@"money"];
    [cell addSubview:image];
    return cell;
}

- (void)startFlow {
    if (!_displayLink) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:COUNT * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        [UIView animateWithDuration:0.5 animations:^{
            _collectionView.alpha = 1.f;
        }];
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoFlow)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopFlow {
    [_displayLink invalidate];
    _displayLink = nil;
    [UIView animateWithDuration:0.5 animations:^{
        _collectionView.alpha = 0.f;
    }];
}

- (void)autoFlow {
    _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - 2);
}

@end
