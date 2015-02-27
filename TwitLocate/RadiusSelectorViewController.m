//
//  MapControllerViewController.m
//  TwitLocate
//
//  Created by Guven Bolukbasi on 24/02/15.
//  Copyright (c) 2015 Guven Bolukbasi. All rights reserved.
//

#import "RadiusSelectorViewController.h"

#import "TweetViewController.h"

@interface RadiusSelectorViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *kmSelector;
@end

@implementation RadiusSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TweetViewController* cont = (TweetViewController*) segue.destinationViewController;
    
    if (self.kmSelector.selectedSegmentIndex == 0) {
        cont.selectedKm = 1;
    }
    else if (self.kmSelector.selectedSegmentIndex == 1) {
        cont.selectedKm = 5;
    }
    else {
        cont.selectedKm = 10;
    }
}

@end
