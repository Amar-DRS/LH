//
//  EventDetailViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/16/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;



}

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventTitleLab.text=self.eventTitle;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.eventDetailWebView.delegate=self;
//    [[self.eventDetailWebView layer] setCornerRadius:10];
//    [self.eventDetailWebView setClipsToBounds:YES];
//    
//    // Create colored border using CALayer property
//    [[self.eventDetailWebView layer] setBorderColor:
//     [[UIColor blackColor] CGColor]];
//    [[self.eventDetailWebView layer] setBorderWidth:1];
//
    if (!self.idAarticle) {
        self.idAarticle=@"";
    }
    dic=  @{@"action":@"event_detail",@"id_article":self.idAarticle};
    
    [self eventData:dic];
    // Do any additional setup after loading the view from its nib.
}
-(void)eventData:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper eventApi:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"Event"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString*eventHtmlDetail=[[info objectAtIndex:0] objectForKey:@"content"];

                [self.eventDetailWebView loadHTMLString:eventHtmlDetail baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:3.0];
            });
        }
    }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:2.0];
        }
    }


-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
@end
