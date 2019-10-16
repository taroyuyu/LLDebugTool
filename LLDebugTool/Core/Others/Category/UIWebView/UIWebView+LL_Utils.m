//
//  UIWebView+LL_Utils.m
//
//  Copyright (c) 2018 LLDebugTool Software Foundation (https://github.com/HDB-Li/LLDebugTool)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UIWebView+LL_Utils.h"
#import "NSObject+LL_Runtime.h"
#import "LLNetworkHelper+UIWebView.h"

@implementation UIWebView (LL_Utils)

+ (void)load {
    [self LL_swizzleInstanceMethodWithOriginSel:@selector(setDelegate:) swizzledSel:@selector(LL_setDelegate:)];
    [self LL_swizzleInstanceMethodWithOriginSel:@selector(delegate) swizzledSel:@selector(LL_delegate)];
}

- (void)LL_setDelegate:(id<UIWebViewDelegate>)delegate {
    [self setLL_realDelegate:delegate];
    [self LL_setDelegate:[LLNetworkHelper shared]];
}

- (id<UIWebViewDelegate>)LL_delegate {
    return [self LL_realDelegate];
}

#pragma mark - Getters and setters
- (void)setLL_realDelegate:(id<UIWebViewDelegate>)LL_realDelegate {
    objc_setAssociatedObject(self, @selector(LL_realDelegate), LL_realDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UIWebViewDelegate>)LL_realDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

@end
