//
//  PARCardsViewController.h
//  PairsApp
//
//  Created by parejo on 7/4/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARCardsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

- (IBAction)restartGame:(id)sender;
@end
