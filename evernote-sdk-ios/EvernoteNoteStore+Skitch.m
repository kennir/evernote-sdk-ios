/*
 * EvernoteNoteStore+Skitch.m
 * evernote-sdk-ios
 *
 * Copyright 2012 Evernote Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "EvernoteNoteStore+Skitch.h"

@implementation EvernoteNoteStore (Skitch)


#pragma mark - Skitch functions

- (void)skitchImage:(NSString*)filePath {
    NSError* error = nil;
    SKNewSkitchRequest *newSkitch = [[SKNewSkitchRequest alloc] initWithContentsOfFile:filePath];
    SKBridgeReceipt *receipt = [[SKBridgeReceipt alloc] init];
    NSString* skitchScheme = [NSString stringWithFormat:@"en-%@://skitch/",[[EvernoteSession sharedSession] consumerKey]];
    receipt.callbackURL = [NSURL URLWithString:skitchScheme];
    newSkitch.receipt = receipt;
    [[SKApplicationBridge sharedSkitchBridge] performRequest:newSkitch error:&error];
    if(error) {
        if([[[EvernoteSession sharedSession] skitchDelegate] respondsToSelector:@selector(errorFromSkitch:)]) {
            [[[EvernoteSession sharedSession] skitchDelegate] errorFromSkitch:error];
        }
    }
}

- (void)skitchWithData:(NSData*)fileData withMimeType:(NSString*)mimeType {
    NSError* error = nil;
    SKNewSkitchRequest *newSkitch = [[SKNewSkitchRequest alloc] init];
    SKBridgeReceipt *receipt = [[SKBridgeReceipt alloc] init];
    [newSkitch setData:fileData];
    [newSkitch setMime:mimeType];
    NSString* skitchScheme = [NSString stringWithFormat:@"en-%@://skitch/",[[EvernoteSession sharedSession] consumerKey]];
    receipt.callbackURL = [NSURL URLWithString:skitchScheme];
    newSkitch.receipt = receipt;
    [[SKApplicationBridge sharedSkitchBridge] performRequest:newSkitch error:&error];
    if(error) {
        if([[[EvernoteSession sharedSession] skitchDelegate] respondsToSelector:@selector(errorFromSkitch:)]) {
            [[[EvernoteSession sharedSession] skitchDelegate] errorFromSkitch:error];
        }
    }
}

- (void)viewSkitchWithGUID:(NSString*)guid {
    NSError* error = nil;
    SKViewSkitchRequest* viewSkitch = [[SKViewSkitchRequest alloc] init];
    [viewSkitch setSkitchGUID:guid];
    [[SKApplicationBridge sharedSkitchBridge] performRequest:viewSkitch error:&error];
    if(error) {
        if([[[EvernoteSession sharedSession] skitchDelegate] respondsToSelector:@selector(errorFromSkitch:)]) {
            [[[EvernoteSession sharedSession] skitchDelegate] errorFromSkitch:error];
        }
    }
}

@end
