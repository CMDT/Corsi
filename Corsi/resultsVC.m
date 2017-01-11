//
//  resultsVC.m
//  Corsi
//
//  Created by Jon Howell on 04/09/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  Minor updates and re-build for distro 2/11/15 jah
//  Minor updates and re-build for distro 9/9/16 jah
//

#import "resultsVC.h"
#import "mySingleton.h"

#define kSubject  @"subjectName"

@interface resultsVC ()

@end

@implementation resultsVC{
    //IBOutlet UITextView *resultsViewBorder;
    NSString * resultsTempString;
    UILabel  * titleLab;    //title
    UILabel  * resultLab;   //result
}

@synthesize
    resultsTxtView,
    testDate,
    startDate,
    fileMgr,
    homeDir,
    filename,
    filepath,
    emailBTN,
    tableView,
    heading,
    arrItems //  temp array of itmes for results display
;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//-(id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        UIImage *tabIn  = [UIImage imageNamed:@"results"];
//        UIImage *tabOut = [UIImage imageNamed:@"results"];
//        UITabBarItem *tabBarItem = [self tabBarItem];
//        [tabBarItem initWithTitle:@"results" image:tabIn tag:0];
//    }
//    return self;
//}
-(void)awakeFromNib{
    [super awakeFromNib];
    UIImage *resultsImage      = [UIImage imageNamed:@"results"];
    UIImage *resultsImageSel   = [UIImage imageNamed:@"results"];
    //resultsImage               = [resultsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //resultsImageSel            = [resultsImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tabBarItem            = [[UITabBarItem alloc] initWithTitle:@"Results" image:resultsImage selectedImage: resultsImageSel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    heading.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    mySingleton *singleton = [mySingleton sharedSingleton];
    
//hide and show data and titles according to if data present
    tableView.hidden      = YES;
    emailBTN.hidden       = YES;
    resultsTxtView.hidden = NO;
    heading.hidden        = NO;
    
    if(singleton.dataReady==NO){ //flag that there is no data to display yet
        //clear arrays for results strings
        [singleton.resultStringRows removeAllObjects];
        [singleton.displayStringRows removeAllObjects];
        [singleton.displayStringTitles removeAllObjects];
        
        //clear output strings
        singleton.resultStrings = @"";
        singleton.displayStrings= @"";
    }
    
    //self.tabBarController.tabBar.hidden = NO;

    resultsTempString = @"\n\nThe Corsi Block Tapping Test results and analysis will appear in a table here, once a test has been completed.\n\nTest results will stay visible until a new test is finished, or you press the Home Button on your device.\n\nPressing the home button deletes all unsent email data and resets the Application.\n\nData viewed on screen can be sent by Email as a text file attachment of type CSV, which can be read by many other applications such as a spreadsheets.\n\nPlease ensure that you have correctly set the receiving Email Address.\n\nThe data sent by Email contains reaction timing information not shown on this screen.";
    
    //resultsTxtView.font=[UIFont fontWithName:@"Serifa-Roman" size:16];
    resultsTxtView.text = resultsTempString;
    
    //make a text file from the array of results for email csv attachment
    NSMutableString * element               = [[NSMutableString alloc] init];
    NSMutableString * printString           = [NSMutableString stringWithString:@""];

    NSURL           * defaultPrefsFile      = [[NSBundle mainBundle] URLForResource:@"Root" withExtension:@"plist"];
    NSDictionary    * defaultPrefs          = [NSDictionary dictionaryWithContentsOfURL:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults  * defaults              = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    singleton.subjectName                   = [defaults  objectForKey:kSubject];
    
    long final = singleton.resultStringRows.count;
    if (final > 1) { //was 0 when nill array set in singleton
        for(long i=0; i< final; i++){
            element = [singleton.resultStringRows objectAtIndex: i];
            [printString appendString:[NSString stringWithFormat:@"\n%@", element]];
        }
        [printString appendString:@""];
    }

    //make a text file from the array of results for formatted display on screen
    NSMutableString *element2 = [[NSMutableString alloc] init];
    NSMutableString *printString2 = [NSMutableString stringWithString:@""];

    long final2 = singleton.displayStringRows.count;

    if (final2 > 1) { //was 0 when nill array set in singleton
        for(long i=0; i< final2; i++){
            element2 = [singleton.displayStringRows objectAtIndex: i];
            [printString2 appendString:[NSString stringWithFormat:@"\n%@", element2]];
        }
        [printString2 appendString:@""];
    }
    // NSLog(@"string to write pt1:%@",printString);
    //CREATE FILE to save in Documents Directory
    //nb Have to set info.plist environment variable to allow iTunes sharing if want to tx to iTunes etc this dir.

    //UIViewController *files = [[UIViewController alloc] init];

    singleton.resultStrings  = printString;  //email csv etc
    singleton.displayStrings = printString2; //screen
    
    //check if data exists, if not, display the holding message
    
    //NSLog(@"/n/n *** Display info was ***:%@", printString);
    //NSLog(@"/n/n *** Display data was ***:%@", printString2);
    //NSLog(@"/n/n *** Data Ready Flag =:%i ***", singleton.dataReady);
    
    if (singleton.dataReady == NO) { //test for data, is there some to display
        //no data yet
        resultsTxtView.text  = resultsTempString; // info message displayed
        tableView.hidden=YES;
        emailBTN.hidden=YES;
        resultsTxtView.hidden=NO;
    }else{
        //there is data
        //resultsTxtView.text  = singleton.displayStrings; //table of data displayed
        resultsTxtView.text  = printString; //table of data displayed
        tableView.hidden=NO;
        emailBTN.hidden=NO;
        resultsTxtView.hidden=YES;
    }
    //[self saveText];
    if (![printString isEqualToString: @""]) {
    //if (singleton.dataReady == YES) {
        [self WriteToStringFile:[printString mutableCopy]];
    }
    [tableView reloadData];
    
    //self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    // Return the number of rows in the section.
    //return [arrItems count];
    long a=[singleton.displayStringRows count];
    long b=[singleton.displayStringTitles count];
    //to stop exceeding past array bounds
    if (a<b) {
        return a;
    }else{
        return b;
    }
}

-(void)v

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mySingleton *singleton = [mySingleton sharedSingleton];

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    //cell.textLabel.text = [arrItems objectAtIndex:indexPath.row];
    //old way when cell had no labels in it
    //  cell.textLabel.text = [singleton.displayStringRows objectAtIndex:indexPath.row];
    //  cell.textLabel.font = [UIFont systemFontOfSize:8.0];
    
    //new way with one long label for titles and one short one, starting jhalfway for the data
    titleLab = (UILabel *)[cell viewWithTag:100];
    [titleLab setText:[singleton.displayStringTitles objectAtIndex:indexPath.row]];//title on left
    resultLab = (UILabel *)[cell viewWithTag:200];
    [resultLab setText:[singleton.displayStringRows objectAtIndex:indexPath.row]];//results on right (or none if heading
    
    //done in storyboard
    //[titleLab setFont: [UIFont fontWithName:@"Arial" size:12.0]];
    //[resultLab setFont: [UIFont fontWithName:@"Arial" size:9.0]];
    
    return cell;
    
/*
 //example of label and button populating a cell
 - (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath { 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tvcItems"]; 
 UILabel *lblName = (UILabel *)[cell viewWithTag:100]; 
 [lblName setText:[maTheData objectAtIndex:[indexPath row]]]; 
 UIButton *btnName = (UIButton *)[cell viewWithTag:200]; 
 [btnName setTitle:[maTheData objectAtIndex:[indexPath row]] forState:UIControlStateNormal]; 
 return cell; 
 } -
 */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //sets row heights
    if (indexPath.row == 0) {
        return 30;//first row is for heading, hence bigger
    } else {
        return 25;//all other rows
    }
}

- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    if (indexPath.row==0) {
        titleLab.backgroundColor=[UIColor colorWithRed: 1.0 green: 0.8 blue: 0.8 alpha: 1.0];
        resultLab.backgroundColor=[UIColor colorWithRed: 1.0 green: 0.8 blue: 0.8 alpha: 1.0];
        titleLab.textAlignment=NSTextAlignmentCenter;
        resultLab.hidden=YES;
        
    }else{
        
    //cell.backgroundColor = indexPath.row % 2 //every other row colour change
    //? [UIColor colorWithRed: 1.0 green: 1.0 blue: 0.95 alpha: 0.9]
    //: [UIColor whiteColor];
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    //cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        //titleLab.backgroundColor=[UIColor colorWithRed: 1.0 green: 1.0 blue: 0.95 alpha: 1];
        //resultLab.backgroundColor=[UIColor colorWithRed: 1.0 green: 1.0 blue: 0.95 alpha: 1];
        
        titleLab.backgroundColor = indexPath.row % 2 //every other row colour change
        ? [UIColor colorWithRed: 1 green: 1 blue: 0.85 alpha: 0.90]
        : [UIColor whiteColor];
        resultLab.backgroundColor = indexPath.row % 2 //every other row colour change
        ? [UIColor colorWithRed: 1 green: 1 blue: 0.85 alpha: 0.90]
        : [UIColor whiteColor];
        
        titleLab.textAlignment=NSTextAlignmentLeft;
        if ([resultLab.text isEqualToString: @""]) {
            resultLab.hidden=YES;
        }else{
            resultLab.hidden=NO;
        }
    }
}

-(NSString *) setFilename{
    //mySingleton *singleton = [mySingleton sharedSingleton];
    NSString *extn = @"csv";
    // filename = [NSString stringWithFormat:@"%@.%@", singleton.oldSubjectName, extn];
    filename = [NSString stringWithFormat:@"%@.%@", @"corsi", extn];
    return filename;
}

//find the home directory for Document
-(NSString *) GetDocumentDirectory{
    NSString * docsDir;
    NSArray  * dirPaths;
    
    fileMgr  = [NSFileManager defaultManager];

    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir  = dirPaths[0];
    
    return docsDir;
}

/* Create a new file */
-(void)WriteToStringFile:(NSMutableString *)textToWrite{
    //mySingleton *singleton = [mySingleton sharedSingleton];
    //int trynumber = 0;
    filepath = [[NSString alloc] init];
    NSError *err;
    
    //get sub name and add date
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    // not needed as all file names have date added to end of name
    //check if file exists
    
    //BOOL fileExists = TRUE;
    //if([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
    //exists, error, add +1 to filename and repeat
    //BOOL fileExists = TRUE;
    
    
    //singleton.subjectName = [singleton.olsSubjectName stringByAppendingString: [NSString stringWithFormat:@"_%@_%i",[self getCurrentDateTimeAsNSString], trynumber]];
    //[self WriteToStringFile:textToWrite];
    //    }
    //else
    //    {
    //not exists, write
    //BOOL fileExists = FALSE;
    
    //unrem if necessary
    ///////******** singleton.oldSubjectName = [singleton.subjectName stringByAppendingString: [NSString stringWithFormat:@"_%@",[self getCurrentDateTimeAsNSString]]];
    
    //}
    //
    
    BOOL ok;
    ok = [textToWrite writeToFile:filepath atomically:YES encoding:NSASCIIStringEncoding error:&err];
    if (ok == NO) {
        //(statusMessageLab.text=filepath, [err localizedFailureReason]);
        //NSLog(@"Error writing file at %@\n%@", filepath, [err localizedFailureReason]);
    }
}

-(NSString*)getCurrentDateTimeAsNSString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"ddMMyyHHmmss"];
    NSDate *now = [NSDate date];
    NSString *retStr = [format stringFromDate:now];
    
    return retStr;
}

-(NSString*)getCurrentDate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MM/yyyy"];
    NSDate *now = [NSDate date];
    NSString *retStr = [format stringFromDate:now];

    return retStr;
}

-(NSString*)getCurrentTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSString *retStr = [format stringFromDate:now];

    return retStr;
}

- (void)saveText
{
    //statusMessageLab.text=@"Saving\nData\nFile.";
    mySingleton     * singleton = [mySingleton sharedSingleton];
    
    NSFileManager   * filemgr;
    NSData          * databuffer;
    NSString        * dataFile;
    NSString        * docsDir;
    NSArray         * dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    //NSString * fileNameS = [NSString stringWithFormat:@"%@.csv", singleton.oldSubjectName];
    NSString * fileNameS = @"corsi.csv";

    dataFile = [docsDir stringByAppendingPathComponent:fileNameS];
    
    databuffer = [singleton.resultStrings dataUsingEncoding: NSASCIIStringEncoding];
    [filemgr createFileAtPath: dataFile
                     contents: databuffer attributes:nil];
}

- (IBAction)showEmail:(id)sender {
    //NSLog(@"Sending Email");
    mySingleton *singleton = [mySingleton sharedSingleton];

    singleton.testDate=[self getCurrentDate];
    singleton.testTime=[self getCurrentTime];

    NSString *emailTitle = [NSString stringWithFormat:@"Corsi App Data: %@",singleton.oldSubjectName];
    NSString *messageBody = [NSString stringWithFormat:@"The test data for the subject:%@ taken at the date: %@ and time: %@, is attached as a text/csv file.\n\nThe file format is comma separated variable with a csv extension.\n\nThe data can be read by MS-Excel, then analysed by your own functions.\n\nSent by the Corsi App.",singleton.oldSubjectName, singleton.testDate, singleton.testTime];
    
    //NSArray  *toRecipents = [NSArray arrayWithObject:@"j.a.howell@mmu.ac.uk"];//testing only
    NSArray  *toRecipents = [NSArray arrayWithObject:singleton.email];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    filepath = [[NSString alloc] init];
    
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    // Get the resource path and read the file using NSData
    
    NSData *fileData = [NSData dataWithContentsOfFile:filepath];
    
    // Determine the MIME type
    NSString *mimeType; /*
                         if ([extension isEqualToString:@"jpg"]) {
                         mimeType = @"image/jpeg";
                         } else if ([extension isEqualToString:@"png"]) {
                         mimeType = @"image/png";
                         } else if ([extension isEqualToString:@"doc"]) {
                         mimeType = @"application/msword";
                         } else if ([extension isEqualToString:@"csv"]) { */
    mimeType = @"text/csv";
    /*
     } else if ([extension isEqualToString:@"ppt"]) {
     mimeType = @"application/vnd.ms-powerpoint";
     } else if ([extension isEqualToString:@"html"]){
     mimeType = @"text/html";
     } else if ([extension isEqualToString:@"pdf"]) {
     mimeType = @"application/pdf";
     } */
    
    // Add attachment
    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    //NSLog(@"Finished Email");
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
        //NSLog(@"Mail cancelled");
        break;
        case MFMailComposeResultSaved:
        //NSLog(@"Mail saved");
        break;
        case MFMailComposeResultSent:
        //NSLog(@"Mail sent");
        break;
        case MFMailComposeResultFailed:
        //NSLog(@"Mail sent failure: %@", [error localizedDescription]);
        break;
        default:
        //NSLog(@"Mail problem, not sent, failed, saved or cancelled... some other fault");
        break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
//NSLog(@"Email View now closed.");
}

@end
