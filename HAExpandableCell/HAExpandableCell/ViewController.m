//
//  ViewController.m
//  cellMaxMinDemo
//
//  Created by Sugartin on 20/11/15.
//  Copyright © 2015 Sugartin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *dTmp = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    self.arrayOriginal = [dTmp valueForKey:@"Objects"];
    
    self.arForTable = [[NSMutableArray alloc] init];
    [self.arForTable addObjectsFromArray:self.arrayOriginal];
    self.title=@"Sugartin.info";
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arForTable count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text=[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"name"];
    [cell setIndentationLevel:[[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *d=[self.arForTable objectAtIndex:indexPath.row];
    if([d valueForKey:@"Objects"]) {
        NSArray *ar=[d valueForKey:@"Objects"];
        
        BOOL isAlreadyInserted=NO;
        
        for(NSDictionary *dInner in ar ){
            NSInteger index=[self.arForTable indexOfObjectIdenticalTo:dInner];
            isAlreadyInserted=(index>0 && index!=NSIntegerMax);
            if(isAlreadyInserted) break;
        }
        
        if(isAlreadyInserted) {
            [self miniMizeThisRows:ar];
        } else {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arCells=[NSMutableArray array];
            for(NSDictionary *dInner in ar ) {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.arForTable insertObject:dInner atIndex:count++];
            }
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

-(void)miniMizeThisRows:(NSArray*)ar{
    
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[self.arForTable indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"Objects"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        
        if([self.arForTable indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [self.arForTable removeObjectIdenticalTo:dInner];
            [self.tblForCollapse deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                    [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                    ]
                                  withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
