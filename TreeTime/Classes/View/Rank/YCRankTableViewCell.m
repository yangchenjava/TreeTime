//
//  YCRankTableViewCell.m
//  TreeTime
//
//  Created by yangc on 16/12/17.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "YCRankTableViewCell.h"
#import "YCGlobalConst.h"
#import "YCRankResult.h"

@interface YCRankTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image_avatar;
@property (weak, nonatomic) IBOutlet UILabel *label_number;
@property (weak, nonatomic) IBOutlet UILabel *label_userName;
@property (weak, nonatomic) IBOutlet UILabel *label_score;

@end

@implementation YCRankTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * const ID = @"YCRankTableViewCell";
    YCRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"YCRankTableViewCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _label_number.layer.cornerRadius = 9.5;
    _label_number.layer.masksToBounds = YES;
    
    _label_score.layer.cornerRadius = YC_Rank_CornerRadius;
    _label_score.layer.masksToBounds = YES;
}

- (void)setRankResult:(YCRankResult *)rankResult {
    _rankResult = rankResult;
    
    [_image_avatar sd_setImageWithURL:[NSURL URLWithString:_rankResult.avatarUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    _label_number.text = [NSString stringWithFormat:@"%d", _rankResult.number];
    _label_userName.text = _rankResult.userName;
    _label_score.text = [NSString stringWithFormat:@"%d分钟", _rankResult.score / 60];
}

@end
