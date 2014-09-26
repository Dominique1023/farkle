//
//  DieLabel.h
//  Farkle
//
//  Created by Dominique on 9/26/14.
//  Copyright (c) 2014 dominique vasquez. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DieLabelDelegate
-(void)didChooseLabel:(id)dieLabel;

@end

@interface DieLabel : UILabel
@property id<DieLabelDelegate> delegate;
-(void)roll; 

@end
