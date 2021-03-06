//
//  RCPublicServiceProfileUrlCell.m
//  HelloIos
//
//  Created by litao on 15/4/10.
//  Copyright (c) 2015年 litao. All rights reserved.
//

#import "RCPublicServiceProfileUrlCell.h"
#import "RCPublicServiceViewConstants.h"
#import "RCKitCommonDefine.h"

@interface RCPublicServiceProfileUrlCell ()
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) NSString *urlString;
@property(nonatomic, weak) id<RCPublicServiceProfileViewUrlDelegate> delegate;
@end

@implementation RCPublicServiceProfileUrlCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"hello"];
    ;

    if (self) {
        [self setup];
    }

    return self;
}

- (void)setup {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    bounds.size.height = 0;

    self.frame = bounds;

    self.title = [[UILabel alloc] initWithFrame:CGRectZero];

    self.title.numberOfLines = 0;
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.font = [UIFont systemFontOfSize:RCPublicServiceProfileBigFont];
    self.title.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.title];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setTitle:(NSString *)title url:(NSString *)urlString delegate:(id<RCPublicServiceProfileViewUrlDelegate>)delegate {
    self.title.text = title;
    self.urlString = urlString;
    [self updateFrame];
    if (urlString && urlString.length > 0) {
        UITapGestureRecognizer *tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTaped:)];
        [self addGestureRecognizer:tapGesture];
    }

    self.delegate = delegate;
}

- (void)onTaped:(id)sender {
    [self.delegate gotoUrl:self.urlString];
}
- (void)updateFrame {
    CGRect contentViewFrame = self.frame;
    UIFont *font = [UIFont systemFontOfSize:RCPublicServiceProfileBigFont];
    //设置一个行高上限
    CGSize size = CGSizeMake(RCPublicServiceProfileCellTitleWidth, 2000);
    //计算实际frame大小，并将label的frame变成实际大小
//    CGSize labelsize =
//        [self.title.text boundingRectWithSize:size
//                                      options:NSStringDrawingTruncatesLastVisibleLine |
//                                              NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                   attributes:@{
//                                       NSFontAttributeName : font
//                                   } context:nil]
//            .size;
//    CGSize labelsize = RC_MULTILINE_TEXTSIZE(self.title.text, font, size, NSLineBreakByTruncatingTail);
    CGSize labelsize = CGSizeZero;
    if (IOS_FSystenVersion < 7.0) {
        labelsize = RC_MULTILINE_TEXTSIZE_LIOS7(self.title.text, font, size, NSLineBreakByTruncatingTail);
    }else {
        labelsize = RC_MULTILINE_TEXTSIZE_GEIOS7(self.title.text, font, size);
    }


    self.title.frame = CGRectMake(2 * RCPublicServiceProfileCellPaddingLeft, RCPublicServiceProfileCellPaddingTop,
                                  labelsize.width, labelsize.height);

    contentViewFrame.size.height =
        self.title.frame.size.height + RCPublicServiceProfileCellPaddingTop + RCPublicServiceProfileCellPaddingBottom;
    self.frame = contentViewFrame;
}
@end