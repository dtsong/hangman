//
//  IOCTextToSpeech.m
//  Week03Working
//
//  Created by Abraham Avnisan on 2/6/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import "IOCTextToSpeech.h"
#import "IOCMath.h"


#if TARGET_OS_IPHONE
// BEGIN MAC IOS INTERFACE AND IMPLEMENTATION
// ________________________________________________________________________________________________ //

@import AVFoundation;

@interface IOCTextToSpeech ()

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) AVSpeechSynthesisVoice *currentVoice;
@property (strong, nonatomic) IOCMath *mathHelper;

@end



@implementation IOCTextToSpeech

#pragma mark - setters and getters
- (AVSpeechSynthesizer *)synthesizer
{
    if (!_synthesizer) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    return _synthesizer;
}
- (AVSpeechSynthesisVoice *)currentVoice
{
    if (!_currentVoice) {
        _currentVoice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    }
    return _currentVoice;
}
- (void)setVoice:(NSString *)voice
{
    self.currentVoice = [AVSpeechSynthesisVoice voiceWithIdentifier:voice];
}
- (IOCMath *)mathHelper
{
    if (!_mathHelper) {
        _mathHelper = [[IOCMath alloc] init];
    }
    return _mathHelper;
}
- (void)setRate:(float)rate
{
    float localRate = [self.mathHelper getClampedMappedValueWithInput:rate minInput:180.0 maxInput:220.0 minOutput:0.0 maxOutput:1.0];
    _rate = localRate;
}
#pragma mark - designated initializer
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setRate:200.0];
        [self setPitch:1.0];
    }
    return self;
}
#pragma mark - primary methods
- (void)startSpeakingString:(NSString *)stringToSpeak
{
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:stringToSpeak];
    utterance.voice = self.currentVoice;
    
    utterance.pitchMultiplier = self.pitch;
    utterance.rate = self.rate;
    
    [self.synthesizer speakUtterance:utterance];

}
- (void)selectRandomVoice
{
    // get all available voices
    NSArray *voices = [AVSpeechSynthesisVoice speechVoices];
    
    // get random int within the bounds of our array
    int upperBound = (int)[voices count] - 1;
    NSUInteger randomIndex = [self.mathHelper getRandomIntWithMinOutput:0 maxOutput:upperBound];
    
    // get a random voice
    AVSpeechSynthesisVoice *randomVoice = [voices objectAtIndex:randomIndex];
    
    self.currentVoice = randomVoice;
}
- (void)selectDefaultVoice
{
    self.currentVoice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
}
+ (NSArray *)availableVoices
{
    NSArray *voices = [AVSpeechSynthesisVoice speechVoices];

    NSMutableArray *voicesAsStrings = [[NSMutableArray alloc] init];
    for (AVSpeechSynthesisVoice *voice in voices) {
        [voicesAsStrings addObject:voice.identifier];
    }
    return [NSArray arrayWithArray:voicesAsStrings];
    
}

@end

#else
// BEGIN MAC OS INTERFACE AND IMPLEMENTATION
// ________________________________________________________________________________________________ //

@import AppKit;

@interface IOCTextToSpeech ()

@property (strong, nonatomic) NSSpeechSynthesizer *synthesizer;

@end

@implementation IOCTextToSpeech

#pragma mark - accessor methods

@synthesize voice;
@synthesize pitch;

- (float)pitch
{
    NSLog(@"ERROR! The pitch property is only available on iOS");
    exit(1);
}
- (void)setPitch
{
    NSLog(@"ERROR! The pitch property is only available on iOS");
    exit(1);
}
- (NSSpeechSynthesizer *)synthesizer
{
    if (!_synthesizer) {
        _synthesizer = [[NSSpeechSynthesizer alloc] init];
    }
    return _synthesizer;
}
- (void)setRate:(float)rate
{
    _rate = rate;
    self.synthesizer.rate = rate;
}
- (NSString *)voice
{
    return self.synthesizer.voice;
}
- (void)setVoice:(NSString *)newVoice
{
    [self.synthesizer setVoice:newVoice];
}
#pragma mark - main class methods
- (void)startSpeakingString:(NSString *)stringToSpeak
{
    NSLog(@"speaking '%@'", stringToSpeak);
    
    [self.synthesizer startSpeakingString:stringToSpeak];
    
    for (int i = 0; i < 10000000; i++) {
        
    }
    
    while (self.synthesizer.isSpeaking) {
        // create a loop that waits
        // until the synthesizer is
        // finished speaking
    }
    
    //    NSLog(@"finished speaking");
}
- (void)selectRandomVoice
{
    // set up math helper
    IOCMath *mathHelper = [[IOCMath alloc] init];
    
    // get all available voices
    NSArray *voices = [NSSpeechSynthesizer availableVoices];
    
    // get random int within the bounds of our array
    int upperBound = (int)[voices count] - 1;
    NSUInteger randomIndex = [mathHelper getRandomIntWithMinOutput:0 maxOutput:upperBound];
    
    // get a random voice
    NSString *randomVoice = [voices objectAtIndex:randomIndex];
    
    [self.synthesizer setVoice:randomVoice];
    
}
+ (NSArray *)availableVoices
{
    return [NSSpeechSynthesizer availableVoices];
}
- (void)selectDefaultVoice
{
    self.voice = [NSSpeechSynthesizer defaultVoice];
}
@end
#endif


