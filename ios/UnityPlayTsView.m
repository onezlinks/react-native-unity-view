#import "UnityPlayTsView.h"
#import "UnityPlayTs.h"

NSDictionary* appLaunchOpts;

@implementation UnityPlayTsView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _uView = [[[UnityPlayTs launchWithOptions:appLaunchOpts] appController] rootView];
        [FrameworkLibAPI registerAPIforNativeCalls:self];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_uView removeFromSuperview];
    _uView.frame = self.bounds;
    [self insertSubview:_uView atIndex:0];
}

- (void)dealloc
{
    UIWindow * main = [[[UIApplication sharedApplication] delegate] window];
    if(main != nil) {
        [main makeKeyAndVisible];
        [[UnityPlayTs ufw] unloadApplication];
    }
}

+ (void)UnityPostMessage:(NSString*)gameObject methodName:(NSString*)methodName message:(NSString*) message {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UnityPlayTs ufw] sendMessageToGOWithName:[gameObject UTF8String] functionName:[methodName UTF8String] message:[message UTF8String]];
    });
}

- (void)sendMessageToMobileApp:(NSString *)message {
    if (self.onUnityMessage) {
        NSDictionary* data = @{
            @"message": message
        };

        self.onUnityMessage(data);
    }
}

@end
