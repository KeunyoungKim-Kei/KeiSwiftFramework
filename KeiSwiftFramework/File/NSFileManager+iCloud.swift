//
//  NSFileManager+iCloud.swift
//
//  Copyright (c) 2016 Keun young Kim <app@meetkei.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public extension FileManager{
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Prevent files from being backed up to iCloud and iTunes
    
    /**
     Sets given URL’s resource property for NSURLIsExcludedFromBackupKey key to true. It throws an error in cases of failure.
     
     - Parameter url: A file URL specifying the file or directory to set
     */
    public func addSkipBackupAttributeToItemAtURLOrThrows(_ url:NSURL) throws {
        try url.addSkipBackupAttributeOrThrows()
    }
    
    
    
    /**
     Sets given URL’s resource property for NSURLIsExcludedFromBackupKey key to true.
     
     - Parameter url: A file URL specifying the file or directory to set
     
     - Returns: **true** if the resource property is successfully set to true; otherwise, false.
     */
    public func addSkipBackupAttributeToItemAtURL(_ url:NSURL) -> Bool {
        return url.addSkipBackupAttribute()
    }
}
