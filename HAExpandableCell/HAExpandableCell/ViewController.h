//
//  ViewController.h
//  cellMaxMinDemo
//
//  Created by Sugartin on 20/11/15.
//  Copyright © 2015 Sugartin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITableView *tblForCollapse;
@property (nonatomic, retain) NSArray *arrayOriginal;
@property (nonatomic, retain) NSMutableArray *arForTable;

-(void)miniMizeThisRows:(NSArray*)ar;


@end

