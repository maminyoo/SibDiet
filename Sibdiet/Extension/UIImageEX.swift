
//
//  UIImageExtension.swift
//  ToneCurveEditor
//
//  Created by Simon Gladman on 14/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//
import UIKit
import CoreGraphics

extension UIImage {
    func resizeToBoundingSquare(boundingSquareSideLength : CGFloat) -> UIImage {
        let imgScale = self.size.width > self.size.height ?
            boundingSquareSideLength / self.size.width :
            boundingSquareSideLength / self.size.height
        let newWidth = self.size.width * imgScale
        let newHeight = self.size.height * imgScale
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return resizedImage!
    }
    
    /// Creates and returns a new image scaled to the given size. The image preserves its original PNG
    /// or JPEG bitmap info.
    ///
    /// - Parameter size: The size to scale the image to.
    /// - Returns: The scaled image or `nil` if image could not be resized.
    public func scaledImage(with size: CGSize) -> UIImage? {
      UIGraphicsBeginImageContextWithOptions(size, false, scale)
      defer { UIGraphicsEndImageContext() }
      draw(in: CGRect(origin: .zero, size: size))
      return UIGraphicsGetImageFromCurrentImageContext()?.data.flatMap(UIImage.init)
    }

    // MARK: - Private

    /// The PNG or JPEG data representation of the image or `nil` if the conversion failed.
    private var data: Data? {
      #if swift(>=4.2)
        return self.pngData() ?? self.jpegData(compressionQuality: Constant.jpegCompressionQuality)
      #else
        return self.pngData() ?? self.jpegData(compressionQuality: Constant.jpegCompressionQuality)
      #endif  // swift(>=4.2)
    }
}

// MARK: - Constants

private enum Constant {
  static let jpegCompressionQuality: CGFloat = 1
}

extension UIImage {
    func save(_ path: String) -> URL? {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                                 appropriateFor: nil,
                                                                 create: false)
            let url = documentsDirectory.appendingPathComponent(path)
            do {
                try FileManager.default.createDirectory(at: url.deletingLastPathComponent(),
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                guard let data = jpegData(compressionQuality: 1.0) else { return nil }
                try data.write(to: url)
                return url
            } catch { return nil }
        } catch { return nil }
    }
    
    func crop(cropRect: CGRect) -> UIImage?{
        let imageViewScale = max(self.size.width / cropRect.width,
                                 self.size.height / cropRect.height)
        let cropZone = CGRect(cropRect.origin.x * imageViewScale,
                              cropRect.origin.y * imageViewScale,
                              cropRect.size.width * imageViewScale,
                              cropRect.size.height * imageViewScale)
        guard let cutImageRef = self.cgImage?.cropping(to: cropZone) else { return nil }
        return UIImage(cgImage: cutImageRef, scale: self.scale, orientation: self.imageOrientation)
    }
   
    func crop(_ size: CGSize) -> UIImage {
        let width = Double(size.width)
        let height = Double(size.height)
        let cgimage = self.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
}

extension UIImage {
    convenience init?(_ url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data, scale: 1)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}
