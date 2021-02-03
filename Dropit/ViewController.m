//
//  ViewController.m
//  Dropit
//
//  Created by akhil.y on 03/02/21.
//

#import "ViewController.h"
#import "DropitBehaviour.h"

@interface ViewController ()<UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animate;
@property (strong, nonatomic) DropitBehaviour *dropitBehaviour;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIDynamicAnimator *) animate
{
    if(!_animate)
    {
        _animate = [[UIDynamicAnimator alloc]initWithReferenceView:self.gameView];
    }
    return _animate;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animate
{
    [self removeCompletedRows];
}

- (BOOL)removeCompletedRows
{
    
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc]init];
    for(CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height/2; y>0 ; y -= DROP_SIZE.height)
    {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc]init];
        for(CGFloat x=DROP_SIZE.width/2; x <= self.gameView.bounds.size.width - DROP_SIZE.width/2; x += DROP_SIZE.width)
        {
            UIView *hitview = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if( [hitview superview] == self.gameView)
            {
                [dropsFound addObject: hitview];
            }
            else
            {
                rowIsComplete = NO;
                break;
            }
        }
        if(![dropsFound count])
        {
            break;
        }
        if(rowIsComplete)
        {
            [dropsToRemove addObjectsFromArray:dropsFound];
        }
    }
    if([dropsToRemove count])
    {
        for(UIView *drop in dropsToRemove)
        {
            [self.dropitBehaviour removeItem:drop];
        }
        [self animateRemovingDrops:dropsToRemove];
    }
    
    return NO;
}

- (void) animateRemovingDrops:(NSArray *) dropsToRemove
{
    [UIView animateWithDuration:1.0 animations:^{
        for(UIView * drop in dropsToRemove)
        {
            int x = (arc4random() % (int)self.gameView.bounds.size.width * 5) - (int)self.gameView.bounds.size.width * 2;
            int y = self.gameView.bounds.size.height;
            drop.center = CGPointMake(x, -y);
            
            
        }
    }
    completion:^(BOOL finished)
    {
        [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
     
     ];
    
}

- (DropitBehaviour *)dropitBehaviour
{
    if(!_dropitBehaviour)
    {
        _dropitBehaviour = [[DropitBehaviour alloc]init];
        [self.animate addBehavior:_dropitBehaviour];
    }
    return _dropitBehaviour;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    [self drop];
}

static const CGSize DROP_SIZE = {50, 50};

- (void) drop
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random() % (int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc]initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    
    [self.dropitBehaviour  addItem:dropView];

    
}
- (UIColor *)randomColor
{
    switch (arc4random()%5) {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    return [UIColor blackColor];
}
@end
