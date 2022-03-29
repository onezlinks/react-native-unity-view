#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import <UnityPlayTsView.h>

@interface UnityPlayTsViewManager : RCTViewManager
@end

@implementation UnityPlayTsViewManager

RCT_EXPORT_MODULE(UnityPlayTsView)
RCT_EXPORT_VIEW_PROPERTY(onUnityMessage, RCTBubblingEventBlock)

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onUnityMessage"];
}

- (UIView *)view
{
    UnityPlayTsView *unity = [UnityPlayTsView new];
    UIWindow * main = [[[UIApplication sharedApplication] delegate] window];

    if(main != nil) {
        [main makeKeyAndVisible];
    }

    return unity;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_METHOD(postMessage:(nonnull NSNumber*) reactTag gameObject:(NSString*_Nonnull) gameObject methodName:(NSString*_Nonnull) methodName message:(NSString*_Nonnull) message) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        UnityPlayTsView *view = (UnityPlayTsView*) viewRegistry[reactTag];
        if (!view || ![view isKindOfClass:[UnityPlayTsView class]]) {
            RCTLogError(@"Cannot find NativeView with tag #%@", reactTag);
            return;
        }
        [UnityPlayTsView UnityPostMessage:(NSString *)gameObject methodName:(NSString *)methodName message:(NSString *)message];
    }];
}

@end
