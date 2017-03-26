//
//  IOCTextToSpeech.h
//  Week03Working
//
//  Created by Abraham Avnisan on 2/6/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOCTextToSpeech : NSObject

@property (nonatomic) float rate;
@property (strong, nonatomic) NSString *voice;

/**
 * @discussion The default pitch is 1.0. Allowed values are in the range from 0.5 (for lower pitch) to 2.0 (for higher pitch).
 * @warning this property is only available on iOS!
 */
@property (nonatomic) float pitch;

- (void)startSpeakingString:(NSString *)stringToSpeak;
- (void)selectRandomVoice;
- (void)selectDefaultVoice;
+ (NSArray *)availableVoices;

@end
