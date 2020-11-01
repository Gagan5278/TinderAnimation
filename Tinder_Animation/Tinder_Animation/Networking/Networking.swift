//
//  Networking.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 11/1/20.
//

import Foundation

class Networking: NSObject {
    
    var dowbloadPreogressBlock : ((Float) -> Void)? = nil
    
    fileprivate let fileURLString = "https://firebasestorage.googleapis.com/v0/b/flutterapp-d1066.appspot.com/o/sample%2Fvideoplayback%20(1).mp4?alt=media&token=70a234b6-7cf8-4438-8f12-58aef248e298"
    func downloadVideoFile() {
        guard  let  fileURL = URL(string: fileURLString) else {
            return
        }
       let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)//URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
       let downloadSession = session.downloadTask(with: fileURL)
       downloadSession.resume()
    }
}

extension Networking: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("didFinishDownloadingTo")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentage = ((Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)))
        print(percentage)
        DispatchQueue.main.async {
            self.dowbloadPreogressBlock?(percentage)
        }

    }

    
    
    
}
