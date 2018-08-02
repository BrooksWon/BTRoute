//
//  ModuleTestCase.m
//  BTRouteDemoTests
//
//  Created by Brooks on 2018/8/2.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTModuleManager.h"
#import "BTModulesConfiguration.h"
#import "BTModule.h"


@interface ModuleTestCase : XCTestCase

@property (nonatomic, strong) BTModule *moduleIndex;
@property (nonatomic, strong) BTModule *moduleUser;
@property (nonatomic, strong) BTModule *moduleSetting;
@property (nonatomic, strong) BTModule *moduleWeb;

@end

@implementation ModuleTestCase

- (void)setUp {
    [super setUp];
    
    self.moduleIndex = [BTModule new];
    self.moduleIndex.id = @"IndexModule";
    self.moduleIndex.name = @"首页";
    self.moduleIndex.routes = @[@"bt://home", @"bt://index"];
    
    self.moduleUser = [BTModule new];
    self.moduleUser.id = @"UserModule";
    self.moduleUser.name = @"个人中心";
    self.moduleUser.routes = @[@"bt://user"];
    
    self.moduleSetting = [BTModule new];
    self.moduleSetting.id = @"SettingModule";
    self.moduleSetting.name = @"设置";
    self.moduleSetting.routes = @[@"bt://setting", @"bt://more", @"bt://set"];
    
    self.moduleWeb = [BTModule new];
    self.moduleWeb.id = @"WebModule";
    self.moduleWeb.name = @"web";
    self.moduleWeb.routes = @[@"bt://web", @"bt://WebModule", @"bt://WebModule/about", @"bt://WebModule/site"];
}

- (void)tearDown {
    self.moduleIndex = nil;
    self.moduleUser = nil;
    self.moduleSetting = nil;
    
    [super tearDown];
}

- (void)testModuleIndexHandleUrl_withRegisteredUrl1_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://index"];
    
    XCTAssertTrue([self.moduleIndex canHandleURL:testUrl]);
}

- (void)testModuleIndexHandleUrl_withRegisteredUrl2_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://home"];
    
    XCTAssertTrue([self.moduleIndex canHandleURL:testUrl]);
}

- (void)testModuleIndexHandleUrl_withUnregisteredUrl1_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://index2"];
    
    XCTAssertFalse([self.moduleIndex canHandleURL:testUrl]);
}

- (void)testModuleIndexHandleUrl_withUnregisteredUrl2_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://user"];
    
    XCTAssertFalse([self.moduleIndex canHandleURL:testUrl]);
}

- (void)testModuleUserHandleUrl_withRegisteredUrl_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://user?name=ZhangSan&age=27"];
    
    XCTAssertTrue([self.moduleUser canHandleURL:testUrl]);
}

- (void)testModuleUserHandleUrl_withRegisteredUrl_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://user"];
    
    XCTAssertTrue([self.moduleUser canHandleURL:testUrl]);
}

- (void)testModuleUserHandleUrl_withUnregisteredUrl1_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://user/id"];
    
    XCTAssertFalse([self.moduleSetting canHandleURL:testUrl]);
}

- (void)testmoduleSettingHandleUrl_withRegisteredUrl_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://setting"];
    
    XCTAssertTrue([self.moduleSetting canHandleURL:testUrl]);
}

- (void)testmoduleSettingHandleUrl_withRegisteredUrl2_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://set"];
    
    XCTAssertTrue([self.moduleSetting canHandleURL:testUrl]);
}

- (void)testmoduleSettingHandleUrl_withRegisteredUrl3_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://more"];
    
    XCTAssertTrue([self.moduleSetting canHandleURL:testUrl]);
}

- (void)testmoduleSettingHandleUrl_withUnregisteredUrl_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://user"];
    
    XCTAssertFalse([self.moduleSetting canHandleURL:testUrl]);
}

- (void)testmoduleSettingHandleUrl_withUnregisteredUrl2_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://web"];
    
    XCTAssertFalse([self.moduleSetting canHandleURL:testUrl]);
}

- (void)testmoduleSettingHandleUrl_withUnregisteredUrl3_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://index"];
    
    XCTAssertFalse([self.moduleSetting canHandleURL:testUrl]);
}

- (void)testmoduleWebHandleUrl_withRegisteredUrl1_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://web"];
    
    XCTAssertTrue([self.moduleWeb canHandleURL:testUrl]);
}

- (void)testmoduleWebHandleUrl_withRegisteredUrl2_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://WebModule"];
    
    XCTAssertTrue([self.moduleWeb canHandleURL:testUrl]);
}

- (void)testmoduleWebHandleUrl_withRegisteredUrl3_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://WebModule/about"];
    
    XCTAssertTrue([self.moduleWeb canHandleURL:testUrl]);
}

- (void)testmoduleWebHandleUrl_withRegisteredUrl4_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://WebModule/site"];
    
    XCTAssertTrue([self.moduleWeb canHandleURL:testUrl]);
}

- (void)testmoduleWebHandleUrl_withRegisteredUrl5_expectTrue {
    NSURL *testUrl = [NSURL URLWithString:@"bt://web?title=i'mtitle&url=thisisurl&color=red"];
    
    XCTAssertTrue([self.moduleWeb canHandleURL:testUrl]);
}

- (void)testmoduleWebHandleUrl_withUnregisteredUrl1_expectFalse {
    NSURL *testUrl = [NSURL URLWithString:@"bt://web/Disclaimer"];
    
    XCTAssertFalse([self.moduleWeb canHandleURL:testUrl]);
}


@end


