//
//  TMTableViewCell.m
//  网络
//
//  Created by qingyun on 16/6/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TMTableViewCell.h"
#import "TMModel.h"
#import "UIImageView+WebCache.h"
#import "TMViewController.h"
@interface TMTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *BuyButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *soldLabel;
@property (weak, nonatomic) IBOutlet UILabel *decriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *maket_price;
@property (weak, nonatomic) IBOutlet UIImageView *cover;

@end
@implementation TMTableViewCell

-(void)setModel:(TMModel *)model{
    _model=model;
    _BuyButton.layer.cornerRadius=5.0;
    _BuyButton.backgroundColor=[UIColor yellowColor];
    _BuyButton.layer.masksToBounds=YES;
    _titleLabel.text=model.title;
    _decriptionLabel.text=model.Desc;
    _decriptionLabel.textColor=[UIColor yellowColor];
    _soldLabel.text=[NSString stringWithFormat:@"销量:%@",model.sold];
    _price.text=[NSString stringWithFormat:@"$ %@",model.price];
    _price.backgroundColor=[UIColor yellowColor];
    NSString *price = [NSString stringWithFormat:@"原价: %@",model.market_price];
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:price];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle) range:NSMakeRange(0, price.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, price.length)];
    [_maket_price setAttributedText:attri];
    _maket_price.textColor=[UIColor redColor];
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.cover]placeholderImage:[UIImage imageNamed:@"social-user"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
