//
//  L2MapButton.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-23.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "L2MapButton.h"
#import "RootViewController.h"

@implementation L2MapButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)onTouchUp:(id)sender
{
    if (self.vcType != [self.rvc currentVCType] || ![self.subType isEqualToString:[self.rvc currentSubType]])
    {
        [self.rvc setVcType:self.vcType andSubType:self.subType];
        for (UIView* view in self.rvc.view.subviews)
        {
            if ([view isKindOfClass:[L2Button class]])
            {
                [self.rvc.view sendSubviewToBack:view];
                //self.titleLabel.textColor = [UIColor whiteColor];
                
            }
        }
        [self.rvc.view bringSubviewToFront:self];
        //self.titleLabel.textColor = [UIColor blackColor];
        //self.tintColor = [UIColor blackColor];
    }
}
@end
