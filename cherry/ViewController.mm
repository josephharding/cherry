#import "ViewController.h"
#include "game.h"

@interface ViewController () {
}

@property (strong, nonatomic) EAGLContext *context;

- (void)setupGL;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"myFile" ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    // maybe for debugging...
    NSLog(@"contents: %@", fileContents);
    
    NSArray *listArray = [fileContents componentsSeparatedByString:@"\n"];
    NSLog(@"items = %lu", (unsigned long)[listArray count]);
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
}

static CGPoint getNormalizedPoint(UIView* view, CGPoint locationInView)
{
    const float normalizedX = (locationInView.x / view.bounds.size.width) * 2.f - 1.f;
    const float normalizedY = -((locationInView.y / view.bounds.size.height) * 2.f - 1.f);
    return CGPointMake(normalizedX, normalizedY);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch* touchEvent = [touches anyObject];
    CGPoint locationInView = [touchEvent locationInView:self.view];
    CGPoint normalizedPoint = getNormalizedPoint(self.view, locationInView);
    NSLog(@"touched x: %f, y:%f", normalizedPoint.x, normalizedPoint.y);
    on_touch(normalizedPoint.x, normalizedPoint.y);
}

- (void)dealloc
{
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    on_surface_created();
    on_surface_changed();
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    on_draw_frame();
}

@end
