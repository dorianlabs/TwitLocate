//
//  ViewController.m
//  TwitLocate
//
//  Created by Guven Bolukbasi on 21/02/15.
//  Copyright (c) 2015 Guven Bolukbasi. All rights reserved.
//

#import "TweetViewController.h"

#import "UserViewController.h"

@interface TweetViewController ()
@property (nonatomic, strong) NSArray* allTweets;
@property (nonatomic, strong) NSDictionary* selectedTweet;
@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{@"Content-Type" : @"application/x-www-form-urlencoded;charset=UTF-8",
                                       @"User-Agent" : @"28_Feb_2015_Workshop_App",
                                       @"Accept-Encoding":@"gzip",
                                       @"Authorization":@"Basic SDFLZ0JMVUx1RDRFVTY3NjN5YlZVaWY3TTpMdUZXa1g2bUdzQUE4RjhZeTlPS3djb2Z4U01Da1NOUW5oaTJqMGhOMEwzZlBGUFJucw=="}];
    
    NSURL* url = [NSURL URLWithString:@"https://api.twitter.com/oauth2/token"];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"grant_type=client_credentials" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSString* token = dict[@"access_token"];
        [self callTwitterWithToken:token];
    }];
    
    [dataTask resume];
     
}

- (void) callTwitterWithToken: (NSString*) token {

    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{
                                       @"User-Agent" : @"28_Feb_2015_Workshop_App",
                                       @"Accept-Encoding":@"gzip",
                                       @"Authorization":[NSString stringWithFormat:@"Bearer %@",token]
                                       }];
    
    NSString* urlToCall = [NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json?q=&geocode=40.973543,29.073143,%dkm&count=20", self.selectedKm];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlToCall]];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        self.allTweets = dict[@"statuses"];
    
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
        
    }];
    
    [dataTask resume];
}

- (void) updateUI {
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell"];
//    NSDictionary* tweet = self.allTweets[indexPath.row];
//    
//    cell.textLabel.text = tweet[@"text"];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell2"];
    NSDictionary* tweet = self.allTweets[indexPath.row];

    UILabel* tweetUser = (UILabel*) [cell.contentView viewWithTag:1];
    UILabel* tweetContent = (UILabel*) [cell.contentView viewWithTag:2];
    UILabel* tweetTime = (UILabel*) [cell.contentView viewWithTag:3];

    
    tweetContent.text = tweet[@"text"];
    tweetUser.text = tweet[@"user"][@"screen_name"];
    tweetTime.text = tweet[@"created_at"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 170;
    return 206.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.allTweets.count;
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary* tweet = self.allTweets[indexPath.row];
    UserViewController* cont = (UserViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"UserView"];
    cont.tweet = tweet;
    
    [self.navigationController pushViewController:cont animated:YES];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"toUser"]) {
//         segue.destinationViewController;
//        
//        
//    }

@end
