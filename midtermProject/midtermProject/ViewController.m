//
//  ViewController.m
//  midtermProject
//
//  Created by Deborah Song on 3/16/17.
//  Copyright © 2017 Deborah Song. All rights reserved.
//

#import "ViewController.h"
#import "IOCCommandLineInputOutput.h"
#import "IOCMath.h"
#import "IOCTextInput.h"
#import "NSArray+IOC.h"

@interface ViewController ()

// Properties created by me
@property (strong, nonatomic) IOCTextInput *textInput;
@property (strong, nonatomic) NSArray *answers;
@property (strong, nonatomic) NSString *currentAnswer;
@property (strong, nonatomic) NSArray *hangman;



// Properties created by XCode
@property (weak, nonatomic) IBOutlet UIButton *guessA;
@property (weak, nonatomic) IBOutlet UIButton *guessB;
@property (weak, nonatomic) IBOutlet UIButton *guessC;
@property (weak, nonatomic) IBOutlet UIButton *guessD;
@property (weak, nonatomic) IBOutlet UIButton *guessE;
@property (weak, nonatomic) IBOutlet UIButton *guessF;
@property (weak, nonatomic) IBOutlet UIButton *guessG;
@property (weak, nonatomic) IBOutlet UIButton *guessH;
@property (weak, nonatomic) IBOutlet UIButton *guessI;
@property (weak, nonatomic) IBOutlet UIButton *guessJ;
@property (weak, nonatomic) IBOutlet UIButton *guessK;
@property (weak, nonatomic) IBOutlet UIButton *guessL;
@property (weak, nonatomic) IBOutlet UIButton *guessM;
@property (weak, nonatomic) IBOutlet UIButton *guessN;
@property (weak, nonatomic) IBOutlet UIButton *guessO;
@property (weak, nonatomic) IBOutlet UIButton *guessP;
@property (weak, nonatomic) IBOutlet UIButton *guessQ;
@property (weak, nonatomic) IBOutlet UIButton *guessR;
@property (weak, nonatomic) IBOutlet UIButton *guessS;
@property (weak, nonatomic) IBOutlet UIButton *guessT;
@property (weak, nonatomic) IBOutlet UIButton *guessU;
@property (weak, nonatomic) IBOutlet UIButton *guessV;
@property (weak, nonatomic) IBOutlet UIButton *guessW;
@property (weak, nonatomic) IBOutlet UIButton *guessX;
@property (weak, nonatomic) IBOutlet UIButton *guessY;
@property (weak, nonatomic) IBOutlet UIButton *guessZ;


// create two new array properties, one to hold your UIImageViews
// the other to hold your UILabel's

// initialize them in setup, using the arrrayWithObjects class method

// create an NSUInteger property imageIndex

@property (weak, nonatomic) IBOutlet UIImageView *hangman1;
@property (weak, nonatomic) IBOutlet UIImageView *hangman2;
@property (weak, nonatomic) IBOutlet UIImageView *hangman3;
@property (weak, nonatomic) IBOutlet UIImageView *hangman4;
@property (weak, nonatomic) IBOutlet UIImageView *hangman5;
@property (weak, nonatomic) IBOutlet UIImageView *hangman6;
@property (weak, nonatomic) IBOutlet UIImageView *hangman7;

@property (weak, nonatomic) IBOutlet UILabel *letter1;
@property (weak, nonatomic) IBOutlet UILabel *letter2;
@property (weak, nonatomic) IBOutlet UILabel *letter3;
@property (weak, nonatomic) IBOutlet UILabel *letter4;
@property (weak, nonatomic) IBOutlet UILabel *letter5;

@end

@implementation ViewController


- (void)setup
{
    IOCCommandLineInputOutput *IO = [[IOCCommandLineInputOutput alloc] init];
    
    self.answers = [NSArray arrayWithObjects:@"water", @"earth", @"filth", nil];
    
    self.currentAnswer = [self.answers getRandomObject];
    NSLog(@"currentAnswer: %@", self.currentAnswer);
    
    for (NSUInteger i = 0; i < self.currentAnswer.length; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        NSString *currentLetter = [self.currentAnswer substringWithRange:range];
        

        // set the text of the label with index i (from your array of uilabel's)
        // to the current letter
        // and set the text color to the background color so that it is invisible
        
    }
    
}

- (IBAction)userGuessedLetter:(UIButton *)sender
{
    NSString *letterUserGuessed = sender.titleLabel.text;
    
    // check to see if letter is in the word
    BOOL userGuessedCorrectly = NO;
    
    for (NSUInteger i = 0; i < self.currentAnswer.length; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        NSString *currentLetter = [self.currentAnswer substringWithRange:range];
        
        if ([currentLetter.uppercaseString isEqualToString:letterUserGuessed]) {
            // user guessed correctly
            userGuessedCorrectly = YES;
        }
    }
    
    if (userGuessedCorrectly) {
        NSLog(@"correct");
        // add letter to label
        
    } else {
        NSLog(@"incorrect");
        // show the next image
        UIImage *image = [UIImage imageNamed:@"hangman_1.png"];
        UIImageView *hangman = [[UIImageView alloc] initWithImage:image];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // THIS IS THE STARTING PLACE FOR EVERY IOS PROGRAM
    [self setup];
    
}



@end
