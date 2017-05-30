//
//  AboutLearningHouse.m
//  LearningHouse
//
//  Created by Alok Singh on 8/2/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "AboutLearningHouse.h"

@interface AboutLearningHouse ()<WebServiceResponseProtocal>
{
    SWRevealViewController *revealController ;
    MyWebServiceHelper *helper;

    NSDictionary*dic;
    NSDictionary*dataDic;
    NSArray*info;
    NSString*detail;


}

@end

@implementation AboutLearningHouse

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.titleLab.text=[historyModel sharedhistoryModel].subcategoryName;
    revealController=[[SWRevealViewController alloc] init];
    self.aboutLHWebView.delegate=self;
    
    [[self.aboutLHWebView layer] setCornerRadius:10];
    [self.aboutLHWebView setClipsToBounds:YES];
    
    // Create colored border using CALayer property
    [[self.aboutLHWebView layer] setBorderColor:
     [[UIColor blackColor] CGColor]];
    [[self.aboutLHWebView layer] setBorderWidth:1];
    [self.aboutLHWebView.scrollView setShowsHorizontalScrollIndicator:NO];

    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    if ([self.aboutROcontect isEqualToString:@"contect"])
    {
        dic=   @{@"area":@"content",@"id_page":@"9",};

    }
    else{
   dic=   @{@"area":@"content",@"id_page":@"8",};
    }
    [self aboutLearningHouse:dic];

    

    // Do any additional setup after loading the view from its nib.
}
-(void)aboutLearningHouse:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    [helper AboutLearningHouse:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"Fatch_AboutLH_info"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"Fatch_AboutLH_info--->,%@",info);
        
        if (info.count>0)
            
        {
            

            dispatch_async(dispatch_get_main_queue(), ^{
                //detail=[[info objectAtIndex:0]objectForKey:@"detail"];

                if ([self.aboutROcontect isEqualToString:@"contect"])
                {
//                     detail =@"<h2>Contact Us</h2>\n<table>\n<tbody>\n<tr>\n<td valign=\"top\" width=\"20%\">\n<div class=\"contactdir\">\n<ul style=\"padding: 0px; margin: 0px;\">\n<li style=\"background-color: #ffffff;\"><a href=\"?area=contactinfo\">Contact Info</a></li>\n<li><a style=\"color: #fff;\" href=\"?area=directions\">Directions</a></li>\n</ul>\n</div>\n</td>\n</tr>\n</tbody>\n</table>\n<h3><span style=\"font-size: 14px;\"><strong>The Learning House</strong></span></h3>\n<table style=\"width: 742px; height: 73px;\" border=\"0\">\n<tbody>\n<tr>\n<td style=\"width: 250px;\">\n<p><span style=\"font-size: 14px;\">Box 333, 410 Cambridge St</span><br /><span style=\"font-size: 14px;\">Goderich, ON</span><br /><span style=\"font-size: 14px;\">N7A 4C6</span></p>\n</td>\n</tr><tr><td style=\"width: 250px;\">\n<p><span style=\"font-size: 14px;\">\n\nPhone:&nbsp;519.524.5607</span><br /><span style=\"font-size: 14px;\">Fax:&nbsp;519.524.4235</span><br /><span style=\"font-size: 14px;\">Toll-free: &nbsp;866.875.5550</span></p>\n</td>\n</tr>\n</tbody>\n</table>\n<p><strong><span style=\"font-size: 14px;\">Hours: Monday to Friday from 9:00 am to 4:30 pm</span></strong></p>\n<p>&nbsp;</p>\n<p><span style=\"font-size: 14px;\"><strong>Accepted Methods of Payment:</strong> Visa, MasterCard, Discover Card, Cheque, Money Order, E-transer, Purchase Order, Cash</span></p>\n<p>&nbsp;</p>";
                    detail=[[info objectAtIndex:0] objectForKey:@"detail"];
                    
                }
                
                else{

//                detail=@"<div style=\"width:100%; float:left; text-align:center;\"><img style=\"margin-right: 0px; width:50%; text-align:center; \" src=\"http://files.learninghouse.ca/media/about01.jpg\" alt=\"\" /></div><h2>About Us</h2>\n<p style=\"text-align: justify;\">The Learning House Inc. is a family owned business providing educational resources to schools, home schools, and parents across Canada. In 1994 Harold and Louise House felt led by the Lord to start a business that would meet the growing need of home educators for quality educational resources in Canada. When the company was founded in 1994 two product lines were featured. By God's grace the company has grown to carry products from over 50 publishers and has access to hundreds more. Incorporated in 2003 The Learning House continues to carry a wide variety of carefully chosen curriculum and educational resources for Pre K through Gr. 12 students.<br /><br />The House family has been home educating their four children since 1990. This experience has provided ample opportunity to explore and evaluate a great many curriculums and resources. The result of these years of experience is seen in The Learning House catalogue printed annually.<br /><br />An unexpected blessing throughout their home school journey has been the privilege of teaching three of their boys who have learning disabilities. This has lead to a number of special resources and a ministry to encourage and equip those who are home schooling in similar circumstances.<br /><br />A yearly highlight continues to be attending conferences across the country where they can meet home schoolers. It is a privilege to serve the home school community in this way. Please stop in and say hello as they enjoy putting a name to a face.<br /><br />Each year The Learning House continues to see the need to strengthen families. They remain committed in their desire to help you build your learning house on the solid rock of Jesus Christ. May the Lord grant you continued strength as you seek to honour Him in your teaching and home experience. May your hearts be turned towards Him to hear His voice and learn the lessons He has for you. God bless you as you teach.</p>\n<p style=\"text-align: justify;\">&nbsp;</p>";
                    detail=[[info objectAtIndex:0] objectForKey:@"detail"];

                }
      
                [self.aboutLHWebView loadHTMLString:detail baseURL:nil];
 
                
                [MyCustomClass SVProgressMessageDismissWithError:@"Loaded" timeDalay:1.0];
                
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
    }
    
    
    
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView1{
    
    int fontSize = 100;
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", fontSize];
    [self.aboutLHWebView stringByEvaluatingJavaScriptFromString:jsString];

    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)backBtn:(id)sender
{
     //[self.backBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
    HomeViewControllerVC.menuString=@"BackLeft";
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];

}
@end
