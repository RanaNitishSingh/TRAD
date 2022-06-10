//
//  ThumbNail.swift
//  trad
//
//  Created by Imac on 02/09/21.
//

import Foundation
import UIKit
import AVKit


class ThumbNail {
    
    static func getThumbnailFromUrl(_ url: String, defaultImage: Bool = true, _ completion: @escaping ((_ image: UIImage?)->Void)) {
        
        let md5Hex: String = url.toMD5
        if let oldData: Data = FileUtils.readImageFromDir(fileUrl: md5Hex) {
            completion(UIImage(data: oldData))
        }else{
            guard let url = URL(string: url) else { return }
            DispatchQueue.global(qos: .utility).async {
                let asset = AVAsset(url: url)
                let durationSeconds = CMTimeGetSeconds(asset.duration)
                let assetImgGenerate = AVAssetImageGenerator(asset: asset)
                assetImgGenerate.appliesPreferredTrackTransform = true
                let time = CMTimeMakeWithSeconds(durationSeconds/3.0, preferredTimescale: 600)
                do {
                    let img: CGImage = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                    let thumbnail = UIImage(cgImage: img)
                    FileUtils.saveIntoDir(fileUrl: md5Hex, data: thumbnail.pngData()!)
                    DispatchQueue.main.async {
                        completion(thumbnail)
                    }
                    
                } catch (let error) {
                    print("Error :: ", error.localizedDescription)
                    DispatchQueue.main.async {
                        if defaultImage {
                            completion(UIImage(contentsOfFile: "tmp_placeholder_video"))
                        }else{
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
    
    static func getThumbnailFromFile(_ url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(durationSeconds/3.0, preferredTimescale: 600)
        do {
            let img: CGImage = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch (let error) {
            return nil
        }
    }
    
}
