//
//  EventsViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/11/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()<WebServiceResponseProtocal>
{
   // NSInteger selectedIndexPath;
    NSInteger row;
    MyWebServiceHelper *helper;

     NSMutableArray *boolArray,*arrayForBool;
    EventCellTableViewCell*cellAttachment;
   int sectionIndex;
    NSDictionary*dic;
    NSArray*info;
    BOOL boolString;
    EventCellTableViewCell*event;
    NSIndexPath *indexPath1 ;
    NSInteger sectinnumber;
}

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.eventTable.delegate=self;
    self.eventTable.dataSource=self;
    event=[[EventCellTableViewCell alloc]init];
    
    arrayForBool =[[NSMutableArray alloc] init];
    dic=  @{@"action":@"event_list",};

    [self eventData:dic];

  }

-(void)fillsplitArray
{
    [arrayForBool removeAllObjects];
    if (arrayForBool)
    {

        for (int i = 0; i < [info count]; i++)
        {
            NSString *arrayString;
            arrayString= [[info objectAtIndex:0] objectForKey:@"date_post"];
           if (![arrayString isEqualToString:@""])
           {
               [arrayForBool addObject:@"NO"];

           }

            
        }
        [arrayForBool insertObject:@"YES" atIndex:0];
        [arrayForBool removeLastObject];
            

    }
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
        NSLog(@"loginApi--->,%@",info);
        if (info.count>0)
        {
            [self fillsplitArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.eventTable reloadData];
                [historyModel sharedhistoryModel].eventData=info;
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:3.0];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrayForBool count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL Iscollapsed  = [[arrayForBool objectAtIndex:section] boolValue];
    if (Iscollapsed==YES)
    {
     return  [[[[info objectAtIndex:section] objectForKey:@"aArticleList"]valueForKey:@"title"] count];
    }
    else
    {
        return 0;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"EventCellTableViewCell";
    cellAttachment = (EventCellTableViewCell *)[self.eventTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"EventCellTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
    }
    self.eventTable.allowsSelection = NO;
    

        [cellAttachment.eventDetalBtn addTarget:self
                                     action:@selector(eventAction:)
       forControlEvents:UIControlEventTouchUpInside];
    cellAttachment.eventDetalBtn.tag=indexPath.row;
   
    if (indexPath.section==sectinnumber)
    {
        cellAttachment.titleLab.text= [[[[info objectAtIndex:indexPath.section] valueForKey:@"aArticleList"]valueForKey:@"title"]objectAtIndex:indexPath.row];
        NSString *str = [[[[info objectAtIndex:indexPath.section] valueForKey:@"aArticleList"]valueForKey:@"date_post"]objectAtIndex:indexPath.row];
        NSString *mySmallerString = [str substringWithRange: NSMakeRange (8,2)];
        NSLog(@"mySmallerString,%@",mySmallerString);
        
      //  NSString *firstLetter = [mySmallerString substringFromIndex:1];
        if ([mySmallerString hasPrefix:@"0"])
        {
        NSString*final=[mySmallerString substringFromIndex:1];
            cellAttachment.dateLab.text=final;
        }
        else
        {
            cellAttachment.dateLab.text=mySmallerString ;
        }

    }
    return  cellAttachment;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue])
    {
        return 91;
    }
    else
    {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    sectinnumber=gestureRecognizer.view.tag;

    indexPath1 = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    
    if (indexPath1.row == 0)
    {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath1.section] boolValue];
        
        collapsed       = !collapsed;
        
        for (int i=0; i<arrayForBool.count; i++)
        {
            [arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
        }
        [arrayForBool replaceObjectAtIndex:indexPath1.section withObject:[NSNumber numberWithBool:collapsed]];
        sectionIndex = (int)indexPath1.section;
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath1.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
      [self.eventTable reloadData];
    [self.eventTable reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
     
    }
   // [self.eventTable reloadData];

}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
    
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, self.view.frame.size.width, 46)];
    headerView.tag = section;
    
    headerView.backgroundColor= [UIColor whiteColor];
    UILabel *headerString = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, self.view.frame.size.width-20, 46)];
    headerString.textColor = [UIColor whiteColor];
    
    UIImageView *headerBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    headerBackground.image =  [UIImage imageNamed:@"header"];
    
    [headerView addSubview:headerBackground];
    BOOL manyCells = [[arrayForBool objectAtIndex:section] boolValue];
        headerString.text = [[info objectAtIndex:section] objectForKey:@"post_date"];

    headerString.textAlignment =  NSTextAlignmentLeft;
    [headerView addSubview:headerString];
    //[headerView setBackgroundColor:[UIColor colorWithRed:68/255.0 green:212.0/255.0 blue:255.0/255.0 alpha:1.0]];
    
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    //[event.innerTable reloadData];
    //up or down arrow depending on the bool
    BOOL Iscollapsed  = [[arrayForBool objectAtIndex:section] boolValue];
    
    UIImageView *upDownArrow;
    if (Iscollapsed==YES)

    {
        upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"up.img"] : [UIImage imageNamed:@"up.img"]];
    }
    else
    {
        upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"down.img"] : [UIImage imageNamed:@"down.img"]];
        
    }
    upDownArrow.contentMode=UIViewContentModeScaleAspectFit;
   // upDownArrow.backgroundColor =[UIColor colorWithRed:68/255.0 green:212.0/255.0 blue:255.0/255.0 alpha:1.0];
    upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
    upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, 20, 20, 15);
    
    [headerView addSubview:upDownArrow];

    
    //up or down arrow depending on the bool
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrayForBool objectAtIndex:section];
}

- (IBAction)backBtn:(id)sender {
    HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
    HomeViewControllerVC.menuString=@"BackLeft";
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
}
-(void)eventAction:(id)sender
{
    EventDetailViewController*EventDetailVC=[[EventDetailViewController alloc]init];
    [self.navigationController pushViewController:EventDetailVC animated:NO];
    EventDetailVC.eventTitle=[[[[info objectAtIndex:indexPath1.section] valueForKey:@"aArticleList"]valueForKey:@"title"]objectAtIndex:[sender tag]];
    EventDetailVC.idAarticle=[[[[info objectAtIndex:indexPath1.section] valueForKey:@"aArticleList"]valueForKey:@"id_article"]objectAtIndex:[sender tag]];
}
@end
