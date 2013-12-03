//
//  ViewController.m
//  Ping
//
//  Created by zhangjunbiao on 13-11-25.
//  Copyright (c) 2013年 zhangjunbiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)pingFrom:(int) from andEnd:(int) end
{
    
    NSArray* paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* pt = [paths objectAtIndex:0];
    
    //__block BOOL fill[256]  = {NO};
    
    for (int i = from ;i<end;i++)
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSString* filePath = [NSString stringWithFormat:@"%@/%d.txt",pt,i];
            
            NSString* cmd = [NSString stringWithFormat:@"ping -c 1 192.168.1.%d > '%@'",i,filePath];
            
            NSLog(@"cmd -->%d",i);
            system([cmd UTF8String]);
            
            NSString * content = [[NSString  alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            if ([content rangeOfString:@"time"].location != NSNotFound)
            {
               // fill[i] = YES;
                
                NSLog(@"The %d is found",i);
            }

        });
        
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    [self pingFrom:1 andEnd:100];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
