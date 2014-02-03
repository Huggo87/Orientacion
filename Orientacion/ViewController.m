//
//  ViewController.m
//  Orientacion
//
//  Created by Jose Aguirre on 28/01/14.
//  Copyright (c) 2014 Jose Aguirre. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

#define deg2rad (3.1415926/180.0)

@synthesize appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self performSelector:@selector(updateLandscapeView) withObject:nil afterDelay:0];
    }];
    
    
}

- (void)updateLandscapeView {

    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) && !appDelegate.isShowingLandscapeView)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main-Landscape" bundle:[NSBundle mainBundle]];
        ViewController *vista =  [storyboard instantiateViewControllerWithIdentifier:@"Vista"];
        
        if (deviceOrientation == UIInterfaceOrientationLandscapeRight)
            vista.view.transform = CGAffineTransformMakeRotation(deg2rad*(90));
        else
            vista.view.transform = CGAffineTransformMakeRotation(deg2rad*(-90));
            
        
        vista.view.bounds = CGRectMake(0.0, 0.0, 480.0, 320.0);
        appDelegate.isShowingLandscapeView = YES;
        [UIView transitionWithView:vista.view duration:0 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationCurveEaseIn animations:^{
            
            appDelegate.window.rootViewController = vista;
        } completion:NULL];
    }
    else if (UIDeviceOrientationIsPortrait(deviceOrientation) && appDelegate.isShowingLandscapeView)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main-portrait" bundle:[NSBundle mainBundle]];
        ViewController *vista = [storyboard instantiateViewControllerWithIdentifier:@"Vista"];
        
        vista.view.transform = CGAffineTransformMakeRotation(deg2rad*(0));
        vista.view.bounds = CGRectMake(0.0, 0.0, 300.0, 460.0);
        
        appDelegate.isShowingLandscapeView    = NO;
        [UIView transitionWithView:vista.view duration:0 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationCurveEaseIn animations:^{

           appDelegate.window.rootViewController = vista;
        } completion:NULL];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
