//
//  STLOAuthClientTests.m
//  STLOAuthClientTests
//
//  Created by Andy Mroczkowski on 9/29/12.
//
//

#import "STLOAuthClientTests.h"
#import "STLOAuthClient.h"

@interface STLOAuthClientTests ()


@end

@implementation STLOAuthClientTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark Test Base URL

- (void) test_Strip_Port_If_Default_HTTP
{
    NSURL *url = [NSURL URLWithString:@"http://foo.com:80"];
    
    NSString *baseURL = [STLOAuthClient baseURLforAddress:url];
    
    STAssertEqualObjects(baseURL, @"http://foo.com", @"should be equal");
}

- (void) test_Strip_Port_If_Default_HTTPS
{
    NSURL *url = [NSURL URLWithString:@"https://foo.com:443"];
    
    NSString *baseURL = [STLOAuthClient baseURLforAddress:url];
    
    STAssertEqualObjects(baseURL, @"https://foo.com", @"should be equal");
}

- (void) test_Does_Not_Strip_Port_If_Not_Default
{
    NSURL *url = [NSURL URLWithString:@"http://foo.com:123"];
    
    NSString *baseURL = [STLOAuthClient baseURLforAddress:url];
    
    STAssertEqualObjects(baseURL, @"http://foo.com:123", @"should be equal");
}

- (void) test_Does_Not_Insert_Trailing_Slash
{
    // If a trailing slash is not present in the original URL, it should not be in the base URL either
    
    NSURL *url = [NSURL URLWithString:@"http://foo.com/path"];
    
    NSString *baseURL = [STLOAuthClient baseURLforAddress:url];
    
    STAssertEqualObjects(baseURL, @"http://foo.com/path", @"should be equal");
}

- (void) test_Does_Not_Strip_Trailing_Slash_No_QueryString
{
    // If a trailing slash is present in the original URL, it should be preserved on the base URL

    NSURL *url = [NSURL URLWithString:@"http://foo.com/path/"];
    
    NSString *baseURL = [STLOAuthClient baseURLforAddress:url];
    
    STAssertEqualObjects(baseURL, @"http://foo.com/path/", @"should be equal");
}

- (void) test_Does_Not_Strip_Trailing_Slash_With_QueryString
{
    // If a trailing slash is present in the original URL, it should be preserved on the base URL
    
    NSURL *url = [NSURL URLWithString:@"http://foo.com/path/?abc=123"];
    
    NSString *baseURL = [STLOAuthClient baseURLforAddress:url];
    
    STAssertEqualObjects(baseURL, @"http://foo.com/path/", @"should be equal");
}


@end
