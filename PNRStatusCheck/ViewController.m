//
//  ViewController.m
//  PNRStatusCheck
//
//  Copyright (c) 2014 PunitShah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self mytableView]setDelegate:self];
    [[self mytableView]setDataSource:self];
    array = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Fail with Error");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *data = [allDataDictionary objectForKey:@"data"];
    NSArray *arrayOfEntry = [data objectForKey:@"passenger"];
    
    
    
    _tvPNRNumber.text=[@"PNR Number: " stringByAppendingString:[data objectForKey:@"pnr_number"]];
    
    
    NSString *trainNameNum=[@"Train Name: " stringByAppendingString:[data objectForKey:@"train_name"]];
    
    trainNameNum=[trainNameNum stringByAppendingString:@" ("];
    trainNameNum=[trainNameNum stringByAppendingString:[data objectForKey:@"train_number"]];
    _tvTrainName.text=[trainNameNum stringByAppendingString:@" )"];
    
    NSDictionary *travelDate = [data objectForKey:@"travel_date"];
    
    _tvTravelDate.text=[@"Travel Date: " stringByAppendingString:[travelDate objectForKey:@"date"]];
    
    NSDictionary *from = [data objectForKey:@"from"];
    
    _tvFrom.text=[@"From: " stringByAppendingString:[from objectForKey:@"name"]];
    
    NSDictionary *to = [data objectForKey:@"to"];
    _tvTo.text=[@"To: " stringByAppendingString:[to objectForKey:@"name"]];
    
    
    _tvClass.text=[@"Class: " stringByAppendingString:[data objectForKey:@"class"]];
    
    if([data objectForKey:@"chart_prepared"])
        _tvChartStatus.text=[@"Chart Status: " stringByAppendingString:@"Chart Prepared"];
    else
        _tvChartStatus.text=[@" Chart Status" stringByAppendingString:@" Chart Not Prepared"];
    for(NSDictionary *diction in arrayOfEntry)
    {
        
        //NSDictionary *title = [diction objectForKey:@"seat_number"];
        NSString *label = [diction objectForKey:@"status"];
        label=[label stringByAppendingString:@"  ,  "];
        label=[label stringByAppendingString:[diction objectForKey:@"seat_number"]];
        
        
        [array addObject:label];
    }
    [[self mytableView]reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}


- (IBAction)GetPNRStatus:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://punitshah.net63.net/pnr"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection) {
        webData = [[NSMutableData alloc]init];
    }
}

@end
