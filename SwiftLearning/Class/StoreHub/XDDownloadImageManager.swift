//
//  XDDownloadImageManager.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/5/9.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit
import Foundation
import CommonCrypto.CommonDigest

let image1Url = "http://static01.jingqiusports.com/jingqiusports_prod/article-images/202005071628122280.jpg"

let image2Url = "http://static01.jingqiusports.com/jingqiusports_prod/article-images/202004241511178003.jpg"

let image3Url = "http://static01.jingqiusports.com/jingqiusports_prod/article-images/202005061810237575.jpg"

typealias XDDownloadThreeImageComplete = (_ images:Array<UIImage?>) -> Void;
typealias XDDownloadImageComplete = (_ image:UIImage?) -> Void;

class XDDownloadImageManager: NSObject {
    
    static let shareManager = XDDownloadImageManager()
    
    let cache = NSCache<AnyObject,AnyObject>()
    
    class func test() {
        
        self.testWayOne()
//        self.testWayTwo()
    }
    
    class func testWayOne() {
        self.shareManager.downloadThreeImagesAsync { (array) in
//            print("finished")
        }
    }
    
    class func testWayTwo() {
        
    }
    
    func downloadThreeImagesAsync(_ completion:@escaping XDDownloadThreeImageComplete) {
        
        let queue = OperationQueue()
        queue.name = "downloadThreeImagesAsyncQueue"
        
        var image1:UIImage?
        var image2:UIImage?
        var image3:UIImage?
        
        let operation = BlockOperation()
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImage(image1Url) { (image) in
                image1 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImage(image2Url) { (image) in
                image2 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImage(image3Url) { (image) in
                image3 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.completionBlock = {
            if image1 != nil && image2 != nil && image3 != nil {
                print("we've got all 3 images")
            }
            DispatchQueue.main.async {
                completion([image1,image2,image3])
            }
        }
        queue.addOperation(operation)
        
    }
    
    /** It will block current thread */
    func downloadThreeImagesSync() -> Array<UIImage?> {
        
        if Thread.isMainThread {
            print("it's in main thread")
        }
        
        var queue = OperationQueue.current
        if queue == nil {
            queue = OperationQueue.main
        }
        
        var image1:UIImage?
        var image2:UIImage?
        var image3:UIImage?
        
        let semaphore = DispatchSemaphore(value: 0)
        self.downloadImage(image1Url) { (image) in
            image1 = image
            semaphore.signal()
        }
        semaphore.wait()
        
//        let semaphore = DispatchSemaphore(value: 0)
        self.downloadImage(image2Url) { (image) in
            image2 = image
            semaphore.signal()
        }
        semaphore.wait()
        
//        let semaphore = DispatchSemaphore(value: 0)
        self.downloadImage(image3Url) { (image) in
            image3 = image
            semaphore.signal()
        }
        semaphore.wait()
        
        if image1 != nil && image2 != nil && image3 != nil {
            print("we've got all 3 images")
        }
        
        return [image1,image2,image3]
    }
    
    func downloadImage(_ imageUrl:String?, _ completion:@escaping XDDownloadImageComplete) {
        
        if self.isUrlEmpty(imageUrl) {
//            print("there's a problem with url")
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        var image:UIImage?
        
        let memoryData = self.cache.object(forKey: imageUrl! as AnyObject) as? Data
        if memoryData != nil {
            image = UIImage(data: memoryData!)
            if image != nil {
                DispatchQueue.main.async {
                    completion(image!)
                }
//                print("image is exist in Memory with url-\(imageUrl!)")
                return
            }
        }
        
        
        let filePath = self.getImagePath(imageUrl!)
        do {
            let diskData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            image = UIImage(data: diskData)
            if image != nil {
                DispatchQueue.main.async {
                    completion(image!)
                }
//                print("image is exist in Disk with url-\(imageUrl!)")
                return
            }
        } catch {
            
        }
        
        let api = URL(string: imageUrl!)
        let request = URLRequest(url: api!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var downloadImage:UIImage?
            
            if data == nil {
//                print("there's a problem in download with url-\(imageUrl!)")
            } else {
                downloadImage = UIImage(data: data!)
                if downloadImage != nil {
//                    print("download successed with url-\(imageUrl!)")
                    self.cache.setObject(data as AnyObject, forKey: imageUrl as AnyObject)
                    
                    do {
                        try data?.write(to: URL(fileURLWithPath: filePath), options: .atomicWrite)
                    } catch {
//                        print("there's a problem in storing with url-\(imageUrl!)")
                    }
                    
                    
                } else {
//                    print("there's a problem in download with url-\(imageUrl!)")
                }
                
            }
            
            DispatchQueue.main.async {
                completion(downloadImage)
            }
            
        }
        task.resume()
        
    }
    
    func getFoldPath() -> String {
        let home = NSHomeDirectory()
        let documentsPath = home + "/Documents/"
        return documentsPath
    }
    
    func getImagePath(_ key:String) -> String {
        let documentsPath = self.getFoldPath()
        let imagePath = documentsPath + key.md5()
        return imagePath
    }
    
    func isUrlEmpty(_ url:String?) -> Bool {
        if url == nil {
            return true
        }
        if url?.isEmpty == true {
            return true
        }
        if URL(string: url!) == nil {
            return true
        }
        return false
    }
    
    func decompressImage(_ image:UIImage)
    {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1));
        image.draw(at: CGPoint.zero)
        UIGraphicsEndImageContext();
    }
    
}

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        
        return String(format: hash as String)
    }
}

