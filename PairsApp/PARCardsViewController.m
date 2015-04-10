//
//  PARCardsViewController.m
//  PairsApp
//
//  Created by parejo on 7/4/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARCardsViewController.h"
#import "PARCardViewCell.h"

#define NUMBER_OF_CARDS 16
@interface PARCardsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *model;
@property (strong, nonatomic) PARCardViewCell *selectedCell;
@property (strong, nonatomic) NSDate *startTime;
@property (nonatomic) NSUInteger foundCards;
@property (strong, nonatomic) NSTimer *timer;


@end

@implementation PARCardsViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Pairs!"];
    
    [self startNewGame];

    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView setAllowsMultipleSelection:YES];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"PARCardViewCell" bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NUMBER_OF_CARDS;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    PARCardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                      forIndexPath:indexPath];

    NSString *cellText = [NSString stringWithFormat:@"%@", [self.model objectAtIndex:indexPath.row]];
    [cell.cardLabel setText:cellText];
    // Configure the cell
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(BOOL) collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView cellForItemAtIndexPath:indexPath].selected) {
        return NO;
    }
    return YES;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PARCardViewCell *cell = (PARCardViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!self.selectedCell) {
        self.selectedCell = cell;
    }else{
        NSLog(@"%@ - %@", self.selectedCell.cardLabel.text, cell.cardLabel.text);
        if ([self.selectedCell.cardLabel.text isEqualToString: cell.cardLabel.text]) {
            self.foundCards += 2;
            if (self.foundCards == NUMBER_OF_CARDS) {
                [self.subtitleLabel setText:@"YOU WIN!"];
                [self.timer invalidate];
            }
        }else{
            // Delay execution of my block for 1 second.
            __weak PARCardViewCell *weakCell = self.selectedCell;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [collectionView deselectItemAtIndexPath:[collectionView indexPathForCell:weakCell] animated:YES];
                [collectionView deselectItemAtIndexPath:indexPath animated:YES];
            });
        }
        self.selectedCell = nil;
    }
}

#pragma mark - Utils

-(void) startNewGame{
    [self.subtitleLabel setText:@""];
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    self.startTime = [NSDate date];
    self.model = [self generateRandNumbers];
    self.selectedCell = nil;
    self.foundCards = 0;
    [self.collectionView reloadData];
}

-(NSArray *) generateRandNumbers{
    NSMutableArray *randNumbers = [NSMutableArray array];
    for (int i=0; i<NUMBER_OF_CARDS; i++) {
        NSNumber *random = @(arc4random_uniform(NUMBER_OF_CARDS / 2) + 1);
        
        static int timesFound = 0;
        [randNumbers enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
            if ([obj integerValue]  == [random integerValue]) {
                timesFound++;
            }
        }];
        if (timesFound < 2) {
            [randNumbers addObject:random];
        }else{
            i--;
        }
        timesFound = 0;
    }
    return [randNumbers copy];
}

- (IBAction)restartGame:(id)sender {
    [self startNewGame];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    //float milisecods = (interval - ti)*10;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

-(void) updateTimer{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startTime];
    [self.timerLabel setText:[self stringFromTimeInterval:interval]];
}
@end
