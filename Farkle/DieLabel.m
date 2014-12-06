//
//  DieLabel.m
//  Farkle
//
//  Created by Dominique on 9/26/14.
//  Copyright (c) 2014 dominique vasquez. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

-(void)roll{
    int number = arc4random() %6 +1;
    self.text = [NSString stringWithFormat:@"%d", number ];
}

-(IBAction)onTap:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.delegate didChooseLabel:self]; 
}



@end
