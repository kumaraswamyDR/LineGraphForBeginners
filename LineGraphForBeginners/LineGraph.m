//
//  LineGraph.m
//  LineGraphForBeginners
//
//  Created by Kumaraswamy D R on 27/07/16.
//  Copyright © 2016 TechLeraner. All rights reserved.
//

#import "LineGraph.h"
#import "GraphDataObject.h"
#define GRAPH_STARTING_X   self.frame.size.width*0.1
#define GRAPH_ENDING_X     self.frame.size.width*0.95
#define GRAPH_STARTING_Y   self.frame.size.height*0.8
#define GRAPH_ENDING_Y     self.frame.size.height*0.15

@interface LineGraph()
@property (nonatomic,strong) UIBezierPath     *graphPath;
@property (nonatomic,strong) CAShapeLayer     *graphLayer;
@property (nonatomic,strong) NSArray          *dataArray;
@property (nonatomic)        float            maxTotalValue;
@property (nonatomic,strong) CABasicAnimation *animation;
@end

@implementation LineGraph

- (instancetype)initWithDataArray:(NSArray *)dataArray
{
    self = [super init];
    if (self)
    {
        self.backgroundColor= [UIColor colorWithRed:173/255.0 green:217/255.0 blue:230/255.0 alpha:1];
        _dataArray = dataArray;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    _graphPath = [UIBezierPath bezierPath];
    _graphPath.lineWidth=2;
    
    _graphLayer = [CAShapeLayer layer];
    [_graphLayer setStrokeColor:[UIColor redColor].CGColor];
    _graphLayer.fillColor = [UIColor clearColor].CGColor;
    _graphLayer.lineWidth=2;
    _graphLayer.path = _graphPath.CGPath;
    [self.layer addSublayer:_graphLayer];
    _maxTotalValue = [[_dataArray valueForKeyPath:@"@max.value"] floatValue];
    [self creaeLineGraph];
}
-(void)creaeLineGraph
{
    [_graphPath moveToPoint:CGPointMake(GRAPH_STARTING_X, GRAPH_STARTING_Y)];
    for (GraphDataObject *data in _dataArray)
    {
        [_graphPath addLineToPoint:[self generatePlotPointBasedOnDataValue:data.value andPosition:data.position]];
    }
    _graphLayer.path = _graphPath.CGPath;
    _animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _animation.duration = 3.0;
    _animation.fromValue = @(0.0f);
    _animation.toValue = @(1.0f);
    [self.graphLayer addAnimation:_animation forKey:@"strokeEnd"];
   
    
    
}
-(CGPoint)generatePlotPointBasedOnDataValue:(float)value andPosition:(int)position
{
    float graphHeight = GRAPH_STARTING_Y - GRAPH_ENDING_Y;
    NSLog(@"value position %f %d",value,position);
    float space = (GRAPH_ENDING_X-GRAPH_STARTING_X)/_dataArray.count;
    CGPoint graphpoint;
    graphpoint.x = (position * space) + GRAPH_STARTING_X;
    graphpoint.y = ((graphHeight-((graphHeight/_maxTotalValue)* value))  + GRAPH_ENDING_Y);
    NSLog(@"graphpoint x %f",graphpoint.x);
     NSLog(@"graphpoint y %f",graphpoint.y);
    return graphpoint;
    
    
}
@end
