//
//  Image+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#if os(OSX)
import Cocoa
#elseif os(iOS) || os(tvOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#endif

#if os(OSX)
/// The image type for the current platform.
public typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
/// The image type for the current platform.
public typealias Image = UIImage
#endif

#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)

extension Image: ReadableWritable, WritableConvertible {

    /// Returns an image from the given path.
    ///
    /// - Parameter path: The path to be returned the image for.
    /// - Throws: FileKitError.ReadFromFileFail
    ///
    public class func read(from path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(Image.self))
        }
        return contents
    }

    /// Returns `TIFFRepresentation` on OS X and `UIImagePNGRepresentation` on
    /// iOS, watchOS, and tvOS.
    public var writable: Data {
        #if os(OSX)
        return self.tiffRepresentation ?? Data()
        #else
        return UIImagePNGRepresentation(self) ?? Data()
        #endif
    }

    /// Retrieves an image from a URL.
    public convenience init?(url: URL) {
        #if os(OSX)
            self.init(contentsOf: url)
        #else
            guard let data = try? Data(contentsOf: url) else {
                return nil
            }
            self.init(data: data)
        #endif
    }

    /// Retrieves an image from a URL string.
    public convenience init?(urlString string: String) {
        guard let url = URL(string: string) else {
            return nil
        }
        self.init(url: url)
    }

}

#endif
