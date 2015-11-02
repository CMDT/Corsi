//
//  testVC.h
//  Corsi
//
//  Created by Jon Howell on 04/09/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  Minor updates and re-build for distro 2/11/15 jah
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface testVC : UIViewController{
    SystemSoundID mySoundEffect;
    AVAudioPlayer *backgroundMusicPlayer;
    BOOL backIsStarted;
}

@property (nonatomic, copy) NSDate * startDate;

@property (nonatomic, retain) AVAudioPlayer        * backgroundMusicPlayer;
@property (retain, nonatomic) IBOutlet UILabel     * headingLBL;
@property (retain, nonatomic) IBOutlet UITextView  * statusMessageTXT;
@property (retain, nonatomic) IBOutlet UIImageView * MessageView;
@property (retain, nonatomic) IBOutlet UITextView  * MessageTextView;

//labels for the stages, hide if not needed
@property (retain, nonatomic) IBOutlet UILabel  * blkLBL;
@property (retain, nonatomic) IBOutlet UILabel  * blkNoLBL;
@property (retain, nonatomic) IBOutlet UILabel  * blkOfLBL;
@property (retain, nonatomic) IBOutlet UILabel  * blkTotalLBL;

//labels for the stages if needed, hide if not
@property (retain, nonatomic) IBOutlet UILabel  * setLBL;
@property (retain, nonatomic) IBOutlet UILabel  * setNoLBL;
@property (retain, nonatomic) IBOutlet UILabel  * setOfLBL;
@property (retain, nonatomic) IBOutlet UILabel  * setTotalLBL;

//buttons over images
@property (strong, nonatomic) IBOutlet UIButton * box1BTN;
@property (strong, nonatomic) IBOutlet UIButton * box2BTN;
@property (strong, nonatomic) IBOutlet UIButton * box3BTN;
@property (strong, nonatomic) IBOutlet UIButton * box4BTN;
@property (strong, nonatomic) IBOutlet UIButton * box5BTN;
@property (strong, nonatomic) IBOutlet UIButton * box6BTN;
@property (strong, nonatomic) IBOutlet UIButton * box7BTN;
@property (strong, nonatomic) IBOutlet UIButton * box8BTN;
@property (strong, nonatomic) IBOutlet UIButton * box9BTN;

//buttons for control
@property (strong, nonatomic) IBOutlet UIButton * startBTN;
@property (retain, nonatomic) IBOutlet UIButton * stopTestNowBTN;

//images for the boxes
@property (strong, nonatomic) IBOutlet UIImageView   * box1image;
@property (strong, nonatomic) IBOutlet UIImageView   * box2image;
@property (strong, nonatomic) IBOutlet UIImageView   * box3image;
@property (strong, nonatomic) IBOutlet UIImageView   * box4image;
@property (strong, nonatomic) IBOutlet UIImageView   * box5image;
@property (strong, nonatomic) IBOutlet UIImageView   * box6image;
@property (strong, nonatomic) IBOutlet UIImageView   * box7image;
@property (strong, nonatomic) IBOutlet UIImageView   * box8image;
@property (strong, nonatomic) IBOutlet UIImageView   * box9image;

@property (strong, nonatomic) IBOutlet UIView  * testViewerView;

@property (nonatomic) float scaleFactor;

-(IBAction)startTest:(id)sender;
-(IBAction)stopTestNow:(id)sender;

-(IBAction)blk1BUT:(id)sender;
-(IBAction)blk2BUT:(id)sender;
-(IBAction)blk3BUT:(id)sender;
-(IBAction)blk4BUT:(id)sender;
-(IBAction)blk5BUT:(id)sender;
-(IBAction)blk6BUT:(id)sender;
-(IBAction)blk7BUT:(id)sender;
-(IBAction)blk8BUT:(id)sender;
-(IBAction)blk9BUT:(id)sender;

-(float) delayDelay;
-(float) delayWait;
-(float) delayShow;
-(float) random9;

-(UIImage*)getAnimal:(int)animalNo;

-(NSString*)getCurrentDate;
-(NSString*)getCurrentTime;
-(NSString*) make9order;
-(NSString*) rev9Order:(NSString*)forOrder;

-(int) random22;
-(int) whichBlock: (int) number :(int) stage;

-(void)allButtonsBackgroundReset;
-(void)box1;
-(void)jumpToResultsView;
-(void)but1;
-(void)nextStageMSG;
-(void)stageEndMSG;
-(void)endTestMSG;
-(void)startTestMSG;
-(void)calculatingMSG;
-(void)blankMSG;
-(void)blankMSG2;
-(void)blankMSG3;
-(void)buttonsEnable;
-(void)buttonsDisable;
-(int)randomPt;
-(void)setColours;
-(void)display_blocks;
-(void)hide_blocks;
-(void)showInfo;
-(void)hideInfo;
-(void)putAnimals;
-(void)startStop;
-(void)setVolumeValue;
-(void)playMyEffect;
-(void)halt;
-(void)finalHalt;
-(void)haltPart2;
-(void)finalHaltPart2;
-(void)animateMessageViewOUT2:(float)dur;
-(void)animateMessageViewIN2:(float)dur;
-(void)animateMessageView;
-(void)animateMessageViewOUT;
-(void)animateMessageViewIN;

@end
