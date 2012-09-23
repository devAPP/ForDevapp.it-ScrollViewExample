//
//  ViewController.m
//  rompicoglioni
//
//  Created by Ignazio Calò on 9/23/12.
//  Copyright (c) 2012 Ignazio Calò. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableArray *_subViews;
    UIScrollView *_scrollview;
    
    int num_subview;
    int width_subview;
    int heigth_subview;
    int margin;
    int left_offset;
    int right_offset;
    int top_offset;
    int bottom_offset;
    
}

@end



@implementation ViewController
@synthesize indexField;

- (void)setup_variables
{
    num_subview = 10;
    width_subview = 100;
    heigth_subview = 200;
    margin = 10;
    left_offset = 20;
    right_offset = 20;
    top_offset = 10;
    bottom_offset = 10;
}

- (void)setupScrollView
{
    _scrollview = [[UIScrollView alloc ]initWithFrame:CGRectMake(0, 0, 320, heigth_subview + bottom_offset + top_offset)];
    [_scrollview setBackgroundColor:[UIColor darkGrayColor]];
    
    [_scrollview setContentSize:CGSizeMake(width_subview * num_subview + ((num_subview - 1) * margin) + (left_offset + right_offset), heigth_subview + bottom_offset + top_offset)];
    
    for (int i = 0; i < num_subview; i++) {
        UIView *v = [[UIView alloc ]initWithFrame:CGRectMake(right_offset + i * (width_subview + margin)  , top_offset, width_subview, heigth_subview)];
        UILabel *l = [[UILabel alloc]initWithFrame:v.bounds];
        [l setText:[NSString stringWithFormat:@"%d", i]];
        [l setFont:[UIFont boldSystemFontOfSize:40]];
        [l setTextAlignment:UITextAlignmentCenter];
        [l setBackgroundColor:[UIColor clearColor]];
        [v addSubview:l];
        [v setBackgroundColor:[UIColor redColor]];
        [_scrollview addSubview:v];
        [_subViews addObject:v];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor blackColor]];
    
    if (! _subViews) {
        _subViews = [NSMutableArray array];
    }
    
    [self setup_variables];
    
    [self setupScrollView];
    
    [self.view addSubview:_scrollview];
}



-(UIView *)subviewAtIndex:(int)index {
    if ( (index < 0 ) || (index >= [_subViews count]) ) {
        return nil;
    }
    return [_subViews objectAtIndex:index];
}


-(void)removeSubViewAtIndex:(int)index {
    if ( (index < 0 ) || (index >= [_subViews count]) ) {
        return ;
    }
    UIView *v = [self subviewAtIndex:index];
    [v removeFromSuperview];
    [_subViews removeObjectAtIndex:index];
    [UIView animateWithDuration:0.4
                     animations:^(){
                         for (int i = index; i < [_subViews count]; i++ ) {
                             UIView *k = [self subviewAtIndex:i  ];
                             k.center = CGPointMake(k.center.x - (width_subview + margin), k.center.y);
                         }
                         
                     }
                     completion:nil];
    
}


#pragma mark demo stuff

- (IBAction)changeColorButtonPressed:(UIButton *)sender {
    int index = [self.indexField.text intValue];
    UIView *v = [self subviewAtIndex:index];
    [v setBackgroundColor:[UIColor yellowColor]];
    
}

- (IBAction)removeButtonPressed:(id)sender {
    int index = [self.indexField.text intValue];
    [self removeSubViewAtIndex:index];
}

- (IBAction)stepperchangedValue:(UIStepper *)sender {
    self.indexField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    
}



#pragma mark memory management


- (void)viewDidUnload {
    [self setIndexField:nil];
    [super viewDidUnload];
}
@end
