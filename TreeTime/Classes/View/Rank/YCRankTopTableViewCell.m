//
//  YCRankTopTableViewCell.m
//  TreeTime
//
//  Created by yangc on 16/12/17.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "YCRankTopTableViewCell.h"
#import "YCGlobalConst.h"
#import "YCRankResult.h"

@interface YCRankTopTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image_avatar;
@property (weak, nonatomic) IBOutlet UIImageView *image_rope;
@property (weak, nonatomic) IBOutlet UILabel *label_userName;
@property (weak, nonatomic) IBOutlet UILabel *label_count;
@property (weak, nonatomic) IBOutlet UILabel *label_score;

@end

@implementation YCRankTopTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * const ID = @"YCRankTopTableViewCell";
    YCRankTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"YCRankTopTableViewCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _label_score.layer.cornerRadius = YC_Rank_CornerRadius;
    _label_score.layer.masksToBounds = YES;
}

- (void)setRankResult:(YCRankResult *)rankResult {
    _rankResult = rankResult;
    
    [_image_avatar sd_setImageWithURL:[NSURL URLWithString:_rankResult.avatarUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    switch (_rankResult.number) {
        case 1:
            _image_rope.image = [UIImage imageNamed:@"first"];
            _label_userName.font = [UIFont systemFontOfSize:22];
            _label_userName.textColor = YC_Color_RGB(255, 102, 0);
            break;
        case 2:
            _image_rope.image = [UIImage imageNamed:@"second"];
            _label_userName.font = [UIFont systemFontOfSize:20];
            _label_userName.textColor = YC_Color_RGB(243, 151, 5);
            break;
        case 3:
            _image_rope.image = [UIImage imageNamed:@"third"];
            _label_userName.font = [UIFont systemFontOfSize:18];
            _label_userName.textColor = YC_Color_RGB(0, 134, 196);
            break;
    }
    _label_userName.text = _rankResult.userName;
    _label_count.text = [NSString stringWithFormat:@"专注次数%d次", _rankResult.count];
    _label_score.text = [NSString stringWithFormat:@"%d分钟", _rankResult.score / 60];
}

@end
