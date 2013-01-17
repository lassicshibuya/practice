//
//  MyTableViewController.m
//  20130116_firstTask
//
//  Created by 澁谷 円 on 2013/01/16.
//  Copyright (c) 2013年 澁谷 円. All rights reserved.
//

#import "MyTableViewController.h"



@interface MyTableViewController ()
@property (nonatomic, retain) NSMutableArray *dataArray;
@end

@implementation MyTableViewController
@synthesize dataArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)formatDate:(NSDate *) date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit)
                        fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger weekday = [comps weekday];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    NSString *weekdaySymbol = [[formatter shortWeekdaySymbols] objectAtIndex:weekday - 1];
    NSString *weekdayString = [NSString stringWithFormat:@"(%@)", weekdaySymbol];
    NSString *formattedString = [NSString stringWithFormat:
                                 @"%d/0%d/%d%@",year,month,day,weekdayString];
    calendar = nil;
    comps = nil;
    formatter = nil;
    weekdaySymbol = nil;
    weekdayString = nil;
    
    return formattedString;
}


-(NSArray *)calcDate{
    /* 今の時刻を取得する */
    NSDate *now = [NSDate date];
    /* NSCalendarを取得する */
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    /*当月の日数を取得*/
    NSInteger daysOfThisMonth = [calendar
                                 rangeOfUnit:NSDayCalendarUnit
                                 inUnit:NSMonthCalendarUnit
                                 forDate:now ].length;
    
    for (int i=0; i<daysOfThisMonth ; i++) {
        NSDateComponents* components = [calendar components:NSYearCalendarUnit |
                                        NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit
                                                      fromDate:now];
        NSInteger year = components.year;
        NSInteger month = components.month;
        NSInteger day = i+1;
        NSInteger weekday = components.weekday;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        NSString *weekdaySymbol = [[formatter shortWeekdaySymbols] objectAtIndex:weekday - 1];
        NSString *weekdayString = [NSString stringWithFormat:@"(%@)", weekdaySymbol];
        NSString *formattedString = [NSString stringWithFormat:
                                     @"%d/0%d/%d%@",year,month,day,weekdayString];
        calendar = nil;
        components = nil;
        formatter = nil;
        weekdaySymbol = nil;
        weekdayString = nil;

        [self.dataArray addObject:formattedString];
    }
    [self.dataArray addObject:nil];
//    for(int i = 0; i < [dataArray count]; i++){
//        NSLog(@"%@", [dataArray objectAtIndex: (NSUInteger) i]);
//    }
    return dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self calcDate];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"tableData" ofType:@"plist"];
//	self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"basic-cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(nil == cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDate* date = [NSDate date];
    NSString* fDate = [self formatDate:date];
    if ([[dataArray objectAtIndex:indexPath.row]isEqualToString:fDate]) {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor orangeColor];
        cell.contentView.backgroundColor = [UIColor orangeColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    UIView *view = [[UIView alloc ]init];
    view.backgroundColor = [UIColor greenColor];
    cell.selectedBackgroundView = view;

    return cell;
}
#pragma mark - Table view delegate


@end
