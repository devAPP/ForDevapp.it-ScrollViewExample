//
//  ViewController.h
//  scrollview_Example_devapp
//
//  Created by Ignazio Calò on 9/23/12.
//  Copyright (c) 2012 Ignazio Calò. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



@property (weak, nonatomic) IBOutlet UITextField *indexField;

- (IBAction)changeColorButtonPressed:(UIButton *)sender;
- (IBAction)removeButtonPressed:(id)sender;
@end
