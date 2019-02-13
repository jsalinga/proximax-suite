//
//  CCIntro.m
//  Nextcloud iOS
//
//  Created by Marino Faggiana on 05/11/15.
//  Copyright (c) 2017 Marino Faggiana. All rights reserved.
//
//  Author Marino Faggiana <marino.faggiana@nextcloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "CCIntro.h"
#import "AppDelegate.h"
#import "NCBridgeSwift.h"

@interface CCIntro () <SwiftModalWebVCDelegate>
{
    int titlePositionY;
    int descPositionY;
    int titleIconPositionY;
    int buttonPosition;
    
    int selector;
}
@end

@implementation CCIntro

- (id)initWithDelegate:(id <CCIntroDelegate>)delegate delegateView:(UIView *)delegateView
{
    self = [super init];
    
    if (self) {
        self.delegate = delegate;
        self.rootView = delegateView;
    }

    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)introWillFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped
{
    [self.delegate introFinishSelector:selector];
}

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped
{
}

- (void)show
{
    [self showIntro];
}

- (void)showIntro
{
    //NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    CGFloat height = self.rootView.bounds.size.height;
    CGFloat width = self.rootView.bounds.size.width;
    
    if (height <= 568) {
        titleIconPositionY = 20;
        titlePositionY = height / 2 + 40.0;
        descPositionY  = height / 2;
        buttonPosition = height / 2 + 50.0;
    } else {
        titleIconPositionY = 100;
        titlePositionY = height / 2 + 40.0;
        descPositionY  = height / 2;
        buttonPosition = height / 2 + 120.0;
    }
    
    // Button
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.rootView.bounds.size.width,220)];
    buttonView.userInteractionEnabled = YES ;
    
    UIButton *buttonLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonLogin.frame = CGRectMake(50.0, 0.0, width - 100.0, 40.0);
    buttonLogin.layer.cornerRadius = 3;
    buttonLogin.clipsToBounds = YES;
    [buttonLogin setTitle:[NSLocalizedString(@"_log_in_", nil) uppercaseString] forState:UIControlStateNormal];
    buttonLogin.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonLogin.backgroundColor = [[NCBrandColor sharedInstance] customerText];
    [buttonLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    
    [buttonView addSubview:buttonLogin];
    
    UIButton *buttonSignUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonSignUp.frame = CGRectMake(50.0, 60.0, width - 100.0, 40.0);
    buttonSignUp.layer.cornerRadius = 3;
    buttonSignUp.clipsToBounds = YES;
    [buttonSignUp setTitle:[NSLocalizedString(@"_sign_up_", nil) uppercaseString] forState:UIControlStateNormal];
    buttonSignUp.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonSignUp.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:89.0/255.0 blue:141.0/255.0 alpha:1.000];
    [buttonSignUp addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchDown];
        
    [buttonView addSubview:buttonSignUp];
    
    UIButton *buttonHost = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonHost.frame = CGRectMake(50.0, 200.0, width - 100.0, 20.0);
    buttonHost.layer.cornerRadius = 3;
    buttonHost.clipsToBounds = YES;
    [buttonHost setTitle:NSLocalizedString(@"_host_your_own_server", nil) forState:UIControlStateNormal];
    buttonHost.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonHost setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    buttonHost.backgroundColor = [UIColor clearColor];
    [buttonHost addTarget:self action:@selector(host:) forControlEvents:UIControlEventTouchDown];
    
    [buttonView addSubview:buttonHost];
    
    // Pages
    
    EAIntroPage *page1 = [EAIntroPage page];

    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro1"]];
    page1.titleIconPositionY = titleIconPositionY;

    page1.title = NSLocalizedString(@"_intro_1_title_", nil);
    page1.titlePositionY = titlePositionY;
    page1.titleColor = [[NCBrandColor sharedInstance] customerText];
    page1.titleFont = [UIFont systemFontOfSize:23];

    page1.bgColor = [[NCBrandColor sharedInstance] customer];
    page1.showTitleView = YES;

    EAIntroPage *page2 = [EAIntroPage page];

    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro2"]];
    page2.titleIconPositionY = titleIconPositionY;

    page2.title = NSLocalizedString(@"_intro_2_title_", nil);
    page2.titlePositionY = titlePositionY;
    page2.titleColor = [[NCBrandColor sharedInstance] customerText];
    page2.titleFont = [UIFont systemFontOfSize:23];
    
    page2.bgColor = [[NCBrandColor sharedInstance] customer];
    page2.showTitleView = YES;

    EAIntroPage *page3 = [EAIntroPage page];
    
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro3"]];
    page3.titleIconPositionY = titleIconPositionY;

    page3.title = NSLocalizedString(@"_intro_3_title_", nil);
    page3.titlePositionY = titlePositionY;
    page3.titleColor = [[NCBrandColor sharedInstance] customerText];
    page3.titleFont = [UIFont systemFontOfSize:23];
    
    page3.bgColor = [[NCBrandColor sharedInstance] customer];
    page3.showTitleView = YES;

    EAIntroPage *page4 = [EAIntroPage page];
    
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro4"]];
    page4.titleIconPositionY = titleIconPositionY;
    
    page4.title = NSLocalizedString(@"_intro_4_title_", nil);
    page4.titlePositionY = titlePositionY;
    page4.titleColor = [[NCBrandColor sharedInstance] customerText];
    page4.titleFont = [UIFont systemFontOfSize:23];
    
    page4.bgColor = [[NCBrandColor sharedInstance] customer];
    page4.showTitleView = YES;
    
    // INTRO
    
    self.intro = [[EAIntroView alloc] initWithFrame:self.rootView.bounds andPages:@[page1,page2,page3,page4]];

    self.intro.tapToNext = NO;
    self.intro.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.intro.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.intro.pageControl.backgroundColor = [[NCBrandColor sharedInstance] customer];
//    [intro.skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    intro.skipButton.enabled = NO;
    self.intro.swipeToExit = NO ;
    self.intro.skipButton = nil ;
    self.intro.titleView = buttonView;
    self.intro.titleViewY = buttonPosition;
    self.intro.swipeToExit = NO;
    
    /*
    page1.onPageDidAppear = ^{
        intro.skipButton.enabled = YES;
        [UIView animateWithDuration:0.3f animations:^{
            intro.skipButton.alpha = 1.f;
        }];
    };
    page2.onPageDidDisappear = ^{
        intro.skipButton.enabled = NO;
        [UIView animateWithDuration:0.3f animations:^{
            intro.skipButton.alpha = 0.f;
        }];
    };
    */
    
    [self.intro setDelegate:self];
    [self.intro showInView:self.rootView animateDuration:0];
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark ===== Action =====
#pragma --------------------------------------------------------------------------------------------

- (void)login:(id)sender
{
    selector = k_intro_login;
    [self.intro hideWithFadeOutDuration:0.7];
}

- (void)signUp:(id)sender
{
    selector = k_intro_signup;
    [self.intro hideWithFadeOutDuration:0.7];
}

- (void)host:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    SwiftModalWebVC *webVC = [[SwiftModalWebVC alloc] initWithUrlString:[NCBrandOptions sharedInstance].linkLoginHost colorText:[UIColor whiteColor] colorDoneButton:[UIColor blackColor] doneButtonVisible:YES hideToolbar:NO];
    webVC.delegateWeb = self;
    
    [appDelegate.window.rootViewController presentViewController:webVC animated:YES completion:nil];
}
- (void)didStartLoading
{
}
- (void)didReceiveServerRedirectForProvisionalNavigationWithUrl:(NSURL *)url
{
}
- (void)didFinishLoadingWithSuccess:(BOOL)success url:(NSURL *)url
{
}
- (void)webDismiss
{
}

@end
