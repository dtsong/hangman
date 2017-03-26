//
//  IOCImageAndTextViewSlideShow.h
//  MidtermDemo
//
//  Created by Abraham Avnisan on 2/21/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @class IOCImageAndTextViewSlideShow
 * 
 * @dicussion 	This class allows clients to configure an interactive
 *              "slideshow" or "textshow", with options to set the fade 
 *              duration and delay between images.  To use it, connect 
 *              it via a UIView object in interface builder, and set 
 *              its imagesArray property to an array of UIImages. 
 *              Swiping right and left moves to the next and previous 
 *              image respectively. Tapping moves to the next image.
 *              A long press "plays" the slide show until the finger is
 *              lifted.
 */
@interface IOCImageAndTextViewSlideShow : UIView

// PROPERTIES
// ________________________________________________________________________________________________ //

/**
 * @brief The slide show delay, in seconds. The default value is 0.1.
 */
@property (nonatomic) NSTimeInterval slideShowDelay;
/**
 * @brief The fade duration, in seconds. The default value is 0.
 */
@property (nonatomic) NSTimeInterval fadeDuration;
/**
 * @brief The array of UIImages to be used in the slide show.
 */
@property (strong, nonatomic) NSArray<UIImage *> *imagesArray;
/**
 * @brief How to display the image. The default value for this property is UIViewContentModeScaleAspectFill.
 */
@property (nonatomic) UIViewContentMode imageContentMode;
/**
 * @brief The array of NSString's to be used in the slide show.
 */
@property (strong, nonatomic) NSArray<NSString *> *textsArray;
/**
 * @brief The name of the font used to display text. Any font that can be found in the utility pane can be used here.
 */
@property (strong, nonatomic) NSString *fontName;
/**
 * @brief The size at which the text should be shown.
 */
@property (nonatomic) float fontSize;
/**
 * @brief The text color.
 */
@property (strong, nonatomic) UIColor *textColor;
/**
 * @brief The text alignment.
 */
@property (nonatomic) NSTextAlignment textAlignment;



// METHODS
// ________________________________________________________________________________________________ //

/**
 * @discussion  call this method to begin the slide show, which will
 *              run continuously until the stopPlaying method is called.
 */
- (void)startPlaying;
/**
 * @discussion  call this method to stop playing the slide show.
 */
- (void)stopPlaying;
/**
 * @discussion  call this method to show the next image in the imagesArray.
 */
- (void)showNextItem;
/**
 * @discussion  call this method to show the previous image in the imagesArray.
 */
- (void)showPreviousItem;
/**
 * @discussion  call this method to show a random image from K { the imagesArray.
 */
- (void)showRandomItem;

@end
