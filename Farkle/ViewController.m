//
//  ViewController.m
//  Farkle
//
//  Created by Dominique on 9/26/14.
//  Copyright (c) 2014 dominique vasquez. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate, UIAlertViewDelegate>
@property NSArray *dieArray;
@property NSMutableArray *dice;
@property NSMutableArray *selectedDice;
@property NSArray *roundLabels;
@property int score;
@property NSString *message;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel1;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel2;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel3;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel4;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel5;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel6;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *bankItButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dieArray = [[NSArray alloc]initWithObjects:self.dieLabel1, self.dieLabel2, self.dieLabel3, self.dieLabel4, self.dieLabel5, self.dieLabel6, nil];
    self.dice = [NSMutableArray new];
    self.selectedDice = [NSMutableArray new];

    for (DieLabel *label in self.dieArray) {
        label.backgroundColor = [UIColor colorWithRed:128/255.0 green:0/255.0 blue:0/255.0 alpha:1.0f];
        label.clipsToBounds = YES;
        label.layer.cornerRadius = 9; 
        label.delegate = self;
    }

    for (UILabel *roundLabel in self.view.subviews) {
        if ([roundLabel isKindOfClass:[UILabel class]] && ![roundLabel isKindOfClass:[DieLabel class]]) {
            self.roundLabels = [[NSArray alloc]initWithObjects:roundLabel, nil];

            roundLabel.hidden = YES; 
        }
    }

    self.userScore.hidden = NO;
    self.scoreLabel.hidden = NO;

    for (UIButton *button in self.view.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            button.clipsToBounds = YES;
            button.layer.cornerRadius = 9;
        }
    }
}

- (IBAction)onRollButtonPressed:(id)sender {
    for (DieLabel *label in self.dieArray) {
        if (![self.dice containsObject:label]) {
            [label roll];
        }
    }
}

-(void)didChooseLabel:(DieLabel *)dieLabel{
    dieLabel.backgroundColor = [UIColor colorWithRed:22/255.0 green:128/255.0 blue:18/255.0 alpha:1.0f];
    dieLabel.textColor = [UIColor whiteColor];
    [self.dice addObject:dieLabel];
    [self.selectedDice addObject:dieLabel];
}

- (IBAction)onResetButtonPressed:(id)sender {
    for (UILabel *label in self.dice) {
        label.backgroundColor = [UIColor colorWithRed:128/255.0 green:0/255.0 blue:0/255.0 alpha:1.0f];

    }
    self.userScore.text = @"0000";
    self.score = 0;
    [self.dice removeAllObjects];
    [self.selectedDice removeAllObjects];
    [self onRollButtonPressed:self];

}

- (IBAction)onBankItButtonPressed:(id)sender {
    [self farkleScoring];

    if (self.message.length != 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Score Error!" message:self.message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alertView show];

        if (self.score != 0) {
            self.userScore.text = [NSString stringWithFormat:@"%i", self.score];
        }

    }
    if (self.score != 0) {
        self.userScore.text = [NSString stringWithFormat:@"%i", self.score];
    }


}

-(void)farkleScoring{
    int ones = 0;
    int twos = 0;
    int threes = 0;
    int fours = 0;
    int fives = 0;
    int sixes = 0;

    for (UILabel *die in self.selectedDice) {
        switch ([die.text intValue]) {
            case 1:
                ones++;
                break;
            case 2:
                twos++;
                break;
            case 3:
                threes++;
                break;
            case 4:
                fours++;
                break;
            case 5:
                fives++;
                break;
            case 6:
                sixes++;
                break;
            default:
                break;
        }


    }//end of for loop

    //calculating ones
    if (ones > 0) {
        //if all 6 die selected is 1 then change the score and quit calculating the ones
        if (ones == 6) {
            self.score += 2000;
            ones -= 6;
        }

        //for all the ones add a 100 and take one away after checking there is still something.
        for (int y = 0; ones > 0 ; y++) {
            //if there are three ones selected than change the score and quit calculating the ones
                if (ones == 3) {
                    self.score += 1000;
                    ones -= 3;
                }
            if (ones > 0) {
                self.score += 100;
                ones--;
            }

        }
    }

    //calculating fives
    if (fives > 0) {
        if (fives == 6) {
            self.score = 1000;
            fives -= 6;
        }

        for (int i = 0; fives > 0 ; i++) {
            if (fives == 3) {
                self.score += 500;
                fives -= 3;
            }

            if (fives > 0) {
                self.score += 50;
                fives --;
            }
        }

    }

    //calculating twos
    if (twos > 0 ) {
        if (twos == 6) {
            self.score = 400;
            twos -= 6;
        }

        if (twos >= 3) {
            self.score = 200;
            if (twos > 3) {
                self.message = @"Can only bank 3 or 6 twos";
            }
            twos = 0;
        }

        if (twos > 0 ) {
            self.message = @"Can only bank 3 or 6 twos";
        }

    }

    //calculating threes
    if (threes > 0 ) {
        if (threes == 6) {
            self.score = 600;
            threes -= 6;
        }

        if (threes >= 3) {
            self.score = 300;
            if (threes > 3) {
                self.message = @"Can only bank 3 or 6 threes";
            }
            threes = 0;
        }

        if (threes > 0) {
            self.message = @"Can only bank 3 or 6 threes";

        }
    }

    //calculating fours
    if (fours > 0 ) {
        if (fours == 6) {
            self.score = 800;
            fours -= 6;
        }

        if (fours >= 3) {
            self.score = 400;
            if (fours > 3) {
                self.message = @"Can only bank 3 or 6 fours";
            }
            fours = 0;
        }

        if (fours > 0) {
            self.message = @"Can only bank 3 or 6 fours";
            
        }
    }

    //calculating sixes
    if (sixes > 0 ) {
        if (sixes == 6) {
            self.score = 1200;
            threes -= 6;
        }

        if (sixes >= 3) {
            self.score = 600;
            if (sixes > 3) {
                self.message = @"Can only bank 3 or 6 sixes";
            }
            sixes = 0;
        }

        if (sixes > 0) {
            self.message = @"Can only bank 3 or 6 sixes";
            
        }
    }

    [self.selectedDice removeAllObjects];
}


@end






