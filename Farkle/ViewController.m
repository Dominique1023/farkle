//
//  ViewController.m
//  Farkle
//
//  Created by Dominique on 9/26/14.
//  Copyright (c) 2014 dominique vasquez. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate>
@property NSArray *dieArray;
@property NSMutableArray *dice;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel1;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel2;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel3;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel4;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel5;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel6;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dieArray = [[NSArray alloc]initWithObjects:self.dieLabel1, self.dieLabel2, self.dieLabel3, self.dieLabel4, self.dieLabel5, self.dieLabel6, nil];

    for (DieLabel *dieLabel in self.dieArray) {
        dieLabel.delegate = self;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onTapped:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"Tapped");
}

- (IBAction)onRollButtonPressed:(id)sender {
    for (DieLabel *label in self.dieArray) {
        [label roll];
    }

}

-(void)didChooseLabel:(id)dieLabel{

}

@end








