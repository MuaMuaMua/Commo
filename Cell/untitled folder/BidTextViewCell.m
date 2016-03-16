//
//  BidTextViewCell.m
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "BidTextViewCell.h"

@implementation BidTextViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews {
  
}

- (void)initTextView {
    self.textView.editable = NO;
    self.textView.selectable = NO;
    self.textView.text = @"CLOT是香港著名艺人陈冠希创办的凝结集团（CLOT FAMILY）的简称及该公司旗下潮流服装品牌名称。凝结集团是一个LIFESTYLE的公司，由香港著名艺人陈冠希创办于2003年6月。";
    
}

@end
