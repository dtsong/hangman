//
//  IOCImageAndTextViewSlideShow.m
//  MidtermDemo
//
//  Created by Abraham Avnisan on 2/21/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import "IOCImageAndTextViewSlideShow.h"
#import "IOCMath.h"

@interface IOCImageAndTextViewSlideShow ()

// GENERAL
@property (nonatomic) BOOL configuredForImages;

// IMAGES
@property (strong, nonatomic) UIImageView *imageViewA;
@property (strong, nonatomic) UIImageView *imageViewB;
@property (nonatomic) BOOL imageViewAIsPrimary;
@property (nonatomic) NSInteger itemIndex;

// TEXT
@property (strong, nonatomic) UILabel *textViewA;
@property (strong, nonatomic) UILabel *textViewB;
@property (nonatomic) BOOL textViewAIsPrimary;
//@property (nonatomic) NSUInteger textIndex;

// SLIDE SHOW
@property (nonatomic) BOOL isPlaying;
@property (strong, nonatomic) NSTimer *timer;

// GESTURE RECOGNIZERS
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPressRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipeRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipeRecognizer;

// HELPER CLASSES
@property (strong, nonatomic) IOCMath *mathHelper;

@end

@implementation IOCImageAndTextViewSlideShow

#pragma mark - accessor methods
// GESTURE RECOGNIZERS - LAZY INSTANTIATION
- (UITapGestureRecognizer *)tapRecognizer
{
    if (!_tapRecognizer) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(tapRecognizedWithRecognizer:)];
    }
    return _tapRecognizer;
}
- (UILongPressGestureRecognizer *)longPressRecognizer
{
    if (!_longPressRecognizer) {
        _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(longPressRecognizedWithRecognizer:)];
    }
    return _longPressRecognizer;
}
- (UISwipeGestureRecognizer *)leftSwipeRecognizer
{
    if (!_leftSwipeRecognizer) {
        _leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(leftSwipeRecognizedWithRecognizer:)];
        _leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _leftSwipeRecognizer;
}
- (UISwipeGestureRecognizer *)rightSwipeRecognizer
{
    if (!_rightSwipeRecognizer) {
        _rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(rightSwipeRecognizedWithRecognizer:)];
        _rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _rightSwipeRecognizer;
}
// IMAGE VIEW - LAZY INSTANTIATION
- (UIImageView *)imageViewA
{
    if (!_imageViewA) {
        _imageViewA = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageViewA.contentMode = self.contentMode;
        [_imageViewA setClipsToBounds:YES];
    }
    return _imageViewA;
}
- (UIImageView *)imageViewB
{
    if (!_imageViewB) {
        _imageViewB = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageViewB.contentMode = self.contentMode;
        [_imageViewB setClipsToBounds:YES];
    }
    return _imageViewB;
}
// TEXT VIEW - LAZY INSTANTIATION
- (UILabel *)textViewA
{
    if (!_textViewA) {
        _textViewA = [[UILabel alloc] initWithFrame:self.bounds];
        _textViewA.font = [UIFont fontWithName:self.fontName size:self.fontSize];
        _textViewA.numberOfLines = 0;
        _textViewA.textAlignment = self.textAlignment;
    }
    return _textViewA;
}
- (UILabel *)textViewB
{
    if (!_textViewB) {
        _textViewB = [[UILabel alloc] initWithFrame:self.bounds];
        _textViewB.font = [UIFont fontWithName:self.fontName size:self.fontSize];
        _textViewB.numberOfLines = 0;
        _textViewB.textAlignment = self.textAlignment;
    }
    return _textViewB;
}
- (void)setItemIndex:(NSInteger)itemIndex
{
    
    NSUInteger maxIndex = self.configuredForImages ? self.imagesArray.count - 1 : self.textsArray.count - 1;
    
    if (itemIndex > maxIndex) {
        _itemIndex = 0;
    } else if (itemIndex < 0) {
        _itemIndex = maxIndex;
    } else {
        _itemIndex = itemIndex;
    }
    
}
// OTHER CLASSES - LAZY INSTANTIATION
- (IOCMath *)mathHelper
{
    if (!_mathHelper) {
        _mathHelper = [[IOCMath alloc] init];
    }
    return _mathHelper;
}
// OTHER CLASSES - CUSTOM SETTERS
- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    self.configuredForImages = YES;
    if (imagesArray.count > 1) {
        [self.imageViewA setImage:imagesArray[0]];
        [self.imageViewB setImage:imagesArray[1]];
    } else if (imagesArray.count == 1) {
        [self.imageViewA setImage:imagesArray[0]];
        [self.imageViewB setImage:imagesArray[0]];
    } else {
        NSLog(@"ERROR! Trying to set the imagesArray property with an empty array!");
        exit(EXIT_FAILURE);
    }
}
- (void)setTextsArray:(NSArray<NSString *> *)textsArray
{
    _textsArray = textsArray;
    self.configuredForImages = NO;
    if (textsArray.count > 1) {
        [self.textViewA setText:textsArray[0]];
        [self.textViewB setText:textsArray[1]];
    } else if (textsArray.count == 1) {
        [self.textViewA setText:textsArray[0]];
        [self.textViewB setText:textsArray[0]];
    } else {
        NSLog(@"ERROR! Trying to set the textsArray property with an empty array!");
        exit(EXIT_FAILURE);
    }
    
}
- (void)setFontName:(NSString *)fontName
{
    _fontName = fontName;
    self.textViewA.font = [UIFont fontWithName:fontName size:self.fontSize];
    self.textViewB.font = [UIFont fontWithName:fontName size:self.fontSize];
}
- (void)setFontSize:(float)fontSize
{
    _fontSize = fontSize;
    self.textViewA.font = [UIFont fontWithName:self.fontName size:fontSize];
    self.textViewB.font = [UIFont fontWithName:self.fontName size:fontSize];

}
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textViewA.textColor = textColor;
    self.textViewB.textColor = textColor;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    self.textViewA.textAlignment = textAlignment;
    self.textViewB.textAlignment = textAlignment;
}
- (void)setImageContentMode:(UIViewContentMode)imageContentMode
{
    
    _imageContentMode = imageContentMode;
    self.imageViewA.contentMode = imageContentMode;
    self.imageViewB.contentMode = imageContentMode;
}
#pragma mark - setup
- (void)setup
{
    // CONFIGURE INITIAL STATE
    self.itemIndex = 0;
    self.isPlaying = NO;
    self.slideShowDelay = .1;
    self.imageViewAIsPrimary = YES;
    self.textViewAIsPrimary = YES;
    self.fadeDuration = 0.0;
    
    // CONFIGURE DEFAULT IMAGE CHARACTERISTICS
    self.imageContentMode = UIViewContentModeScaleAspectFill;
    
    // CONFIGURE DEFAULT TEXT CHARACTERISTICS
    self.fontName = @"Helvetica Neue";
    self.fontSize = 24.0;
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentCenter;
    
    // SETUP GESTURE RECOGNIZERS
    [self addGestureRecognizer:self.tapRecognizer];
    [self addGestureRecognizer:self.longPressRecognizer];
    [self addGestureRecognizer:self.leftSwipeRecognizer];
    [self addGestureRecognizer:self.rightSwipeRecognizer];
    
    // SETUP IMAGE VIEW
    [self addSubview:self.imageViewA];
    [self addSubview:self.imageViewB];
    [self hideImageView:self.imageViewB];
    
    // SETUP TEXT VIEW
    [self addSubview:self.textViewA];
    [self addSubview:self.textViewB];
    [self hideLabel:self.textViewB];
    
}
#pragma mark - main logic
- (void)showItemWithIndex:(NSUInteger)index
{
    if (self.configuredForImages) {
        if (index > self.imagesArray.count || !self.imagesArray) {
            NSLog(@"ERROR! the imagesArray on this IOCImageAndTextViewSlideShow object is empty! Try setting an array of images for this object's property.");
            exit(EXIT_FAILURE);
        }
        
        if (self.imageViewAIsPrimary) {
            [self.imageViewB setImage:self.imagesArray[index]];
            [self showImageView:self.imageViewB];
            [self hideImageView:self.imageViewA];
        } else {
            [self.imageViewA setImage:self.imagesArray[index]];
            [self showImageView:self.imageViewA];
            [self hideImageView:self.imageViewB];
        }
        self.imageViewAIsPrimary = !self.imageViewAIsPrimary;
    } else {
        if (index > self.textsArray.count || !self.textsArray) {
            NSLog(@"ERROR! the textsArray on this IOCImageAndTextViewSlideShow object is empty! Try setting an array of images for this object's property.");
            exit(EXIT_FAILURE);
        }
        
        if (self.textViewAIsPrimary) {
            [self.textViewB setText:self.textsArray[index]];
            [self showLabel:self.textViewB];
            [self hideLabel:self.textViewA];
        } else {
            [self.textViewA setText:self.textsArray[index]];
            [self showLabel:self.textViewA];
            [self hideLabel:self.textViewB];
        }
        self.textViewAIsPrimary = !self.textViewAIsPrimary;
    }
    
}
- (void)hideImageView:(UIImageView *)imageViewToHide
{
    [UIView animateWithDuration:self.fadeDuration animations:^{
        imageViewToHide.alpha = 0.0;
    }];
}
- (void)showImageView:(UIImageView *)imageViewToShow
{
    [UIView animateWithDuration:self.fadeDuration animations:^{
        imageViewToShow.alpha = 1.0;
    }];
}
- (void)hideLabel:(UILabel *)labelToHide
{
    [UIView animateWithDuration:self.fadeDuration animations:^{
        labelToHide.alpha = 0.0;
    }];
}
- (void)showLabel:(UILabel *)labelToShow
{
    [UIView animateWithDuration:self.fadeDuration animations:^{
        labelToShow.alpha = 1.0;
    }];
}
- (void)showNextItem
{
    self.itemIndex++;
    [self showItemWithIndex:self.itemIndex];
}
- (void)showPreviousItem
{
    self.itemIndex--;
    [self showItemWithIndex:self.itemIndex];
}
- (void)showRandomItem
{
    NSUInteger randomIndex;
    if (self.configuredForImages) {
        randomIndex = (NSUInteger)[self.mathHelper getRandomIntWithMinOutput:0 maxOutput:(int)self.imagesArray.count];
    } else {
        randomIndex = (NSUInteger)[self.mathHelper getRandomIntWithMinOutput:0 maxOutput:(int)self.textsArray.count];
    }
    self.itemIndex = randomIndex;
    [self showItemWithIndex:self.itemIndex];
}
- (void)startPlaying
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.slideShowDelay + self.fadeDuration target:self selector:@selector(showNextItem) userInfo:nil repeats:YES];
}
- (void)stopPlaying
{
    [self.timer invalidate];
}
#pragma mark - interactivity
- (void)tapRecognizedWithRecognizer:(UIGestureRecognizer *)recognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self startPlaying];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self stopPlaying];
    }
    [self showNextItem];
}
- (void)longPressRecognizedWithRecognizer:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self startPlaying];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self stopPlaying];
    }
}
- (void)rightSwipeRecognizedWithRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self showNextItem];
}
- (void)leftSwipeRecognizedWithRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self showPreviousItem];
}
#pragma mark - inherited methods
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
@end

