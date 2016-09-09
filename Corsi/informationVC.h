//
//  informationVC.h
//  Corsi
//
//  Created by Jon Howell on 04/09/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  Minor updates and re-build for distro 2/11/15 jah
//  Minor updates and re-build for distro 9/9/16 jah
//

#import <UIKit/UIKit.h>

@interface informationVC : UIViewController{
    UITextView *infoTextView;
}

@property (nonatomic,retain) IBOutlet UITextView *infoTextView;

@end