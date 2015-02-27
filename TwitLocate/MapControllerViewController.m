//
//  MapControllerViewController.m
//  TwitLocate
//
//  Created by Guven Bolukbasi on 24/02/15.
//  Copyright (c) 2015 Guven Bolukbasi. All rights reserved.
//

#import "MapControllerViewController.h"

#import "ViewController.h"

@interface MapControllerViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *kmSelector;
@end

@implementation MapControllerViewController

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
    
    if ([segue.identifier isEqualToString:@"toTweets"]) {
        ViewController* cont = (ViewController*) segue.destinationViewController;
        
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
}

@end
