//
//  uploadImageViewController.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit
import BSImagePicker
import Photos
import Firebase
import MBProgressHUD
import SDWebImage
import MobileCoreServices
import TTGSnackbar


class uploadImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var uploadImageBtn: UIButton!
    @IBOutlet var uploadVideoBtn: UIButton!
    @IBOutlet var newImageVideo: UIButton!
    @IBOutlet var tittleLbl: UILabel!
    @IBOutlet var continueBtn: UIButton!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var progressUIV: UIView!
    @IBOutlet var progressLbl: UILabel!
    @IBOutlet var propertyType: UILabel!
    @IBOutlet var hideBtn: UIButton!
    
    var CategoryDetail =  String()
    var categoryindex =  Int()
    var arrayOfImagesAndVideos = [Any]()
    var _selectedCells : NSMutableArray = []
    var imageDAta = UIImage()
    var imageUrlArray = [String]()
    var videoUrlArray = [String]()
    let myGroup = DispatchGroup()
    let imagePicker = UIImagePickerController()
    var positions = Int()
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyType.text = CategoryDetail.localizedStr()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        
        uploadImageBtn.layer.cornerRadius = 24
        uploadImageBtn.layer.borderWidth = 1
        uploadImageBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        uploadVideoBtn.layer.cornerRadius = 24
        uploadVideoBtn.layer.borderWidth = 1
        uploadVideoBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        newImageVideo.layer.cornerRadius = 24
        newImageVideo.layer.borderWidth = 1
        newImageVideo.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        continueBtn.layer.cornerRadius = 24
        progressView.isHidden = true
        progressUIV.isHidden = true
        progressUIV.layer.cornerRadius =  4
        uploadImageBtn.setTitle("uploadImageBtn".localizedStr(), for: .normal)
        uploadVideoBtn.setTitle("uploadVideoBtn".localizedStr(), for: .normal)
        newImageVideo.setTitle("newImageVideo".localizedStr(), for: .normal)
        continueBtn.setTitle("continueBtn".localizedStr(), for: .normal)
        imageUrlArray.removeAll()
        videoUrlArray.removeAll()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MBProgressHUD.hide(for: self.view, animated: true)
        progressView.isHidden = true
        progressUIV.isHidden = true
        hideBtn.isHidden = true
        imageUrlArray.removeAll()
        videoUrlArray.removeAll()
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
       
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func hideBtnAction(_ sender: Any) {
        let snackbar = TTGSnackbar.init(message: "please wait picture being uploaded", duration: TTGSnackbarDuration.short)
        snackbar.show()
    }
    
    @IBAction func newImageVideoAction(_ sender: Any) {
        if arrayOfImagesAndVideos.contains(where: { $0 is URL }){
            let alert = UIAlertController(title: "TRAD", message: "You upload only one video", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: {_ in
                                            self.uploadImg()} ))
            self.present(alert, animated: true, completion: nil)
        }else{
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.showsCameraControls = true
            let MAX_VIDEO_DURATION = 25.0 // note the .0, must be double, move this at the top of your class preferrebly
            imagePicker.videoMaximumDuration = TimeInterval(MAX_VIDEO_DURATION)
            imagePicker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
            imagePicker.cameraCaptureMode = .photo // Default media type .photo vs .video
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func uploadImg(){
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        //
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.cameraCaptureMode = .photo
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadImageAction(_ sender: Any) {
        let vc = ImagePickerController()
        vc.settings.selection.max = 7
        vc.modalPresentationStyle = .fullScreen
        presentImagePicker(
            vc, animated: true,
            select: { (asset: PHAsset) -> Void in
                print("Selected: \(asset)")
                
                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (image, info) in
                    //            self.imageDAta = image!
                        print("selected dataa 4566 \(String(describing: image))")
                  
                }
            }, deselect: { (asset: PHAsset) -> Void in
                print("Deselected: \(asset)")
            }, cancel: { (assets: [PHAsset]) -> Void in
                print("Cancel: \(assets)")
            }, finish: { [self] (assets: [PHAsset]) -> Void in
                print("Finish: \(assets)")
                let imagess = assets
                for (_,arrayimages) in imagess.enumerated() {
                    let optionss = PHImageRequestOptions()
                    optionss.deliveryMode = .highQualityFormat
                    optionss.resizeMode = .none
                    PHImageManager.default().requestImage(for:  arrayimages, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: optionss) {(image, info) in
                        self.imageDAta = image!
                        guard  let imageData = imageDAta.jpegData(compressionQuality: 1.0) else {
                            return }
                        let image = UIImage(data: imageData)
                        self.arrayOfImagesAndVideos.append(image!)
                        self.imagesCollectionView.reloadData()
                    }}
                
                self.imagesCollectionView.reloadData()
                
            }, completion:   nil)
    }
    
    
    
    

    
    
    
    
    
    func compressImage(assets: UIImage) -> UIImage {
        let imageData = UIImage(named:"background.jpg")!.jpegData(compressionQuality: 0.2)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    @IBAction func uploadVideoAction(_ sender: Any) {
        if arrayOfImagesAndVideos.contains(where: { $0 is URL }){
            let alert = UIAlertController(title: "TRAD", message: "You upload only one video", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.videoMaximumDuration = 25.00
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.videoQuality = UIImagePickerController.QualityType.type640x480
            imagePicker.isEditing = true
            present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Check for the media type
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
        switch mediaType {
        case kUTTypeImage:
            // Handle image selection result
            print("Selected media is image")
            let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.arrayOfImagesAndVideos.append(originalImage)
            self.imagesCollectionView.reloadData()
            
        case kUTTypeMovie:
            // Handle video selection result
            print("Selected media is video")
            let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            self.arrayOfImagesAndVideos.append(videoUrl)
        default:
            print("Mismatched type: \(mediaType)")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func NextScreen(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChooseLocationVC") as! ChooseLocationVC
        vc.CategoryDetail1 = CategoryDetail
        vc.ImagesArray = imageUrlArray
        vc.videosArray = videoUrlArray
        vc.categoryindex = categoryindex
        self.navigationController?.pushViewController(vc, animated: true)}
    
    func sameScreen(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    @IBAction func ContinueAction(_ sender: Any) {
        self.PhassetToImage()
        if arrayOfImagesAndVideos.isEmpty == true {
            let alert = UIAlertController(title: "TRAD", message: "Are you Sure Do not Want To Upload images or Video".localizedStr(), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes".localizedStr(), style: UIAlertAction.Style.cancel, handler: {_ in
                                            self.NextScreen()}))
            alert.addAction(UIAlertAction(title: "No".localizedStr(), style: UIAlertAction.Style.default, handler: {_ in
                                            self.sameScreen()} ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func PhassetToImage(){
        
        if arrayOfImagesAndVideos.count > 0{
            print(arrayOfImagesAndVideos.count)
            for (i,arrayimages) in arrayOfImagesAndVideos.enumerated() {
                self.myGroup.enter()
                
                if let imageItem = arrayimages as? UIImage {
                    let optionss = PHImageRequestOptions()
                    optionss.deliveryMode = .highQualityFormat
                    optionss.resizeMode = .none
                    let storage = Storage.storage().reference()
                    guard  let imageData = imageItem.jpegData(compressionQuality: 0.8) else {
                        return }
                    let data = imageData
                    print(data.count)
                    let metaData = StorageMetadata()
                    metaData.contentType = "image/jpg"
                    let imagename = String.random()
                    let uploadTask = storage.child("\(imagename)").putData(data, metadata: metaData)
                    uploadTask.observe(.progress)
                    { snapshot in
                        if i == self.arrayOfImagesAndVideos.count-1{
                            let percentComplete = 100 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                            self.progressView.isHidden = false
                            self.progressUIV.isHidden = false
                            self.hideBtn.isHidden = false
                            self.progressView.progress = Float(snapshot.progress!.completedUnitCount) / Float(snapshot.progress!.totalUnitCount)
                            let per = "\(percentComplete)"
                            let array = per.components(separatedBy: ".")
                            print(array[0])
                            self.progressLbl.text = "\(array[0])%"
                        }
                        
                    }
                    storage.child("\(imagename)").putData(data, metadata: metaData) { (meta, error) in
                        if let err = error {
                            print(err.localizedDescription)
                        } else {
                            storage.child("\(imagename)").downloadURL { (url, err) in
                                if let e = err {
                                    print(e.localizedDescription)
                                    print("Image not sent")
                                    self.myGroup.leave()
                                    
                                } else {
                                    print("Image sent")
                                    
                                    let urlString = url?.absoluteString
                                    self.imageUrlArray.append(urlString!)
                                    self.myGroup.leave()
                                }
                            }
                        }
                        
                    }
                }
                else {
                    let options = PHVideoRequestOptions ()
                    options.version = .original
                    let localVideoUrl = arrayimages
                    print (localVideoUrl)
                    
                    let videoData = try! Data(contentsOf: localVideoUrl as! URL, options: .mappedIfSafe)
                    
                    print(videoData.count)
                    let storage = Storage.storage().reference()
                    let metaData = StorageMetadata()
                    metaData.contentType = "video/mp4"
                    let videoName = String.random()
                    let uploadTask = storage.child("\(videoName)").putData(videoData, metadata: metaData)
                    uploadTask.observe(.progress) { snapshot in
                        
                        if i == self.arrayOfImagesAndVideos.count-1{
                            let percentComplete = 100 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                            self.progressView.isHidden = false
                            self.progressUIV.isHidden = false
                            self.hideBtn.isHidden = false
                            self.progressView.progress = Float(snapshot.progress!.completedUnitCount) / Float(snapshot.progress!.totalUnitCount)
                            
                            let per = "\(percentComplete)"
                            let array = per.components(separatedBy: ".")
                            print(array[0])
                            self.progressLbl.text = "\(array[0])%"
                        }
                        
                    }
                    storage.child("\(videoName)").putData(videoData, metadata: metaData) { (meta, error) in
                        if let err = error {
                            print(err.localizedDescription)
                        } else {
                            storage.child("\(videoName)").downloadURL { (url, err) in
                                if let e = err {
                                    print(e.localizedDescription)
                                    self.myGroup.leave()
                                } else {
                                    let urlString = url?.absoluteString
                                    self.videoUrlArray.append(urlString!)
                                    self.myGroup.leave()
                                }
                            }
                        }
                        print("Video sent")}
                }
            }
        }
        myGroup.notify(queue: .main) {
            print("Finished all requests.")
            self.NextScreen()
        }
    }
}

extension String {
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"}
        return randomString}}


extension uploadImageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.arrayOfImagesAndVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionViewCell", for: indexPath) as! imagesCollectionViewCell
        let asset = self.arrayOfImagesAndVideos[indexPath.item]
        if let imageItem = asset as? UIImage {
            cell.images.image = imageItem
            cell.cancelbtn.tag = indexPath.item
            cell.cancelbtn.addTarget(self, action: #selector(self.btnActionCancel(sender:)), for: .touchUpInside)
        }
        return cell
    }
    @objc func btnActionCancel(sender : UIButton) {
        let indexPath = IndexPath(row:sender.tag, section: 0)
        arrayOfImagesAndVideos.remove(at: indexPath.item)
        
        self.imagesCollectionView.reloadData()
    }
}

class imagesCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet var images: UIImageView!
    @IBOutlet var cancelbtn: UIButton!
}

