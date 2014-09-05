//
//  settingsVCViewController.m
//  Corsi
//
//  Created by Jon Howell on 04/09/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "settingsVC.h"
#import "mySingleton.h"

@interface settingsVC ()

@end

@implementation settingsVC
{
    int start;
    int finish;
    int blockSize;
    int waitTime;
    int startTime;
    int showTime;
    int rot1;
    int rot2;
    int rot3;
    int rot4;
    int rot5;
    int rot6;
    int rot7;
    int rot8;
    int rot9;
    BOOL forwardTestDirection;
    BOOL screenInfoDisplayed;
    BOOL testEnded;
    int  clickNumber;
    NSArray *forward;
    NSArray *reverse;
    
    NSArray *guess1;
    NSArray *guess2;
    NSArray *guess3;
    NSArray *guess4;
    NSArray *guess5;
    NSArray *guess6;
    NSArray *guess7;
    NSArray *guess8;
    NSArray *guess9;
    
    NSArray *score1;
    NSArray *score2;
    NSArray *score3;
    NSArray *score4;
    NSArray *score5;
    NSArray *score6;
    NSArray *score7;
    NSArray *score8;
    NSArray *score9;
    
    NSArray *times1;
    NSArray *times2;
    NSArray *times3;
    NSArray *times4;
    NSArray *times5;
    NSArray *times6;
    NSArray *times7;
    NSArray *times8;
    NSArray *times9;
    
    CGPoint blk1pos;
    CGPoint blk2pos;
    CGPoint blk3pos;
    CGPoint blk4pos;
    CGPoint blk5pos;
    CGPoint blk6pos;
    CGPoint blk7pos;
    CGPoint blk8pos;
    CGPoint blk9pos;
    
    UIColor *currentBlockColour;
    UIColor *currentShowColour;
    UIColor *currentBackgroundColour;
    
    NSArray *totalCorrect;
}

@synthesize blockFinishNumLBL,blockRotateSWT,blockShowTimeLBL,blockSizeLBL;
@synthesize blockStartDelayLBL,blockStartNumLBL,blockWaitTimeLBL;
@synthesize forwardTestSWT,blockStartDelaySLD,blockShowTimeSLD,blockWaitTimeSLD;
@synthesize block1View,block2View,block3View,block4View,block5View;
@synthesize block6View,block7View,block8View,block9View,settingsViewerVIEW;
@synthesize sizeMinusBTN,sizePlusBTN,startMinusBTN,startPlusBTN,finishMinusBTN,finishPlusBTN,onScreenInfoSWT;
//@synthesize bl1,bl2,bl3,bl4,bl5,bl6,bl7,bl8,bl9,CBTView,infoFinishLBL,infoRoundLBL,infoSelectLBL,infoStartLBL,myMessageLBL;
@synthesize currentBackgroundColour,currentBlockColour,currentShowColour;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    currentBlockColour=singleton.currentBlockColour;
    currentShowColour=singleton.currentShowColour;
    currentBackgroundColour=singleton.currentBackgroundColour;
    
    //only set values if not set already
    if(!startTime)
    {
        start     = 3;
        finish    = 9;
        blockSize = 30;
        waitTime  = 500;
        startTime = 2000;
        showTime  = 500;
        
        [self setRot90];
    }
    
    blockSizeLBL.text=[[NSString alloc]initWithFormat:@"%i",blockSize];
    [self updateBlockColours];
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];
    [self updateTiming];
}

-(void)hideAllBlocks{
    self.block1View.hidden=YES;
    self.block2View.hidden=YES;
    self.block3View.hidden=YES;
    self.block4View.hidden=YES;
    self.block5View.hidden=YES;
    self.block6View.hidden=YES;
    self.block7View.hidden=YES;
    self.block8View.hidden=YES;
    self.block9View.hidden=YES;
}

-(void)updateSizesOfBlocks{
    mySingleton *singleton = [mySingleton sharedSingleton];

    blockSizeLBL.text=[[NSString alloc]initWithFormat:@"%i", blockSize];
    singleton.blockSize = blockSize;
    
    //get pos of centres
    CGPoint block1pt = block1View.frame.origin;
    CGPoint block2pt = block2View.frame.origin;
    CGPoint block3pt = block3View.frame.origin;
    CGPoint block4pt = block4View.frame.origin;
    CGPoint block5pt = block5View.frame.origin;
    CGPoint block6pt = block6View.frame.origin;
    CGPoint block7pt = block7View.frame.origin;
    CGPoint block8pt = block8View.frame.origin;
    CGPoint block9pt = block9View.frame.origin;

    //move the block

    block1View.frame=CGRectMake(block1pt.x, block1pt.y, blockSize, blockSize) ;
    block2View.frame=CGRectMake(block2pt.x, block2pt.y, blockSize, blockSize) ;
    block3View.frame=CGRectMake(block3pt.x, block3pt.y, blockSize, blockSize) ;
    block4View.frame=CGRectMake(block4pt.x, block4pt.y, blockSize, blockSize) ;
    block5View.frame=CGRectMake(block5pt.x, block5pt.y, blockSize, blockSize) ;
    block6View.frame=CGRectMake(block6pt.x, block6pt.y, blockSize, blockSize) ;
    block7View.frame=CGRectMake(block7pt.x, block7pt.y, blockSize, blockSize) ;
    block8View.frame=CGRectMake(block8pt.x, block8pt.y, blockSize, blockSize) ;
    block9View.frame=CGRectMake(block9pt.x, block9pt.y, blockSize, blockSize) ;

    float scale=1;
    CGAffineTransform scaleTrans = CGAffineTransformMakeScale(scale, scale);


    singleton.blockSize=[blockSizeLBL.text intValue];


    CGAffineTransform rotateTrans =
    CGAffineTransformMakeRotation(0 * M_PI / 180);

    block1View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block2View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block3View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block4View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block5View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block6View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block7View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block8View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );
    block9View.transform = CGAffineTransformConcat(scaleTrans,
                                                   rotateTrans
                                                   );

}
-(void)updateBlockColours{
    mySingleton *singleton = [mySingleton sharedSingleton];

    currentBlockColour     = singleton.currentBlockColour;
    currentBackgroundColour= singleton.currentBackgroundColour;
    currentShowColour      = singleton.currentShowColour;
    
    self.settingsViewerVIEW.backgroundColor=singleton.currentBackgroundColour;
    
    self.block1View.backgroundColor=currentBlockColour;
    self.block2View.backgroundColor=currentBlockColour;
    self.block3View.backgroundColor=currentBlockColour;
    self.block4View.backgroundColor=currentBlockColour;
    self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=currentBlockColour;
    self.block7View.backgroundColor=currentBlockColour;
    self.block8View.backgroundColor=currentBlockColour;
    self.block9View.backgroundColor=currentBlockColour;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTiming{
    mySingleton *singleton = [mySingleton sharedSingleton];
    blockStartDelayLBL.text=[[NSString alloc]initWithFormat:@"%i",startTime];
    blockShowTimeLBL.text=[[NSString alloc]initWithFormat:@"%i",showTime];
    blockWaitTimeLBL.text=[[NSString alloc]initWithFormat:@"%i",waitTime];
    blockStartDelaySLD.value=startTime;
    blockWaitTimeSLD.value=waitTime;
    blockShowTimeSLD.value=showTime;
}

-(void)updateBlockNumbers{
    mySingleton *singleton = [mySingleton sharedSingleton];
    blockStartNumLBL.text=[[NSString alloc]initWithFormat:@"%i",start];
    blockFinishNumLBL.text=[[NSString alloc]initWithFormat:@"%i",finish];
    blockSizeLBL.text=[[NSString alloc]initWithFormat:@"%i",blockSize];
    
    //set the number of blocks on the biggest valid number
    int blockCount = blockFinishNumLBL.text.intValue;
    switch (blockCount) {
        case 3:
            block1View.hidden=YES;
            block2View.hidden=YES;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=YES;
            block7View.hidden=YES;
            block8View.hidden=YES;
            block9View.hidden=YES;
  
            break;
        case 4:
            block1View.hidden=YES;
            block2View.hidden=YES;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=YES;
            block7View.hidden=NO;
            block8View.hidden=YES;
            block9View.hidden=YES;
  
            break;
        case 5:
            block1View.hidden=NO;
            block2View.hidden=YES;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=YES;
            block7View.hidden=NO;
            block8View.hidden=YES;
            block9View.hidden=YES;

            break;
        case 6:
            block1View.hidden=NO;
            block2View.hidden=YES;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=YES;
            block7View.hidden=NO;
            block8View.hidden=NO;
            block9View.hidden=YES;
   
            break;
        case 7:
            block1View.hidden=NO;
            block2View.hidden=YES;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=NO;
            block7View.hidden=NO;
            block8View.hidden=NO;
            block9View.hidden=YES;
  
            break;
        case 8:
            block1View.hidden=NO;
            block2View.hidden=NO;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=NO;
            block7View.hidden=NO;
            block8View.hidden=NO;
            block9View.hidden=YES;
  
            break;
        case 9:
            block1View.hidden=NO;
            block2View.hidden=NO;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=NO;
            block7View.hidden=NO;
            block8View.hidden=NO;
            block9View.hidden=NO;
    
            break;
        default:
            block1View.hidden=NO;
            block2View.hidden=NO;
            block3View.hidden=NO;
            block4View.hidden=NO;
            block5View.hidden=NO;
            block6View.hidden=NO;
            block7View.hidden=NO;
            block8View.hidden=NO;
            block9View.hidden=NO;

            break;
    }
}

-(void)setRot90{
    //set the blocks to original rotation

    block1View.transform = CGAffineTransformIdentity;
    block2View.transform = CGAffineTransformIdentity;
    block3View.transform = CGAffineTransformIdentity;
    block4View.transform = CGAffineTransformIdentity;
    block5View.transform = CGAffineTransformIdentity;
    block6View.transform = CGAffineTransformIdentity;
    block7View.transform = CGAffineTransformIdentity;
    block8View.transform = CGAffineTransformIdentity;
    block9View.transform = CGAffineTransformIdentity;
}

-(void)setRotAngle{
    mySingleton *singleton = [mySingleton sharedSingleton];
    CGAffineTransform rotateTrans1 = CGAffineTransformMakeRotation(rot1 * M_PI / 180);
    CGAffineTransform rotateTrans2 = CGAffineTransformMakeRotation(rot2 * M_PI / 180);
    CGAffineTransform rotateTrans3 = CGAffineTransformMakeRotation(rot3 * M_PI / 180);
    CGAffineTransform rotateTrans4 = CGAffineTransformMakeRotation(rot4 * M_PI / 180);
    CGAffineTransform rotateTrans5 = CGAffineTransformMakeRotation(rot5 * M_PI / 180);
    CGAffineTransform rotateTrans6 = CGAffineTransformMakeRotation(rot6 * M_PI / 180);
    CGAffineTransform rotateTrans7 = CGAffineTransformMakeRotation(rot7 * M_PI / 180);
    CGAffineTransform rotateTrans8 = CGAffineTransformMakeRotation(rot8 * M_PI / 180);
    CGAffineTransform rotateTrans9 = CGAffineTransformMakeRotation(rot9 * M_PI / 180);
    
    CGAffineTransform scaleTrans =  CGAffineTransformMakeScale(singleton.blockSize/30, singleton.blockSize/30);
    
    block1View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans1);
    block2View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans2);
    block3View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans3);
    block4View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans4);
    block5View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans5);
    block6View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans6);
    block7View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans7);
    block8View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans8);
    block9View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans9);
}

- (IBAction)newRotationAngle:(id)sender {
    rot1=[self randomDegrees359];
    rot2=[self randomDegrees359];
    rot3=[self randomDegrees359];
    rot4=[self randomDegrees359];
    rot5=[self randomDegrees359];
    rot6=[self randomDegrees359];
    rot7=[self randomDegrees359];
    rot8=[self randomDegrees359];
    rot9=[self randomDegrees359];
}

- (IBAction)setDefaults:(id)sender {
    mySingleton *singleton = [mySingleton sharedSingleton];
    [forwardTestSWT setOn:YES animated:YES];
    [onScreenInfoSWT setOn:YES animated:YES];
    [blockRotateSWT setOn:NO animated:YES];
    start=3;
    finish=9;
    blockSize=30;
    
    waitTime=500;
    startTime=2000;
    showTime=500;
    blockStartDelaySLD.value = startTime;
    blockWaitTimeSLD.value   = waitTime;
    blockShowTimeSLD.value   = showTime;
    blockStartDelayLBL.text=[NSString stringWithFormat:@"%i", startTime];
    blockWaitTimeLBL.text=[NSString stringWithFormat:@"%i", waitTime];
    blockShowTimeLBL.text=[NSString stringWithFormat:@"%i", showTime];
    block5View.backgroundColor=[UIColor orangeColor];

    [self BlockBackgroundColourBlaBTN:self];
    [self BlockHighlightColourOraBTN:self];
    [self BlockColourBluBTN:self];
    
    blockSizeLBL.text=[[NSString alloc]initWithFormat:@"%i",blockSize];
    singleton.currentBackgroundColour=[UIColor blackColor];
    singleton.currentBlockColour=[UIColor blueColor];
    singleton.currentShowColour=[UIColor orangeColor];
    //get pos of centres

    [self setRot90];
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];
}

#pragma mark Settings Actions Buttons
- (IBAction)blockStartPlusBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    start++;
    startMinusBTN.alpha=1;
    startPlusBTN.alpha=1;
    if (start>9) {
        start=9;
        startPlusBTN.alpha=0.3;
    }else{
        
        startMinusBTN.alpha=1;
    }
    if (finish<=start) {
        finish=start;
        startPlusBTN.alpha=0.3;
    }
    singleton.start=start;
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];
}
- (IBAction)blockFinishPlusBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    finish++;
    finishMinusBTN.alpha=1;
    finishPlusBTN.alpha=1;
    if (finish>9) {
        finishPlusBTN.alpha=0.3;
        finish=9;
    }else{
        finishMinusBTN.alpha=1;
    }
    if (start>=finish) {
        start=finish;
        finishPlusBTN.alpha=0.3;
    }
    singleton.finish=finish;
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];
}
- (IBAction)blockSizePlusBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    blockSize++;
    sizeMinusBTN.alpha=1;
    sizePlusBTN.alpha=1;
    if (blockSize>55) {
        sizePlusBTN.alpha=0.3;
        blockSize=55;
    }else{
        sizeMinusBTN.alpha=1;
    }
    singleton.blockSize=blockSize;
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];

    
}
- (IBAction)blockStartMinusBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    start--;
    startMinusBTN.alpha=1;
    startPlusBTN.alpha=1;
    if (start<3) {
        startMinusBTN.alpha=0.3;
        start=3;
    }else{
        startPlusBTN.alpha=1;
    }
    if (finish<=start) {
        finish=start;
        startMinusBTN.alpha=0.3;
    }
    singleton.start=start;
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];
}
- (IBAction)blockFinishMinusBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    finish--;
    finishMinusBTN.alpha=1;
    finishPlusBTN.alpha=1;
    if (finish<3) {
        finishMinusBTN.alpha=0.3;
        finish=3;
    }else{
        finishPlusBTN.alpha=1;
    }
    if (start>=finish) {
        finish=start;
        finishMinusBTN.alpha=0.3;
    }
    singleton.finish=finish;
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];
}
- (IBAction)blockSizeMinusBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    blockSize--;
    sizeMinusBTN.alpha=1;
    sizePlusBTN.alpha=1;
    if (blockSize<10) {
        sizeMinusBTN.alpha=0.3;
        blockSize=10;
    }else{
        sizePlusBTN.alpha=1;
    }
    singleton.blockSize=blockSize;
    [self updateSizesOfBlocks];
    [self updateBlockNumbers];
    
}

- (IBAction)forwardTestSWT:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    if(forwardTestSWT.isOn){
        forwardTestDirection=YES;
    }else{
        forwardTestDirection=NO;
    }
}
- (IBAction)onScreenInfoSWT:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    if(onScreenInfoSWT.isOn){
        screenInfoDisplayed=YES;
        
    }else{
        screenInfoDisplayed=NO;
    }
}
- (IBAction)blockRotateSWT:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    if (blockRotateSWT.isOn)
    {
        //arbitary rotate from current position to new position, don't care about absolute angle
            //[self updateSizesOfBlocks];
            [self newRotationAngle:(id)sender];
            [self setRotAngle];
    }else{
            [self setRot90];
            [self updateSizesOfBlocks];
    }
}
//sliders for timings
- (IBAction)blockStartDelaySLD:(UISlider *)sender{
    blockStartDelayLBL.text=[NSString stringWithFormat:@"%d", (int)blockStartDelaySLD.value];
}
- (IBAction)blockWaitTimeSLD:(UISlider *)sender{
    blockWaitTimeLBL.text=[NSString stringWithFormat:@"%d", (int)blockWaitTimeSLD.value];
}
- (IBAction)blockShowTimeSLD:(UISlider *)sender{
    blockShowTimeLBL.text=[NSString stringWithFormat:@"%d", (int)blockShowTimeSLD.value];
}

#pragma mark Block Colours Setting Actions
- (IBAction)BlockColourBlaBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor blackColor];
    self.block2View.backgroundColor=[UIColor blackColor];
    self.block3View.backgroundColor=[UIColor blackColor];
    self.block4View.backgroundColor=[UIColor blackColor];
    self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor blackColor];
    self.block7View.backgroundColor=[UIColor blackColor];
    self.block8View.backgroundColor=[UIColor blackColor];
    self.block9View.backgroundColor=[UIColor blackColor];
    singleton.currentBlockColour=[UIColor blackColor];
}

- (IBAction)BlockColourBluBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor blueColor];
    self.block2View.backgroundColor=[UIColor blueColor];
    self.block3View.backgroundColor=[UIColor blueColor];
    self.block4View.backgroundColor=[UIColor blueColor];
    self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor blueColor];
    self.block7View.backgroundColor=[UIColor blueColor];
    self.block8View.backgroundColor=[UIColor blueColor];
    self.block9View.backgroundColor=[UIColor blueColor];
    singleton.currentBlockColour=[UIColor blueColor];
}

- (IBAction)BlockColourRedBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor redColor];
    self.block2View.backgroundColor=[UIColor redColor];
    self.block3View.backgroundColor=[UIColor redColor];
    self.block4View.backgroundColor=[UIColor redColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor redColor];
    self.block7View.backgroundColor=[UIColor redColor];
    self.block8View.backgroundColor=[UIColor redColor];
    self.block9View.backgroundColor=[UIColor redColor];
    singleton.currentBlockColour=[UIColor redColor];
}
- (IBAction)BlockColourOraBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor orangeColor];
    self.block2View.backgroundColor=[UIColor orangeColor];
    self.block3View.backgroundColor=[UIColor orangeColor];
    self.block4View.backgroundColor=[UIColor orangeColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor orangeColor];
    self.block7View.backgroundColor=[UIColor orangeColor];
    self.block8View.backgroundColor=[UIColor orangeColor];
    self.block9View.backgroundColor=[UIColor orangeColor];
    singleton.currentBlockColour=[UIColor orangeColor];
    
}
- (IBAction)BlockColourGreBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor greenColor];
    self.block2View.backgroundColor=[UIColor greenColor];
    self.block3View.backgroundColor=[UIColor greenColor];
    self.block4View.backgroundColor=[UIColor greenColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor greenColor];
    self.block7View.backgroundColor=[UIColor greenColor];
    self.block8View.backgroundColor=[UIColor greenColor];
    self.block9View.backgroundColor=[UIColor greenColor];
    singleton.currentBlockColour=[UIColor greenColor];
}
- (IBAction)BlockColourYelBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor yellowColor];
    self.block2View.backgroundColor=[UIColor yellowColor];
    self.block3View.backgroundColor=[UIColor yellowColor];
    self.block4View.backgroundColor=[UIColor yellowColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor yellowColor];
    self.block7View.backgroundColor=[UIColor yellowColor];
    self.block8View.backgroundColor=[UIColor yellowColor];
    self.block9View.backgroundColor=[UIColor yellowColor];
    singleton.currentBlockColour=[UIColor yellowColor];
}
- (IBAction)BlockColourMagBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor magentaColor];
    self.block2View.backgroundColor=[UIColor magentaColor];
    self.block3View.backgroundColor=[UIColor magentaColor];
    self.block4View.backgroundColor=[UIColor magentaColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor magentaColor];
    self.block7View.backgroundColor=[UIColor magentaColor];
    self.block8View.backgroundColor=[UIColor magentaColor];
    self.block9View.backgroundColor=[UIColor magentaColor];
    singleton.currentBlockColour=[UIColor magentaColor];
}
- (IBAction)BlockColourGraBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor grayColor];
    self.block2View.backgroundColor=[UIColor grayColor];
    self.block3View.backgroundColor=[UIColor grayColor];
    self.block4View.backgroundColor=[UIColor grayColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor grayColor];
    self.block7View.backgroundColor=[UIColor grayColor];
    self.block8View.backgroundColor=[UIColor grayColor];
    self.block9View.backgroundColor=[UIColor grayColor];
    singleton.currentBlockColour=[UIColor grayColor];
}
- (IBAction)BlockColourWhiBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor whiteColor];
    self.block2View.backgroundColor=[UIColor whiteColor];
    self.block3View.backgroundColor=[UIColor whiteColor];
    self.block4View.backgroundColor=[UIColor whiteColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor whiteColor];
    self.block7View.backgroundColor=[UIColor whiteColor];
    self.block8View.backgroundColor=[UIColor whiteColor];
    self.block9View.backgroundColor=[UIColor whiteColor];
    singleton.currentBlockColour=[UIColor whiteColor];
}
- (IBAction)BlockColourCyaBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.block1View.backgroundColor=[UIColor cyanColor];
    self.block2View.backgroundColor=[UIColor cyanColor];
    self.block3View.backgroundColor=[UIColor cyanColor];
    self.block4View.backgroundColor=[UIColor cyanColor];
        self.block5View.backgroundColor=currentShowColour;
    self.block6View.backgroundColor=[UIColor cyanColor];
    self.block7View.backgroundColor=[UIColor cyanColor];
    self.block8View.backgroundColor=[UIColor cyanColor];
    self.block9View.backgroundColor=[UIColor cyanColor];
    singleton.currentBlockColour=[UIColor cyanColor];
}
#pragma mark Show Highlight Colours Setting Actions
- (IBAction)BlockHighlightColourBlaBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor blackColor];

    singleton.currentShowColour=[UIColor blackColor];
}
- (IBAction)BlockHighlightColourBluBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor blueColor];

    singleton.currentShowColour=[UIColor blueColor];
}
- (IBAction)BlockHighlightColourRedBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor redColor];

    singleton.currentShowColour=[UIColor redColor];
}
- (IBAction)BlockHighlightColourOraBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor orangeColor];

    singleton.currentShowColour=[UIColor orangeColor];
}
- (IBAction)BlockHighlightColourGreBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor greenColor];

    singleton.currentShowColour=[UIColor greenColor];
}
- (IBAction)BlockHighlightColourCyaBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor cyanColor];

    singleton.currentShowColour=[UIColor cyanColor];
}
- (IBAction)BlockHighlightColourYelBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor yellowColor];

    singleton.currentShowColour=[UIColor yellowColor];
}
- (IBAction)BlockHighlightColourWhiBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];

    self.block5View.backgroundColor=[UIColor whiteColor];

    singleton.currentShowColour=[UIColor whiteColor];
}
#pragma mark Background Colours Setting Actions

- (IBAction)BlockBackgroundColourBlaBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor = [UIColor blackColor];
    singleton.currentBackgroundColour=[UIColor blackColor];
}
- (IBAction)BlockBackgroundColourBluBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor=[UIColor blueColor];
    singleton.currentBackgroundColour=[UIColor blueColor];
}
- (IBAction)BlockBackgroundColourRedBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor=[UIColor redColor];
    singleton.currentBackgroundColour=[UIColor redColor];
}
- (IBAction)BlockBackgroundColourOraBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor=[UIColor orangeColor];
    singleton.currentBackgroundColour=[UIColor orangeColor];
}
- (IBAction)BlockBackgroundColourGreBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor=[UIColor greenColor];
    singleton.currentBackgroundColour=[UIColor greenColor];
}
- (IBAction)BlockBackgroundColourCyaBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor=[UIColor cyanColor];
    singleton.currentBackgroundColour=[UIColor cyanColor];
}
- (IBAction)BlockBackgroundColourYelBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor=[UIColor yellowColor];
    singleton.currentBackgroundColour=[UIColor yellowColor];
}
- (IBAction)BlockBackgroundColourWhiBTN:(id)sender{
    mySingleton *singleton = [mySingleton sharedSingleton];
    self.settingsViewerVIEW.backgroundColor=[UIColor whiteColor];
    singleton.currentBackgroundColour=[UIColor whiteColor];
}


-(void)getAKeyPress{
    sleep(2);
}
-(float)randomDegrees359
{
    float degrees = 0;
    degrees = arc4random_uniform(360); //returns a value from 0 to 359, not 360;
    //NSLog(@"Degs=%f",degrees);
    return degrees;
}

-(float)random9
{
    float num = 1;
    for (int r=1; r<+arc4random_uniform(321); r++)
    {
        while (num>0)
        {
            num = arc4random_uniform(10); //1-9
        }
    }
    return num;
}

-(int)randomPt
{
    float split1=0;
    if (arc4random_uniform(11)>5.5)
    {
        split1=-1;
    }
    else
    {
        split1=1;
    }
    int posrand=0;
    posrand=(int)arc4random_uniform(60)*split1;
    return posrand;
}




@end