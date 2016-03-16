//
//  TextViewCell.m
//  Commo
//
//  Created by wuhaibin on 15/12/11.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"这是一款 爆炸的 APP"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.textView.attributedText = content;
    self.textView.font = [UIFont systemFontOfSize:20.0f];
    self.textView .selectable = NO;
    self.textView.editable = NO;
    
}

@end
