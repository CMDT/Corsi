//
//  settingsVCViewController.m
//  Corsi
//
//  Created by Jon Howell on 04/09/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//
//  Minor updates and re-build for distro 2/11/15 jah
//  Minor updates and re-build for distro 9/9/16 jah
// NB. *** on new version, set detials in defaults function

#import "settingsVC.h"
#import "mySingleton.h"
#import "resultsVC.h"

#define kEmail      @"emailAddress"
#define kTester     @"testerName"
#define kSubject    @"subjectName"

#define kStart      @"startBlocks"
#define kFinish     @"finishBlocks"
#define kSize       @"blockSize"

#define kForward    @"forwardTestEnabled"
#define kInfo       @"infoEnabled"
#define kRot        @"rotationEnabled"
#define kAnimals    @"animalsEnabled"
#define kSounds     @"soundsEnabled"
#define kBeep       @"beepName"

#define kBlockCol   @"blockColour"
#define kShowCol    @"highlightColour"
#define kBackCol    @"backgroundColour"

#define kDelay      @"blockDelay"
#define kTime       @"blockTime"
#define kShow       @"blockShow"

#define kVersion0    @"version0"
#define kVersion1    @"version1"
#define kVersion2    @"version2"
#define kVersion3    @"version3"

@interface settingsVC ()

@end

@implementation settingsVC
{
    int angle[10];
    int start;
    int finish;
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
    
    float blockSize;
    
    BOOL forward;
    BOOL info;
    BOOL rotation;
    BOOL animals;
    BOOL sounds;
    
    NSString * blockCol;
    NSString * showCol;
    NSString * backCol;
    NSString * beepName;
    NSString * subjectName;
    NSString * email;
    NSString * testerName;
    
    //for plist version group
    NSString * version0; //version number
    NSString * version1; //copyright info
    NSString * version2; //author info
    NSString * version3; //web site info

    CGPoint blk1pos;
    CGPoint blk2pos;
    CGPoint blk3pos;
    CGPoint blk4pos;
    CGPoint blk5pos;
    CGPoint blk6pos;
    CGPoint blk7pos;
    CGPoint blk8pos;
    CGPoint blk9pos;
    
    UIColor * currentBlockColour;
    UIColor * currentShowColour;
    UIColor * currentBackgroundColour;
}

@synthesize
    showLBL,
    blockLBL,
    canvasLBL,
    block1View,
    block2View,
    block3View,
    block4View,
    block5View,
    block6View,
    block7View,
    block8View,
    block9View,
    settingsViewerVIEW,
    blockSizeLBL,
    blockFinishNumLBL,
    blockStartNumLBL,
    blockShowLBL,
    blockStartLBL,
    blockWaitLBL,
    forwardLBL,
    infoLBL,
    soundsLBL,
    settingsVC,
    testerLBL,
    emailLBL;
//subjectLBL;//re instate if work out way to fit on screen space


//-(id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        UIImage *tabIn  = [UIImage imageNamed:@"settings"];
//        UIImage *tabOut = [UIImage imageNamed:@"settings"];
//        UITabBarItem *tabBarItem = [self tabBarItem];
//        [tabBarItem initWithTitle:@"Settings" image:tabIn tag:0];
//    }
//    return self;
//}

-(void)awakeFromNib{
    [super awakeFromNib];
    UIImage *settingsImage          = [UIImage imageNamed:@"settings"];
    UIImage *settingsImageSel       = [UIImage imageNamed:@"settings"];
    //settingsImage       = [settingsImage    imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //settingsImageSel    = [settingsImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:settingsImage selectedImage: settingsImageSel];
}

-(void)viewWillAppear:(BOOL)animated{
   self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    mySingleton *singleton = [mySingleton sharedSingleton];

    NSString * pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString * settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString * defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary * defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults         = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];

    singleton.testerName             = [defaults  objectForKey:kTester];
    singleton.subjectName            = [defaults  objectForKey:kSubject];
    singleton.email                  = [defaults  objectForKey:kEmail];

    emailLBL.text   = singleton.email;
    testerLBL.text  = singleton.testerName;
    //subjectLBL.text  = singleton.subjectName;//not shown in view controller at present

    [showLBL setBackgroundColor:   singleton.currentShowColour];
    [block5View setBackgroundColor:singleton.currentShowColour];
    [blockLBL setBackgroundColor:  singleton.currentBlockColour];

    [block1View setBackgroundColor:singleton.currentBlockColour];
    [block2View setBackgroundColor:singleton.currentBlockColour];
    [block3View setBackgroundColor:singleton.currentBlockColour];
    [block4View setBackgroundColor:singleton.currentBlockColour];
    [block6View setBackgroundColor:singleton.currentBlockColour];
    [block7View setBackgroundColor:singleton.currentBlockColour];
    [block8View setBackgroundColor:singleton.currentBlockColour];
    [block9View setBackgroundColor:singleton.currentBlockColour];
    
    [canvasLBL setBackgroundColor: singleton.currentBackgroundColour];
    [settingsViewerVIEW setBackgroundColor:singleton.currentBackgroundColour];
    
    //forward or revers test flag
    if(singleton.forwardTestDirection == YES){
        forwardLBL.text=@"Forward";
    } else {
        forwardLBL.text=@"Reverse";
    }
    
    //on screen info during tests flag
    if(singleton.onScreenInfo==YES){
        infoLBL.text=@"Info.";
    } else {
        infoLBL.text=@"No Info";
    }
    
    //sounds flag
    if(singleton.sounds==YES){
        soundsLBL.text=@"Sounds";
        beepName=singleton.beepEffect;
        [self effectPicker:beepName];
    } else {
        soundsLBL.text=@"Quiet";
    }
    
    [self effectPicker:beepName];
    
    //start, finish and sizes on screen from singleton
    blockStartNumLBL.text   = [NSString stringWithFormat:@"%d",    singleton.start];
    blockFinishNumLBL.text  = [NSString stringWithFormat:@"%d",    singleton.finish];
    blockSizeLBL.text       = [NSString stringWithFormat:@"%.0f",  singleton.blockSize];

    startTime = singleton.startTime;
    waitTime  = singleton.waitTime;
    showTime  = singleton.showTime;

    blockStartLBL.textAlignment = NSTextAlignmentCenter;
    blockShowLBL.textAlignment  = NSTextAlignmentCenter;
    blockWaitLBL.textAlignment  = NSTextAlignmentCenter;

    blockStartLBL.text = [[NSString alloc]initWithFormat:@"%i", startTime];
    blockShowLBL.text  = [[NSString alloc]initWithFormat:@"%i", showTime];
    blockWaitLBL.text  = [[NSString alloc]initWithFormat:@"%i", waitTime];

    testerLBL.text=singleton.testerName;
    emailLBL.text=singleton.email;
    
    [self putBlocksInPlace];
    
    //self.tabBarController.tabBar.hidden = NO;
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDefaults{
    mySingleton *singleton = [mySingleton sharedSingleton];
    //set up the plist params
        NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
        NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
        NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
        NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
        NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];

    //read the user defaults from the iPhone/iPad bundle
    // if any are set to nil (no value on first run), put a temporary one in
    
//*************************************************************
//version, set anyway *****************************************
//*************************************************************
        version0 =  @"v1.3.4 - 11.1.17";              // version   *** keep short
        version1 =  @"MMU (c) 2017";               // copyright *** limited line space
        version2 =  @"j.a.howell@mmu.ac.uk";       // author    *** to display on device
        version3 =  @"http://www.ess.mmu.ac.uk";   // web site  *** settings screen
//*************************************************************************************** check web site address as not working at present
//*************************************************************
        [defaults setObject:version0 forKey:kVersion0];   //***
        [defaults setObject:version1 forKey:kVersion1];   //***
        [defaults setObject:version2 forKey:kVersion2];   //***
        [defaults setObject:version3 forKey:kVersion3];   //***
//*************************************************************
//version set end *********************************************
//*************************************************************

//block colour
    currentBlockColour     = [defaults objectForKey:kBlockCol];
    if(currentBlockColour  == nil ){
        currentBlockColour =  [UIColor darkGrayColor];
        blockCol =@"Dark Gray";
        [defaults setObject:@"Dark Gray" forKey:kBlockCol];
    }
//background colour
    currentBackgroundColour     = [defaults objectForKey:kBackCol];
    if(currentBackgroundColour  == nil ){
        currentBackgroundColour =  [UIColor blackColor];
        backCol =@"Black";
        [defaults setObject:@"Black" forKey:kBackCol];
    }
//show colour
    currentShowColour     = [defaults objectForKey:kShowCol];
    if(currentShowColour  == nil ){
        currentShowColour =  [UIColor yellowColor];
        showCol =@"Yellow";
        [defaults setObject:@"Yellow" forKey:kShowCol];
    }
//subject name
    subjectName     = [defaults objectForKey:kSubject];
    if(subjectName  == nil ){
        subjectName =  @"Par";
        [defaults setObject:@"Par" forKey:kSubject];
    }
//tester name
    testerName     = [defaults objectForKey:kTester];
    if(testerName  == nil ){
        testerName =  @"Me";
        [defaults setObject:@"Me" forKey:kTester];
    }
//email name
    email     = [defaults objectForKey:kEmail];
    if(email  == nil ){
        email =  @"me@test.com";
        [defaults setObject:@"me@test.com" forKey:kEmail];
    }
//beep Effect Name
    beepName     = [defaults objectForKey:kBeep];
    if(beepName  == nil ){
        beepName =  @"BEEPJAZZ";
        singleton.segIndex = 5;
        [defaults setObject:@"BEEPJAZZ" forKey:kBeep];
    }
//start block
    NSString *temp = [defaults objectForKey:kStart];
    if( temp == nil ){
        start =  3;
        [defaults setInteger:start forKey:kStart];
    }
//finish block
    temp        = [defaults objectForKey:kFinish];
    if( temp == nil ){
        finish =  9;
        [defaults setInteger:finish forKey:kFinish];
    }
    //block size
    temp        = [defaults objectForKey:kSize];
    if( temp == nil ){
        blockSize =  45.00;
        [defaults setInteger:blockSize forKey:kSize];
    }
//wait time
    temp        = [defaults objectForKey:kDelay];
    if( temp == nil ){
        waitTime=  1500;
        [defaults setInteger:waitTime forKey:kDelay];
    }
//show time
    temp        = [defaults objectForKey:kShow];
    if( temp == nil ){
        showTime =  1500;
        [defaults setInteger:showTime forKey:kShow];
    }
//start time
    temp        = [defaults objectForKey:kTime];
    if( temp == nil ){
        startTime =  1500;
        [defaults setInteger:startTime forKey:kTime];
    }
//set rotate
    temp        = [defaults objectForKey:kRot];
    if( temp == nil ){
        rotation =  YES;
        [defaults setBool:YES forKey:kRot];
    }
//set animals
    temp        = [defaults objectForKey:kAnimals];
    if( temp == nil ){
        animals =  NO;
        [defaults setBool:NO forKey:kAnimals];
    }
//set sounds
    temp        = [defaults objectForKey:kSounds];
    if( temp == nil ){
        sounds =  YES;
        [defaults setBool:YES forKey:kSounds];
    }
//set status messages
    temp        = [defaults objectForKey:kInfo];
    if( temp == nil ){
        info =  YES;
        [defaults setBool:YES forKey:kInfo];
    }
//set forward/reverse
    temp        = [defaults objectForKey:kForward];
    if( temp == nil ){
        forward =  YES;
        [defaults setBool:YES forKey:kForward];
    }

    
}

-(UIColor*)colourPicker:(NSString*)colourName{
    UIColor *colourUIName;
    //make an array of colour names
    NSArray *items = @[
                       @"Black", @"Blue", @"Green", @"Red", @"Cyan",
                       @"White", @"Yellow", @"Magenta", @"Gray",
                       @"Orange", @"Brown", @"Purple",
                       @"Dark Gray", @"Light Gray"
                       ];
    //find the index value of each
    long item = [items indexOfObject: colourName];

    //select the item number
    switch (item) {
        case 0:
            // Item 1
            colourUIName = [UIColor blackColor];
            break;
        case 1:
            // Item 2
            colourUIName = [UIColor blueColor];
            break;
        case 2:
            // Item 3
            colourUIName = [UIColor greenColor];
            break;
        case 3:
            // Item 4
            colourUIName = [UIColor redColor];
            break;
        case 4:
            // Item 5
            colourUIName = [UIColor cyanColor];
            break;
        case 5:
            // Item 6
            colourUIName = [UIColor whiteColor];
            break;
        case 6:
            // Item 7
            colourUIName = [UIColor yellowColor];
            break;
        case 7:
            // Item 8
            colourUIName = [UIColor magentaColor];
            break;
        case 8:
            // Item 9
            colourUIName = [UIColor grayColor];
            break;
        case 9:
            // Item 10
            colourUIName = [UIColor orangeColor];
            break;
        case 10:
            // Item 11
            colourUIName = [UIColor brownColor];
            break;
        case 11:
            // Item 12
            colourUIName = [UIColor purpleColor];
            break;
        case 12:
            // Item 13
            colourUIName = [UIColor darkGrayColor];
            break;
        case 13:
            // Item 14
            colourUIName = [UIColor lightGrayColor];
            break;
        default:
            colourUIName = [UIColor yellowColor];
            break;
    }
    return colourUIName;
}

-(NSString*)effectPicker:(NSString*)effectName{
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSString *effectName1;
    //make an array of colour names
    NSArray *items = @[
         @"KLICK", @"BEEPPURE",
         @"BEEP_FM", @"BEEPDOUB",
         @"AMFMBEEP", @"BEEPJAZZ"
         ];
    //find the index value of each
    long item = [items indexOfObject: effectName];
    
    //select the item number
    switch (item) {
        case 0:
            // Item 1
            effectName1 = @"KLICK";
            singleton.segIndex = 0;
            break;
        case 1:
            // Item 2
            effectName1 = @"BEEPPURE";
            singleton.segIndex = 1;
            break;
        case 2:
            // Item 3
            effectName1 = @"BEEP_FM";
            singleton.segIndex = 2;
            break;
        case 3:
            // Item 4
            effectName1 = @"BEEPDOUB";
            singleton.segIndex = 3;
            break;
        case 4:
            // Item 5
            effectName1 = @"AMFMBEEP";
            singleton.segIndex = 4;
            break;
        case 5:
            // Item 6
            effectName1 = @"BEEPJAZZ";
            singleton.segIndex = 5;
            break;

        default:
            effectName1 = @"BEEPJAZZ";
            singleton.segIndex = 5;
            break;
    }
    return effectName1;
}

-(NSString*)colourUIToString:(UIColor*)myUIColour{
    NSString * myColour;
    
    //make an array of colour names
    NSArray *items = @[
        [UIColor blackColor],
        [UIColor blueColor],
        [UIColor greenColor],
        [UIColor redColor],
        [UIColor cyanColor],
        [UIColor whiteColor],
        [UIColor yellowColor],
        [UIColor magentaColor],
        [UIColor grayColor],
        [UIColor orangeColor],
        [UIColor brownColor],
        [UIColor purpleColor],
        [UIColor darkGrayColor],
        [UIColor lightGrayColor]
        ];
    //find the index value of each
    long item = [items indexOfObject: myUIColour];
    
    //select the item number
    switch (item) {
        case 0:
            // Item 1
            myColour = @"Black";
            break;
        case 1:
            // Item 2
            myColour = @"Blue";
            break;
        case 2:
            // Item 3
            myColour = @"Green";
            break;
        case 3:
            // Item 4
            myColour = @"Red";
            break;
        case 4:
            // Item 5
            myColour = @"Cyan";
            break;
        case 5:
            // Item 6
            myColour = @"White";
            break;
        case 6:
            // Item 7
            myColour = @"Yellow";
            break;
        case 7:
            // Item 8
            myColour = @"Magenta";
            break;
        case 8:
            // Item 9
            myColour = @"Gray";
            break;
        case 9:
            // Item 10
            myColour = @"Orange";
            break;
        case 10:
            // Item 11
            myColour = @"Brown";
            break;
        case 11:
            // Item 12
            myColour = @"Purple";
            break;
        case 12:
            // Item 13
            myColour = @"Dark Gray";
            break;
        case 13:
            // Item 14
            myColour = @"Light Gray";
            break;
        default:
            myColour = @"Yellow";
            break;
    }
    return myColour;
}

-(IBAction)saveSettings:(id)sender{

    mySingleton *singleton   = [mySingleton sharedSingleton];

    NSURL *defaultPrefsFile  = [[NSBundle mainBundle]
                               URLForResource:@"Root" withExtension:@"plist"];
    NSDictionary *defaults1  = [NSDictionary dictionaryWithContentsOfURL:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults1];
    //
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    //read the user defaults from the iPhone/iPad bundle
    // if any are set to nil (no value on first run), put a temporary one in
    //NSLog(@"Saving settings to singleton...");
    
    //block colour
        [defaults setObject:[self colourUIToString:singleton.currentBlockColour] forKey:kBlockCol];

    //background colour
        [defaults setObject:[self colourUIToString:singleton.currentBackgroundColour] forKey:kBackCol];

    //show colour
        [defaults setObject:[self colourUIToString:singleton.currentShowColour] forKey:kShowCol];
    
    //sounds
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.beepEffect] forKey:kBeep];
    
    //others
        [defaults setObject:[NSString stringWithFormat:@"%d", singleton.start] forKey:kStart];
        [defaults setObject:[NSString stringWithFormat:@"%d", singleton.finish] forKey:kFinish];
        [defaults setObject:[NSString stringWithFormat:@"%.0f", singleton.blockSize] forKey:kSize];
        [defaults setObject:[NSString stringWithFormat:@"%.0f", singleton.startTime] forKey:kDelay];
        [defaults setObject:[NSString stringWithFormat:@"%.0f", singleton.showTime] forKey:kShow];
        [defaults setObject:[NSString stringWithFormat:@"%.0f", singleton.waitTime] forKey:kTime];
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.beepEffect] forKey:kBeep];
        [defaults setBool:singleton.blockRotation forKey:kRot];
        [defaults setBool:singleton.animals forKey:kAnimals];
        [defaults setBool:singleton.sounds forKey:kSounds];
        [defaults setBool:singleton.onScreenInfo forKey:kInfo];
        [defaults setBool:singleton.forwardTestDirection forKey:kForward];
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.subjectName] forKey:kSubject];
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.email] forKey:kEmail];
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.testerName] forKey:kTester];
        [defaults synchronize];//make sure all are updated
    /*
    // Alerts changed in ios9
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"CORSI TEST SETTINGS"
                                                     message:@"\nThe settings were \n\n'SAVED' \n\nfor the tests.\n\nYou can recall these with \n'Load' on this screen."
                                                    delegate:self
                                           cancelButtonTitle:nil //@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    
    [alert show]; 
    */
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"CORSI TEST SETTINGS"
                                  message:@"\nThe settings were \n\n'SAVED' \n\nfor the tests.\n\nYou can recall these with \n'Load' on this screen."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelButtonTitle = [UIAlertAction
                                actionWithTitle:@"OK, continue"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                //Handel your yes please button action here
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                                }];
    
    /*
     //yes/no type messages in alert
     UIAlertAction * yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                //Handel your yes please button action here
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                                }];
    */
    /* 
     //for extra button if wanted
     UIAlertAction * noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                               [alert dismissViewControllerAnimated:YES completion:nil];
                               
                               }]; */
    [alert addAction:cancelButtonTitle];
    
    //[alert addAction:yesButton];
    //[alert addAction:noButton]; //for extra button if wanted
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction)loadSettings:(id)sender{
//load from the plist, or put in a default if missing
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    NSURL *defaultPrefsFile     = [[NSBundle mainBundle]
                                   URLForResource:@"Root" withExtension:@"plist"];
    
    NSDictionary *defaultPrefs  = [NSDictionary dictionaryWithContentsOfURL:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];

    [defaults synchronize];
    
//read the user defaults from the iPhone/iPad bundle
    // if any are set to nil (no value on first run), put a temporary one in
 
    [self setDefaults];
//block colour  
    currentBlockColour      = [self colourPicker:[defaults objectForKey:kBlockCol]];
    
//background colour
    currentBackgroundColour = [self colourPicker:[defaults objectForKey:kBackCol]];

//show colour
    currentShowColour       = [self colourPicker:[defaults objectForKey:kShowCol]];
    
//everything else
    singleton.testerName              = [defaults  objectForKey:kTester];
    singleton.subjectName             = [defaults  objectForKey:kSubject];
    singleton.email                   = [defaults  objectForKey:kEmail];
    singleton.start                   = [[defaults objectForKey:kStart] doubleValue];
    singleton.finish                  = [[defaults objectForKey:kFinish] doubleValue];
    singleton.blockSize               = [[defaults objectForKey:kSize] doubleValue];
    singleton.forwardTestDirection    = [defaults  boolForKey:kForward];
    singleton.onScreenInfo            = [defaults  boolForKey:kInfo];
    singleton.blockRotation           = [defaults  boolForKey:kRot];
    singleton.animals                 = [defaults  boolForKey:kAnimals];
    singleton.sounds                  = [defaults  boolForKey:kSounds];
    singleton.beepEffect              = [defaults  objectForKey:kBeep];
    [self effectPicker:singleton.beepEffect];
    
    singleton.currentBlockColour      = currentBlockColour;
    singleton.currentShowColour       = currentShowColour;
    singleton.currentBackgroundColour = currentBackgroundColour;
    singleton.startTime               = [[defaults objectForKey:kDelay] doubleValue];
    singleton.waitTime                = [[defaults objectForKey:kTime] doubleValue];
    singleton.showTime                = [[defaults objectForKey:kShow] doubleValue];
    
    //singleton.version             = [defaults objectForKey:kVersion];

    [defaults synchronize];
    [self refreshView];

    /*
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"CORSI TEST SETTINGS"
                                                     message:@"\nThe settings were \n\n'LOADED' \n\nfor the tests."
                                                    delegate:self
                                           cancelButtonTitle:nil //@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];*/


UIAlertController * alert =  [UIAlertController
                              alertControllerWithTitle:@"CORSI TEST SETTINGS"
                              message:@"The settings were \n\n'LOADED' \n\nfor the tests."
                              preferredStyle:UIAlertControllerStyleAlert];


UIAlertAction * cancelButtonTitle = [UIAlertAction
                                     actionWithTitle:@"OK, continue"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                     //Handle your yes please button action here
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     }];

    [alert addAction:cancelButtonTitle];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(float)randomDegrees359
//for spinning the blocks if rotation is set to YES
{
    float degrees = 0;
    degrees = arc4random_uniform(359); //was 359 //returns a value from 0 to 359, not 360;

    //NSLog(@"Degs=%f",degrees);
    return degrees;
}

-(void)putBlocksInPlace{
    //draw the blocks
    [self putAnimals];

    mySingleton *singleton = [mySingleton sharedSingleton];

    float blockSize1 = singleton.blockSize;
    blockSize1 = blockSize1 / 60; // 55.00; //size picked against max size allowed here
    if( blockSize1 <= 0.2){
        blockSize1 = 0.2;
    }
    if( blockSize1 >= 1){
        blockSize1 = 1;
    }

    float scaleFactor = blockSize1;

    if(singleton.blockRotation){
        for (int t = 0; t < 10; t++) {
            angle[t] = self.randomDegrees359;
        }
    } else {
        for (int t = 0; t < 10; t++) {
            angle[t] = 0;
        }
    }

    //UITouch *touch = [touches anyObject];//some old example code if you used a touch rather than an image reference
    //make sure rotation is about the centre axis. 0,0 is bot left, .5,.5 is ctr, 1,1 is top rt, 1,.5 is mid right.
    block1View.layer.anchorPoint = CGPointMake(.5,.5);
    block2View.layer.anchorPoint = CGPointMake(.5,.5);
    block3View.layer.anchorPoint = CGPointMake(.5,.5);
    block4View.layer.anchorPoint = CGPointMake(.5,.5);
    block5View.layer.anchorPoint = CGPointMake(.5,.5);
    block6View.layer.anchorPoint = CGPointMake(.5,.5);
    block7View.layer.anchorPoint = CGPointMake(.5,.5);
    block8View.layer.anchorPoint = CGPointMake(.5,.5);
    block9View.layer.anchorPoint = CGPointMake(.5,.5);

    [UIView animateWithDuration:1.0
               delay:0.0
             options:UIViewAnimationOptionCurveEaseInOut

      animations:^{

          CGAffineTransform scaleTrans = CGAffineTransformMakeScale(scaleFactor, scaleFactor);

          CGAffineTransform rotateTrans1 = CGAffineTransformMakeRotation(angle[1] * M_PI / 180);
          CGAffineTransform rotateTrans2 = CGAffineTransformMakeRotation(angle[2] * M_PI / 180);
          CGAffineTransform rotateTrans3 = CGAffineTransformMakeRotation(angle[3] * M_PI / 180);
          CGAffineTransform rotateTrans4 = CGAffineTransformMakeRotation(angle[4] * M_PI / 180);
          CGAffineTransform rotateTrans5 = CGAffineTransformMakeRotation(angle[5] * M_PI / 180);
          CGAffineTransform rotateTrans6 = CGAffineTransformMakeRotation(angle[6] * M_PI / 180);
          CGAffineTransform rotateTrans7 = CGAffineTransformMakeRotation(angle[7] * M_PI / 180);
          CGAffineTransform rotateTrans8 = CGAffineTransformMakeRotation(angle[8] * M_PI / 180);
          CGAffineTransform rotateTrans9 = CGAffineTransformMakeRotation(angle[9] * M_PI / 180);

          block1View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans1);
          block2View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans2);
          block3View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans3);
          block4View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans4);
          block5View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans5);
          block6View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans6);
          block7View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans7);
          block8View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans8);
          block9View.transform = CGAffineTransformConcat(scaleTrans, rotateTrans9);
      }completion:nil];
}

-(int)random22
{
    //a random number between 1 and 21 for animal pictures
    int num1 = 1;
    num1 = arc4random_uniform(22); //1-21
    if (num1<1) {
        num1=1;
    }
    if (num1>21) {
        num1=21;
    }
    return num1;
}

-(void)putAnimals{
    //place the animal pictures
    mySingleton *singleton = [mySingleton sharedSingleton];

    if (singleton.animals) {
        //draw an animal picture in the view
        int ani[22];
        //NSLog(@"start");
        for (int b=0; b<22; b++) {
            ani[b]=b;
        }
        int temp=0;
        int tt=0;
        for (int b=0; b<2541; b++) {
            tt=[self random22];
            temp=ani[tt-1];
            ani[tt-1]=ani[tt];
            ani[tt]=temp;
        }
        block1View.image = [self getAnimal:ani[1]];
        block2View.image = [self getAnimal:ani[3]];
        block3View.image = [self getAnimal:ani[5]];
        block4View.image = [self getAnimal:ani[7]];
        block5View.image = [self getAnimal:ani[8]];
        block6View.image = [self getAnimal:ani[0]];
        block7View.image = [self getAnimal:ani[2]];
        block8View.image = [self getAnimal:ani[4]];
        block9View.image = [self getAnimal:ani[6]];
    }
}

-(UIImage*)getAnimal:(int)animalNo{
    //pick an animal and return its image
    UIImage *animal;
    switch (animalNo) {
        case 1:
            animal = [UIImage imageNamed:@"Elephant"];
            break;
        case 2:
            animal = [UIImage imageNamed:@"Donkey"];
            break;
        case 3:
            animal = [UIImage imageNamed:@"Frog"];
            break;
        case 4:
            animal = [UIImage imageNamed:@"Fox"];
            break;
        case 5:
            animal = [UIImage imageNamed:@"Goat"];
            break;
        case 6:
            animal = [UIImage imageNamed:@"Crab"];
            break;
        case 7:
            animal = [UIImage imageNamed:@"Bear"];
            break;
        case 8:
            animal = [UIImage imageNamed:@"Bird"];
            break;
        case 9:
            animal = [UIImage imageNamed:@"Duck"];
            break;
        case 10:
            animal = [UIImage imageNamed:@"Croc"];
            break;
        case 11:
            animal = [UIImage imageNamed:@"Cow"];
            break;
        case 12:
            animal = [UIImage imageNamed:@"Butterfly"];
            break;
        case 13:
            animal = [UIImage imageNamed:@"Lion"];
            break;
        case 14:
            animal = [UIImage imageNamed:@"Lama"];
            break;
        case 15:
            animal = [UIImage imageNamed:@"Penguin"];
            break;
        case 16:
            animal = [UIImage imageNamed:@"Fish"];
            break;
        case 17:
            animal = [UIImage imageNamed:@"Seal"];
            break;
        case 18:
            animal = [UIImage imageNamed:@"Tortoise"];
            break;
        case 19:
            animal = [UIImage imageNamed:@"Rabbit"];
            break;
        case 20:
            animal = [UIImage imageNamed:@"Pig"];
            break;
        case 21:
            animal = [UIImage imageNamed:@"Squirel"];
            break;
        default:
            animal = [UIImage imageNamed:@"Cat"];
            break;
    }
    return animal;
}

-(void)refreshView {
    //make the colours change as now changed
    [self viewDidLoad];
    [self viewDidAppear:YES]; // If viewWillAppear also contains code
}

@end
