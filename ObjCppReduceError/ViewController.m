//
//  ViewController.m
//  ObjCppReduceError
//
//  Created by Barry Simpson on 11/12/13.
//  Copyright (c) 2013 XYZ Corp. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *siteAddressField;
@property (strong, nonatomic) IBOutlet UITextField *accessKeyField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	RACSignal *siteAddressValidSignal =
	[[self.siteAddressField rac_textSignal] map:^id(NSString *value) {
		return @([value isEqual:@"dingus"]);
	}];

	RACSignal *accessKeyValidSignal =
	[[self.accessKeyField rac_textSignal] map:^id(NSString *value) {
		return @([value isEqual:@"12345"]);
	}];

	RAC(self.submitButton, enabled) =
	[RACSignal
	 combineLatest:@[siteAddressValidSignal, accessKeyValidSignal]
	 reduce:^id(NSNumber *siteAddressValid, NSNumber *accessKeyValid){
		 return @(siteAddressValid.boolValue && accessKeyValid.boolValue);
	 }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
