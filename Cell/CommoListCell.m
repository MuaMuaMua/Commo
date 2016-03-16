//
//  CommoListCell.m
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "CommoListCell.h"

@implementation CommoListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)initTextView {
    CGRect winSize = [[UIScreen mainScreen]bounds];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10 + 130 + 25,  50 + 18 , winSize.size.width - 25 - 130 - 10 - 10, 120)];
//    self.textView.text = @"CLOT was proudly established in 2003 by founders Edison Chen and Kevin Poon. Since then, the company has built its reputation on selling a unique selection of lifestyle goods as well as launching its own line of products from 2004. CLOT has collaborated with many international brands and artists including DISNEY, COCA-COLA and SCION. The brand’s ever-expanding business has grown from strictly music and fashion to design services, PR consulting, as well as event planning. The combination of these areas led to the opening of the renowned fashion and lifestyle store JUICE. Located in major cities across Asia, JUICE can be found in Hong Kong, Shanghai, Taipei, Kuala Lumpur, as well as a pop-up shop in Los Angeles. Along with its retail services, JUICE has hosted numerous events including new shoes launches with ADIDAS, CONVERSE, NIKE, RIVIERAS, VANS and VISVIM; book signings for KAWS ; and pop-up stores for KITSUNE, HOOD BY AIR, SSUR and STUSSY.";
    self.textView.text = @"CLOT是香港著名艺人陈冠希创办的凝结集团（CLOT FAMILY）的简称及该公司旗下潮流服装品牌名称。凝结集团是一个LIFESTYLE的公司，由香港著名艺人陈冠希创办于2003年6月。";
    self.textView.editable = NO;
    self.textView.selectable = NO;
    [self.contentView addSubview:self.textView];
}

- (void)initCoverScrollView {
    self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50 + 18, 130, 130)];
    self.coverImage.image = [UIImage imageNamed:@"CLOT"];
    [self.contentView addSubview:self.coverImage];
}

- (void)layoutSubviews {
    [self initTextView];
    [self initCoverScrollView];
   
}

@end
