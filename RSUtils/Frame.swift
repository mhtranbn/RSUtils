//
//  Frame.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

/**
*  Represents a frame in an APNG file. 
*  It contains a whole IDAT chunk data for a PNG image.
*/
class Frame {
    
    static var allocCount = 0
    static var deallocCount = 0
    
    private var width: Int = 0
    private var height: Int = 0
    private var bits: Int = 0
    private var scale: CGFloat = 1.0
    private var blend = false
    
    private var cleaned = false
    
    var image: CocoaImage? {
        let unusedCallback: CGDataProviderReleaseDataCallback = { optionalPointer, pointer, valueInt in }
        guard let provider = CGDataProvider(dataInfo: nil, data: bytes, size: length, releaseData: unusedCallback) else {
            return nil
        }
        
        if let imageRef = CGImage(width: width, height: height, bitsPerComponent: bits, bitsPerPixel: bits * 4, bytesPerRow: bytesInRow, space: CGColorSpaceCreateDeviceRGB(),
                                  bitmapInfo: [CGBitmapInfo.byteOrder32Big, CGBitmapInfo(rawValue: CGImageAlphaInfo.last.rawValue)],
                                  provider: provider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
        {
            #if os(macOS)
                return NSImage(cgImage: imageRef, size: NSSize(width: width, height: height))
            #else
                return UIImage(cgImage: imageRef, scale: scale, orientation: .up)
            #endif
        }
        return nil
    }
    
    /// Data chunk.
    var bytes: UnsafeMutablePointer<UInt8>
    
    /// An array of raw data row pointer. A decoder should fill this area with image raw data.
    lazy var byteRows: Array<UnsafeMutableRawPointer> = {
        var array = Array<UnsafeMutableRawPointer>()
        
        let height = self.length / self.bytesInRow
        for i in 0 ..< height {
            let pointer = self.bytes.advanced(by: i * self.bytesInRow)
            array.append(pointer)
        }
        return array
    }()
    
    let length: Int
    
    /// How many bytes in a row. Regularly it is width * (bitDepth / 2)
    let bytesInRow: Int
    
    var duration: TimeInterval = 0
    
    init(length: UInt32, bytesInRow: UInt32) {
        self.length = Int(length)
        self.bytesInRow = Int(bytesInRow)
        
        self.bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: self.length)
        self.bytes.initialize(to: 0)
        memset(self.bytes, 0, self.length)
    }
    
    func clean() {
        cleaned = true
        bytes.deinitialize(count: length)
        bytes.deallocate(capacity: length)
    }
    
    func updateCGImageRef(_ width: Int, height: Int, bits: Int, scale: CGFloat, blend: Bool) {
        self.width = width
        self.height = height
        self.bits = bits
        self.scale = scale
        self.blend = blend
    }
}

extension Frame: CustomStringConvertible {
    var description: String {
        return "<Frame: \(self.bytes)))> duration: \(self.duration), length: \(length)"
    }
}

extension Frame: CustomDebugStringConvertible {

    var data: Data? {
        if let image = image {
            #if os(iOS) || os(watchOS) || os(tvOS)
                return UIImagePNGRepresentation(image)
            #elseif os(OSX)
                return image.tiffRepresentation
            #endif
        }
        return nil
    }
    
    var debugDescription: String {
        return "\(description)\ndata: \(String(describing: data))"
    }
}
