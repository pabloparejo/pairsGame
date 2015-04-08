//
//  PARCardsViewController.m
//  PairsApp
//
//  Created by parejo on 7/4/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARCardsViewController.h"
#import "PARCardViewCell.h"
@interface PARCardsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *model;
@property (strong, nonatomic) PARCardViewCell *selectedCell;

@end

@implementation PARCardsViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype) init{
    if (self=[super init]) {
        NSMutableArray *randNumbers = [NSMutableArray array];
        for (int i=0; i<16; i++) {
            NSNumber *random = @(arc4random_uniform(8) + 1);
            
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
        _model = [randNumbers copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Pairs!"];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
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
    if (self.selectedCell) {
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
            NSLog(@"FOUND!");
        }else{
            // Delay execution of my block for 10 seconds.
            __weak PARCardViewCell *weakCell = self.selectedCell;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [collectionView deselectItemAtIndexPath:[collectionView indexPathForCell:weakCell] animated:YES];
                [collectionView deselectItemAtIndexPath:indexPath animated:YES];
            });
        }
        self.selectedCell = nil;
    }
}

@end
