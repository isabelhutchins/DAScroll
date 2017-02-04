//
//  gridTab.m
//  DAScroll
//
//  Created by Anthony Jonikas on 1/25/16.
//  Copyright © 2016 Anthony Jonikas. All rights reserved.
//Bella Hutchins and Anthony Jonikas


#import "gridTabViewController.h"
#import "frontViewController.h"
#import "OpinionViewController.h"
#import "EditorialViewController.h"
#import "featuresViewController.h"
#import "artsViewController.h"
#import "SportsViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface gridTabViewController ()

@property (nonatomic, weak) IBOutlet UIButton *front;
@property (nonatomic, weak) IBOutlet UIButton *opinion;
@property (nonatomic, weak) IBOutlet UIButton *editorial;
@property (nonatomic, weak) IBOutlet UIButton *features;
@property (nonatomic, weak) IBOutlet UIButton *arts;
@property (nonatomic, weak) IBOutlet UIButton *sports;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end


@implementation gridTabViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"DeerfieldIconTab.png"];
        self.tabBarItem.image = image;
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.image = [UIImage imageNamed:@"scroll title.png"];
    _front.titleLabel.font = [UIFont fontWithName:@"Arial" size:37 ];
    [_front setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_front setBackgroundColor:[UIColor colorWithRed: 0/255 green: 79.05/255 blue: 0/255 alpha:1.0]];
    [[_front layer] setBorderWidth:1.0f];
    [[_front layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    _opinion.titleLabel.font = [UIFont fontWithName:@"Arial" size:37];
    [_opinion setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_opinion setBackgroundColor:[UIColor colorWithRed: 0/255 green: 79.05/255 blue: 0/255 alpha:1.0]];
    [[_opinion layer] setBorderWidth:1.0f];
    [[_opinion layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    _editorial.titleLabel.font = [UIFont fontWithName:@"Arial" size:37];
    [_editorial setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_editorial setBackgroundColor:[UIColor colorWithRed: 0/255 green: 79.05/255 blue: 0/255 alpha:1.0]];
    [[_editorial layer] setBorderWidth:1.0f];
    [[_editorial layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    _features.titleLabel.font = [UIFont fontWithName:@"Arial" size:37];
    [_features setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_features setBackgroundColor:[UIColor colorWithRed: 0/255 green: 79.05/255 blue: 0/255 alpha:1.0]];
    [[_features layer] setBorderWidth:1.0f];
    [[_features layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    _sports.titleLabel.font = [UIFont fontWithName:@"Arial" size:37];
    [_sports setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sports setBackgroundColor:[UIColor colorWithRed: 0/255 green: 79.05/255 blue: 0/255 alpha:1.0]];
    [[_sports layer] setBorderWidth:1.0f];
    [[_sports layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    _arts.titleLabel.font = [UIFont fontWithName:@"Arial" size:37];
    [_arts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_arts setBackgroundColor:[UIColor colorWithRed: 0/255 green: 79.05/255 blue: 0/255 alpha:1.0]];
    [[_arts layer] setBorderWidth:1.0f];
    [[_arts layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    
}

//as of right now, we create a new view for each page each time we want to see it.
-(IBAction)FrontPage:(id)sender
{
 
    frontViewController *new = [[frontViewController alloc] init];
    [self presentViewController:new animated:YES completion:nil];
    
}

-(IBAction)Opinion:(id)sender
{
   
    OpinionViewController *newOp = [[OpinionViewController alloc] init];
    [self presentViewController:newOp animated:YES completion:nil];
   
}

-(IBAction)Editorial:(id)sender
{
    
    
    EditorialViewController *newEd = [[EditorialViewController alloc] init];
    [self presentViewController:newEd animated:YES completion:nil];
    /*
     searchBarViewController *viewController = [[searchBarViewController alloc] init];
     [self presentViewController:viewController animated:YES completion:nil];
     */
}

-(IBAction)Features:(id)sender
{
   
    featuresViewController *newFeat = [[featuresViewController alloc] init];
    [self presentViewController:newFeat animated:YES completion:nil];
    /*
     searchBarViewController *viewController = [[searchBarViewController alloc] init];
     [self presentViewController:viewController animated:YES completion:nil];
     */
}


-(IBAction)Arts:(id)sender
{
   
    artsViewController *newArt = [[artsViewController alloc] init];
    [self presentViewController:newArt animated:YES completion:nil];
    /*
     searchBarViewController *viewController = [[searchBarViewController alloc] init];
     [self presentViewController:viewController animated:YES completion:nil];
     */
}

-(IBAction)Sports:(id)sender
{
    
    SportsViewController *newSp = [[SportsViewController alloc] init];
    [self presentViewController:newSp animated:YES completion:nil];
    /*
     searchBarViewController *viewController = [[searchBarViewController alloc] init];
     [self presentViewController:viewController animated:YES completion:nil];
     */
}

- (void)didReceiveMemoryWarning {
    
    // Dispose of any resources that can be recreated.
}

@end
