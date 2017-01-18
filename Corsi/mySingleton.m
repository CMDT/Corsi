//
//  mySingleton.m
//  Corsi
//
//  Created by Jon Howell on 04/09/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  Minor updates and re-build for distro 14/11/15 jah
//  Minor updates and re-build for distro 9/9/16 jah
//

#import "mySingleton.h"

static mySingleton * sharedSingleton = nil;

@implementation mySingleton {
}

// eg::: @synthesize offset;
@synthesize
    currentShowColour,
    currentBlockColour,
    currentBackgroundColour,
    currentStatusColour,
    blockSize,
    showTime,
    start,
    startTime,
    finish,
    waitTime,
    messageTime,
    oldSubjectName,
    subjectName,
    testerName,
    testDate,
    testTime,
    resultStrings,      //string
    resultStringRows,   //array

    email,
    forwardTestDirection,
    blockRotation,
    onScreenInfo,
    animals,
    sounds,
    dataReady,          //if there is data to display in the table YES bool
    beepEffect,

    displayStrings,     //result item
    displayStringRows,  //array
    
    displayStringsTitle,//result title
    displayStringTitles,//array

    segIndex;           //sounds

#pragma mark -
#pragma mark Singleton Methods

+ (mySingleton *) sharedSingleton {
    if(sharedSingleton  == nil) {
        sharedSingleton = [[super allocWithZone:NULL]init];
    }
    return sharedSingleton;
}

+(id)allocWithZone:(NSZone *)zone {
    return [self sharedSingleton];
}

- (id)copyWithZone:(NSZone *) zone {
    return self;
}

- (id) init {
    if(self = [super init]) {
    //only runs if no data or first run to give default values
        
    currentBackgroundColour  = [UIColor blackColor];
        currentBlockColour   = [UIColor darkGrayColor];
        currentShowColour    = [UIColor yellowColor];
        currentStatusColour  = [UIColor yellowColor];
        start                = 3;
        finish               = 9;
        blockSize            = 45.00;
        waitTime             = 1500;
        startTime            = 1500;
        showTime             = 1500;
        messageTime          = 2000; //for on screen instructions and messages in time interval delay
        blockRotation        = YES;
        onScreenInfo         = YES;
        animals              = NO;
        sounds               = YES;
        dataReady            = NO;
        beepEffect           = @"BEEPJAZZ";
        segIndex             = 5;
        forwardTestDirection = YES;
        resultStrings        = @"";
        displayStrings       = @"";
        resultStringRows     = [[NSMutableArray alloc]initWithObjects: @"",nil]; //clear the arrays of any data
        displayStringRows    = [[NSMutableArray alloc]initWithObjects: @"",nil];
        displayStringTitles  = [[NSMutableArray alloc]initWithObjects: @"",nil];
        email                = @"me@text.com";
        }
    return self;
}
@end
