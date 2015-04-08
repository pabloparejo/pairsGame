//
//  PARCardViewCell.m
//  PairsApp
//
//  Created by parejo on 7/4/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARCardViewCell.h"

@implementation PARCardViewCell

- (void)awakeFromNib {
    // Initialization code
    UIColor *background = [UIColor colorWithRed:41.0/255 green:120.0/255 blue:175.0/255 alpha:1.0];
    [self setBackgroundColor:background];
    [self.cardLabel.layer setTransform:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
    [self.cardLabel setAlpha:0];
}

-(void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        [UIView animateWithDuration:0.5 animations:^{
            CATransform3D transformer = CATransform3DMakeRotation(M_PI_2, 0.1, 0.5, 0);
            self.layer.transform = CATransform3DScale(transformer, 1.1, 1.1, 1);
        } completion:^(BOOL finished) {
            [self.cardLabel setAlpha:1];
            [UIView animateWithDuration:0.5 animations:^{
                self.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0.5, 0);;
            }];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            CATransform3D transformer = CATransform3DMakeRotation(M_PI_2, 0.1, 0.5, 0);
            self.layer.transform = CATransform3DTranslate(transformer, 100, 0, 0);
        } completion:^(BOOL finished) {
            [self.cardLabel setAlpha:0];
            [UIView animateWithDuration:0.5 animations:^{
                self.layer.transform = CATransform3DIdentity;
            }];
        }];
    }
    
    
}

@end
