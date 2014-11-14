//
//  ViewController.h
//  PNRStatusCheck
//
//  Copyright (c) 2014 PunitShah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UITextView *tvPNRNumber;
@property (weak, nonatomic) IBOutlet UITextView *tvTrainName;
@property (weak, nonatomic) IBOutlet UITextView *tvTravelDate;
@property (weak, nonatomic) IBOutlet UITextView *tvFrom;
@property (weak, nonatomic) IBOutlet UITextView *tvTo;
@property (weak, nonatomic) IBOutlet UITextView *tvClass;
@property (weak, nonatomic) IBOutlet UITextView *tvChartStatus;
@property (weak, nonatomic) IBOutlet UITextField *etSearchPNR;
@property (weak, nonatomic) IBOutlet UIButton *btnGetPNR;


@end
