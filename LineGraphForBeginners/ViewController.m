//
//  ViewController.m
//  LineGraphForBeginners
//
//  Created by Kumaraswamy D R on 25/07/16.
//  Copyright © 2016 TechLeraner. All rights reserved.
//

#import "ViewController.h"
#import "GraphDataObject.h"
#import "LineGraph.h"
@interface ViewController ()
@property(nonatomic,strong) LineGraph *lineGraph;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor ];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for (int i=1 ; i<=25; i++)
    {
        GraphDataObject *graphDataObject = [[GraphDataObject alloc]init];
        graphDataObject.value =rand()%100;
        graphDataObject.position = i;
        [dataArray addObject:graphDataObject];
        
         _lineGraph = [[LineGraph alloc]initWithDataArray:dataArray];
        [self.view addSubview:_lineGraph];
        
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    _lineGraph.frame = self.view.frame;
}
@end
