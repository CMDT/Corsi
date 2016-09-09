//
//  detailsVC.h
//  Corsi
//
//  Created by Jonathan Howell on 14/11/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  Minor updates and re-build for distro 2/11/15 jah
//  Minor updates and re-build for distro 9/9/16 jah
//

#import <UIKit/UIKit.h>

@interface detailsVC : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField * testerNameTXT;
@property (strong, nonatomic) IBOutlet UITextField * emailTXT;
@property (strong, nonatomic) IBOutlet UITextField * participantTXT;

@end