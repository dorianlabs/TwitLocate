//
//  UserViewController.m
//  TwitLocate
//
//  Created by Guven Bolukbasi on 26/02/15.
//  Copyright (c) 2015 Guven Bolukbasi. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profile;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end

@implementation UserViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.name.text = self.tweet[@"user"][@"name"];
    self.desc.text = self.tweet[@"user"][@"description"];

    NSString *imageURL = self.tweet[@"user"][@"profile_image_url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    self.profile.image = [UIImage imageWithData:imageData];
}

@end
