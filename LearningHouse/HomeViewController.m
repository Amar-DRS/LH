//
//  HomeViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 7/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImageView+WebCache.h"



@interface HomeViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSMutableDictionary *dataDic;
    NSArray *featuredArray;
    NSArray*topSellersProductArray;
    NSArray*latestProductArray;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden=YES;
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

    
    if ([self.menuString isEqualToString:@"BackLeft"])
    {
        [revealController revealToggle:self];
    }
    if ([self.menuString isEqualToString:@"BackRigth"])
    {
    
        [revealController rightRevealToggle:self];
        

    }


     [self.menuBtn addTarget:revealController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
         [self.leftMenuBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
   revealController.panGestureRecognizer.enabled = YES;

    
    [self.featuredProductCollectionView registerNib:[UINib nibWithNibName:@"featuredProduct" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.topSellerCollectionView registerNib:[UINib nibWithNibName:@"topSellers" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    
    
    [self.latestProductCollectionView registerNib:[UINib nibWithNibName:@"Latestproduct" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    
    self.landingScrollViwe.delegate=self;
    self.landingScrollViwe.contentSize = CGSizeMake(320, 1000);
    self.landingScrollViwe.scrollEnabled = YES;

    
    self.featuredProductCollectionView.delegate=self;
    self.featuredProductCollectionView.dataSource=self;
    
    self.topSellerCollectionView.delegate=self;
    self.topSellerCollectionView.dataSource=self;
    
    
    self.latestProductCollectionView.delegate=self;
    self.latestProductCollectionView.dataSource=self;
    
    self.featuredProductCollectionView.tag=101;
    self.topSellerCollectionView.tag=102;
    self.latestProductCollectionView.tag=103;
    

    [self.firstSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.secondSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.thirdSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.firstSlider addTarget:self action:@selector(sliderActionFirst:) forControlEvents:UIControlEventValueChanged];
    [self.secondSlider addTarget:self action:@selector(sliderActionSecond:) forControlEvents:UIControlEventValueChanged];
     [self.thirdSlider addTarget:self action:@selector(sliderActionThird:) forControlEvents:UIControlEventValueChanged];
    self.firstSlider.minimumValue = 0.0;
    // self.firstSlider.continuous = YES;
    self.firstSlider.maximumValue = [featuredArray count]-1;
    self.firstSlider.value = 0.0;
    self.secondSlider.minimumValue = 0.0;
    self.secondSlider.maximumValue = [topSellersProductArray count]-1;
    self.secondSlider.value = 0.0;
    self.thirdSlider.minimumValue = 0.0;
    self.thirdSlider.maximumValue = [latestProductArray count]-1;
    self.thirdSlider.value = 0.0;


    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
          NSString*  savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
      NSString *CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
    
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }
    
    dic=@{@"id_customer":savedValue,@"CookieCart":CookieCartID,};
    [self homeApi:dic];
    
}


-(void)sliderActionFirst:(id)sender
{
    
    NSLog(@"sender slider value>>%f",[(UISlider *)sender value]);
    
    if ([(UISlider *)sender value]<=[featuredArray count]-1)
    {
        NSIndexPath* indexPath1 = [NSIndexPath indexPathForItem:[(UISlider *)sender value] inSection:0];
        [self.featuredProductCollectionView selectItemAtIndexPath:indexPath1 animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}
-(void)sliderActionSecond:(id)sender
{
    
    NSLog(@"sender slider value>>%f",[(UISlider *)sender value]);
    
    if ([(UISlider *)sender value]<=[topSellersProductArray count]-1)
    {
        NSIndexPath* indexPath1 = [NSIndexPath indexPathForItem:[(UISlider *)sender value] inSection:0];
        [self.topSellerCollectionView selectItemAtIndexPath:indexPath1 animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}
-(void)sliderActionThird:(id)sender
{
    
    NSLog(@"sender slider value>>%f",[(UISlider *)sender value]);
    
    if ([(UISlider *)sender value]<=[latestProductArray count]-1)
    {
        NSIndexPath* indexPath1 = [NSIndexPath indexPathForItem:[(UISlider *)sender value] inSection:0];
        [self.latestProductCollectionView selectItemAtIndexPath:indexPath1 animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}
-(void)homeApi:(NSDictionary*)dataString
{
   [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
        [helper getHomeData:dataString];
   
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    NSString *someString = [NSString stringWithFormat:@"%@", [dataDic objectForKey:@"TotalCartItems"]];

    if([apiName isEqualToString:@"Fatch_HomeScreen_info"])
    {
        
        featuredArray = [dataDic objectForKey:@"featuredProduct"];
        topSellersProductArray=[dataDic objectForKey:@"topSellersProduct"];
        latestProductArray=[dataDic objectForKey:@"latestProduct"];
        [historyModel sharedhistoryModel].rigthMenuArray=[dataDic objectForKey:@"leftMenuCategory"];
        if (featuredArray.count>0)
            
            
    {
        
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cartItemLab.text=someString;

                [self.featuredProductCollectionView reloadData];
                [self.topSellerCollectionView reloadData];
                [self.latestProductCollectionView reloadData];
                self.firstSlider.maximumValue =[featuredArray count]-1;
                self.secondSlider.maximumValue =[topSellersProductArray count]-1;
                self.thirdSlider.maximumValue =[latestProductArray count]-1;
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"Loaded" timeDalay:1.0];

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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSUInteger collectionRow = 0;
    if (collectionView.tag==101)
    {
        collectionRow= [featuredArray count];

    }
    if (collectionView.tag==102)
    {
        collectionRow= [topSellersProductArray count];

    }
    if (collectionView.tag==103)
    {
        collectionRow= [latestProductArray count];
        
    }

    return collectionRow;
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return (collectionView.tag == 101?CGSizeMake(90,165):(collectionView.tag == 102?CGSizeMake(90,165):CGSizeMake(90,165)));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    featuredProduct *cell;
    topSellers*cell1;
    Latestproduct*cell2;
    if(collectionView.tag==101)
    {
cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        NSString*jpg=@"sm.jpg";
        NSString * urlString = [NSString stringWithFormat:@"https://www.learninghouse.ca/media/product-photos_new/%@_%@",[[[featuredArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString],jpg];

            NSURL *imageUrl = [NSURL URLWithString:urlString];
        [cell.featuredimage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
        cell.featuredtitleLab.text=[NSString stringWithFormat:@"%@",[[featuredArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    }
    if (collectionView.tag==102)
    {
    cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        
        NSString*jpg=@"sm.jpg";
        NSString * urlString = [NSString stringWithFormat:@"https://www.learninghouse.ca/media/product-photos_new/%@_%@",[[[topSellersProductArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString],jpg];
        
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [cell1.topSellerImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
        cell1.topSellersTitlelab.text=[NSString stringWithFormat:@"%@",[[topSellersProductArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    }
    if (collectionView.tag==103)
    {
        cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        NSString*jpg=@"sm.jpg";
        NSString * urlString = [NSString stringWithFormat:@"https://www.learninghouse.ca/media/product-photos_new/%@_%@",[[[latestProductArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString],jpg];
        
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [cell2.lastProductImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
        cell2.LatestproductTitlelab.text=[NSString stringWithFormat:@"%@",[[latestProductArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    }

    return (collectionView.tag == 101?cell:(collectionView.tag == 102?cell1:cell2));

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"item clicked");
    //dic=@{@"id_customer":@"",@"id_product":self.productId,@"area":@"product",@"mode":@"productdetail"};
    if (collectionView.tag==101)
    {
        NSLog(@"101");
        ProductAllDetailViewController*ProductAllDetailVC=[[ProductAllDetailViewController alloc]init];
        [self.navigationController pushViewController:ProductAllDetailVC animated:YES];
        ProductAllDetailVC.productId=[[featuredArray objectAtIndex:indexPath.row] objectForKey:@"product_id"];
        ProductAllDetailVC.imageCode=[[[featuredArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString];

    }
    else  if (collectionView.tag==102)
    {
        NSLog(@"102");
        ProductAllDetailViewController*ProductAllDetailVC=[[ProductAllDetailViewController alloc]init];
        [self.navigationController pushViewController:ProductAllDetailVC animated:YES];
        ProductAllDetailVC.productId=[[topSellersProductArray objectAtIndex:indexPath.row] objectForKey:@"product_id"];
        ProductAllDetailVC.imageCode=[[[topSellersProductArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString];

    }
    else  if (collectionView.tag==103)
    {
        NSLog(@"103");
        ProductAllDetailViewController*ProductAllDetailVC=[[ProductAllDetailViewController alloc]init];
        [self.navigationController pushViewController:ProductAllDetailVC animated:YES];
        ProductAllDetailVC.productId=[[latestProductArray objectAtIndex:indexPath.row] objectForKey:@"product_id"];
        ProductAllDetailVC.imageCode=[[[latestProductArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString];

    }
    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)featureProductAllDetail:(id)sender
{
    ViewAllViewController*ViewAllVC=[[ViewAllViewController alloc]init];
    [self.navigationController pushViewController:ViewAllVC animated:YES];
    ViewAllVC.titleStr=@"Featured Product";
    ViewAllVC.area=@"featuredProduct";
    
}

- (IBAction)topSellerProductAllDetail:(id)sender
{
    ViewAllViewController*ViewAllVC=[[ViewAllViewController alloc]init];
    [self.navigationController pushViewController:ViewAllVC animated:YES];
    ViewAllVC.titleStr=@"Top Sellers";
    ViewAllVC.area=@"topSellersProduct";
}
- (IBAction)latestProductAllDetail:(id)sender
{
    ViewAllViewController*ViewAllVC=[[ViewAllViewController alloc]init];
    [self.navigationController pushViewController:ViewAllVC animated:YES];
    ViewAllVC.titleStr=@"Latest Products";
    ViewAllVC.area=@"latestProduct";
}

- (IBAction)ShowCartData:(id)sender {
    
    AddToCartViewController*AddToCartVC=[[AddToCartViewController alloc]init];
    [self.navigationController pushViewController:AddToCartVC animated:NO];
    AddToCartVC.backController=@"home";
    
}
- (IBAction)searchBtn:(id)sender {
    HomeSearchViewController*HomeSearchVC=[[HomeSearchViewController alloc]init];
    [self.navigationController pushViewController:HomeSearchVC animated:NO];
}

@end
