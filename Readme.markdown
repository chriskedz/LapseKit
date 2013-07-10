# LapseKit

Simple Objective-C client for working with the Everlapse API.

LapseKit is tested on iOS 5 and requires ARC. It relies on [AFNetworking][AFNetworking]. Released under the [MIT license](LICENSE).

## Usage

You can use `EVLHTTPClient` as is, or subclass it to provide custom behavior. [Everlapse][Everlapse] itself uses an internal subclass of `EVLHTTPClient` to provide Core Data and other helpers.

`EVLHTTPClient` provides a `sharedClient` method that you can use to access a standard singleton instance of the class.

```objc
# import "EVLHTTPClient.h"

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[EVLHTTPClient sharedClient] getUserWithID:self.userID success:^(AFHTTPRequestOperation *operation, id responseObject) {
    self.userNameLabel.text = [NSString stringWithFormat:@"@%@", responseObject[@"username"]];
    self.nameLabel.text = [NSString stringWithFormat:@"@ @", responseObject[@"given_name"], responseObject[@"family_name"]];
  } failure:nil];
}

@end
```

See the [documentation][Documentation] for more usage and examples.

## Installation

Installing `LapseKit` with [CocoaPods][CocoaPods] is highly recommended. Simply add `pod 'LapseKit'` to your Podfile. Otherwise, you will need to install [AFNetworking][AFNetworking] and add `EVLHTTPClient.h` and `EVLHTTPClient.m` to your project.

[AFNetworking]: http://afnetworking.com
[CocoaPods]: http://cocoapods.org
[Documentation]: https://developer.everlapse.com
[Everlapse]: https://everlapse.com