//
//  detailViewController.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit
import AVKit
import SDWebImage
import GoogleMaps
import TTGSnackbar
import AVFoundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth


class detailViewController: UIViewController, UIScrollViewDelegate, GMSMapViewDelegate,CLLocationManagerDelegate{
    
    var timer = Timer()
    var counter = 0
    var imgArr2 = [UIImage(named:"house"),
                   UIImage(named:"house2") ,
                   UIImage(named:"house5") ,
                   UIImage(named:"house4"),
                   UIImage(named:"house5"),
                   UIImage(named:"house") ,
                   UIImage(named:"house7") ,
                   UIImage(named:"house")]
    var language = L102Language.currentAppleLanguage()
    var UserData1: [Propertiesdata] = []
    var mainArrayData1 : [Propertiesdata] = []
    var Aproperties : [Propertiesdata] = []
    @IBOutlet weak var BtnLeftArrow: UIButton!
    @IBOutlet weak var ImgLeftArrow: UIImageView!
    @IBOutlet weak var LblSar: UILabel!
    @IBOutlet var ImagescollectionView: UICollectionView!
    @IBOutlet weak var pageImageController: UIPageControl!
    @IBOutlet weak var LblHouseDescription: UILabel!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet var imagesTableView: UITableView!
    
    //MARK:- UIVIEWs:-
    @IBOutlet weak var CategoryView: UIView!
    @IBOutlet weak var StreetDirectionView: UIView!
    @IBOutlet weak var PropertySourceView: UIView!
    @IBOutlet weak var DailyMonthlyView: UIView!
    @IBOutlet weak var FamilyTypeView: UIView!
    @IBOutlet weak var BedroomView: UIView!
    @IBOutlet weak var LivingRoomView: UIView!
    @IBOutlet weak var ApartmentView: UIView!
    @IBOutlet weak var InternalStairsView: UIView!
    @IBOutlet weak var BathroomView: UIView!
    @IBOutlet weak var AgeView: UIView!
    @IBOutlet weak var FurnishedviewBool: UIView!
    @IBOutlet weak var StreetWidthView: UIView!
    @IBOutlet weak var ACBoolView: UIView!
    @IBOutlet weak var KitchenBoolView: UIView!
    @IBOutlet weak var ExtraUnitBoolView: UIView!
    @IBOutlet weak var ExtraSpace: UIView!
    @IBOutlet weak var BaseMentView: UIView!
    @IBOutlet weak var CarentEranceView: UIView!
    @IBOutlet weak var MaidRoomView: UIView!
    @IBOutlet weak var DriverRoomView: UIView!
    @IBOutlet weak var LiftBoolView: UIView!
    @IBOutlet weak var PoolView: UIView!
    @IBOutlet weak var DuplexViewiew: UIView!
    @IBOutlet weak var tentViewBool: UIView!
    @IBOutlet weak var extraspaceViewBool: UIView!
    @IBOutlet weak var purposeView: UIView!
    @IBOutlet weak var footballspaceViewBool: UIView!
    @IBOutlet weak var volleyballspaceViewBool: UIView!
    @IBOutlet weak var playgroundViewBool: UIView!
    @IBOutlet weak var roomssliderView: UIView!
    @IBOutlet weak var familysectionViewBool: UIView!
    @IBOutlet weak var valueOfsizeTextView: UIView!
    @IBOutlet weak var valueofPriceTextView: UIView!
    @IBOutlet weak var valueOftotalPrice: UIView!
    @IBOutlet weak var TotalpriceView: UIView!
    @IBOutlet weak var createdDateVIew: UIView!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var StoresView: UIView!
    @IBOutlet weak var wellsView: UIView!
    @IBOutlet weak var treesView: UIView!
    @IBOutlet weak var extraDetailview: UIView!
    @IBOutlet var contactInfoView: UIView!
    @IBOutlet var createdDateView2: UIView!
    
    //MARK:- UIVIEW Labels:-
    
    @IBOutlet weak var LblStoresView: UILabel!
    @IBOutlet weak var LblLevel: UILabel!
    @IBOutlet weak var LblCategoryView: UILabel!
    @IBOutlet weak var LblStreetDirectionView: UILabel!
    @IBOutlet weak var LblPropertySourceView: UILabel!
    @IBOutlet weak var LblDailyMonthlyView: UILabel!
    @IBOutlet weak var LblFamilyTypeView: UILabel!
    @IBOutlet weak var LblBedroomView: UILabel!
    @IBOutlet weak var LblLivingRoomView: UILabel!
    @IBOutlet weak var LblApartmentView: UILabel!
    @IBOutlet weak var LblBathroomView: UILabel!
    @IBOutlet weak var LblStreetWidthView: UILabel!
    @IBOutlet weak var LblAgeView: UILabel!
    @IBOutlet weak var eetwidthView: UIView!
    @IBOutlet weak var LblEetwidth: UILabel!
    @IBOutlet weak var LblRoomSlider: UILabel!
    @IBOutlet weak var LblValueOfPrice: UILabel!
    @IBOutlet weak var LblValueofSize: UILabel!
    @IBOutlet weak var LblValueOfTotalPrice: UILabel!
    @IBOutlet weak var LblTotalPrice: UILabel!
    @IBOutlet weak var LblCreatedDate: UILabel!
    @IBOutlet weak var LblPurposeView: UILabel!
    @IBOutlet var createdDateLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var LblTreesView: UILabel!
    @IBOutlet weak var LblwellsView: UILabel!
    @IBOutlet weak var LblExtraDetailView: UILabel!
    @IBOutlet var textExtraDetailView: UITextView!
    @IBOutlet var contactInfoLbl: UILabel!
    @IBOutlet var LblContact: UILabel!
    @IBOutlet var hideView: UIView!
    @IBOutlet var fullImageView: UIImageView!
    @IBOutlet var imagesBtn: UIButton!
    @IBOutlet var videosBtn: UIButton!
    @IBOutlet var imageVideoCount: UILabel!
    @IBOutlet var LblPlateNumber: UILabel!
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var dateRefreshBtn: UIButton!
    var editDetailsVC = setFilterVC()
    var position = Int()
    var documentInteractionController = UIDocumentInteractionController()
    var  UserUid: String? = ""
    var AdminUid: String? = ""
    var MasterUid: String? = ""
    var userUidArray = String()
    var masterUidArray = String()
    var adminUidArray = String()    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        mapView.delegate = self
        updateview()
        ImagescollectionView.delegate = self
        ImagescollectionView.dataSource = self
        imagesTableView.delegate = self
        imagesTableView.dataSource = self
        pageView.numberOfPages = self.Aproperties[0].ImageUrl.count + self.Aproperties[0].videoUrl.count
        pageView.currentPage = 0
        self.LblHouseDescription.text = self.Aproperties[0].Category.localizedStr()
        self.createdDateVIew.isHidden = true
        hideView.isHidden = true
        imagesBtn.isSelected = true
        ImagesBtnAction(self)
        LblPlateNumber.text = self.Aproperties[0].plateNo.localizedStr()
        showMarker()
        for employee in Aproperties {
            userUidArray.append(employee.userUid)
            adminUidArray.append(employee.adminUid)
            masterUidArray.append(employee.masterUid)
        }
        if userUidArray == Auth.auth().currentUser?.uid {
            contactInfoLbl.isHidden = false
            contactInfoView.isHidden = false
            LblContact.isHidden = false
            editButton.isHidden = false
        }else if adminUidArray == Auth.auth().currentUser?.uid {
            contactInfoLbl.isHidden = false
            contactInfoView.isHidden = false
            LblContact.isHidden = false
            editButton.isHidden = false
        }else if adminUidArray == Auth.auth().currentUser?.uid {
            contactInfoLbl.isHidden = false
            contactInfoView.isHidden = false
            LblContact.isHidden = false
            editButton.isHidden = false
        }else if masterUidArray == Auth.auth().currentUser?.uid {
            contactInfoLbl.isHidden = false
            contactInfoView.isHidden = false
            LblContact.isHidden = false
            editButton.isHidden = false
        }else if  masterUidArray == Auth.auth().currentUser?.uid {
            contactInfoLbl.isHidden = false
            contactInfoView.isHidden = false
            LblContact.isHidden = false
            editButton.isHidden = false
        }else{
            contactInfoLbl.isHidden = true
            contactInfoView.isHidden = true
            LblContact.isHidden = true
            editButton.isHidden = true
        }
        UpdatedDate()
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        UpdatedDate()
    }
    
    
    
    func showMarker(){
        var bounds = GMSCoordinateBounds()
        let latStr = self.Aproperties[0].latitude
        let longStr = self.Aproperties[0].longitude
        let lat = Double(latStr)
        let long = Double(longStr)
        let marker = GMSMarker()
        marker.map = mapView
        marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        marker.isFlat = true
        marker.userData = self.Aproperties[0]
        bounds = bounds.includingCoordinate(marker.position)
        let camera = GMSCameraPosition.camera(withLatitude: lat! ,longitude: long!, zoom: 20.0)
        self.mapView.animate(to: camera)
        mapView.setMinZoom(1, maxZoom: 15)//prevent to over zoom on fit and animate if bounds be too small
        mapView.setMinZoom(1, maxZoom: 20) // allow the user zoom in more than level 15 again
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let position = marker.position
        print(position)
        mapView.animate(toLocation: position)
        let point = mapView.projection.point(for: position)
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.open(URL.init(string: "comgooglemaps://?saddr=&daddr=\(marker.position.latitude),\(marker.position.longitude)&directionsmode=driving")!, options: [:], completionHandler: nil)
            
        }else {
            NSLog("Can't use comgooglemaps://");
            let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(marker.position.latitude),\(marker.position.longitude)")
            UIApplication.shared.open(url!)
        }
        return true
    }
    
    @IBAction func editActionButton(_ sender: UIButton) {
        hideView.isHidden = true
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChooseLocationVC") as! ChooseLocationVC
        secondViewController.Aproperties1 = self.Aproperties
        print(secondViewController.Aproperties1)
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func ImagesBtnAction(_ sender: Any) {
        imagesBtn.isSelected = true
        videosBtn.isSelected = false
        imagesBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        imagesBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        videosBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        videosBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let ImageCount = self.Aproperties[0].ImageUrl.count
        let img = "Images".localizedStr()
        imageVideoCount.text = "\(img)(\(ImageCount))"
        imagesTableView.reloadData()
    }
    
    @IBAction func VideosBtnAction(_ sender: Any) {
        imagesBtn.isSelected = false
        videosBtn.isSelected = true
        imagesBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        imagesBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        videosBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        videosBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        let videoCount = self.Aproperties[0].videoUrl.count
        let vdo = "Videos".localizedStr()
        imageVideoCount.text = "\(vdo)(\(videoCount))"
        imagesTableView.reloadData()
    }
    
    @IBAction func largeImageAction(_ sender: UIButton) { hideView.isHidden = false}
    
    @IBAction func imageBackBtn(_ sender: Any) {
        hideView.isHidden = true
    }
    
    @IBAction func dateRefreshBtnAction(_ sender: Any) {
        let db = Firestore.firestore()
        let someData = ["createdDate" :  Date().getFormattedDate().localizedStr()
        ] as [String : Any]
        let UpdateRef = db.collection("Properties").document(Aproperties[0].documentID)
        UpdateRef.updateData(someData) { err in
            if let err = err {
                print("Error adding document: \(err)")
                Helper().showUniversalLoadingView(false)
            }else {
                let DateandTime = self.UserData1[0].createdDate.components(separatedBy: " ")
                if L102Language.currentAppleLanguage() == "ar" {
                    self.createdDateLbl.text = String(DateandTime[0])
                }else{
                    self.createdDateLbl.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
                    
                }
                self.UpdatedDate()
                Helper().showUniversalLoadingView(false)
            }
        }
    }
    
    func UpdatedDate(){
        Helper().showUniversalLoadingView(true)
        let db = Firestore.firestore()
        db.collection("Properties").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.mainArrayData1 = querySnapshot?.documents.reversed().compactMap { document in
                    // 6
                    try? document.data(as: Propertiesdata.self)
                } ?? []
                self.UserData1 = self.mainArrayData1
            }
            Helper().showUniversalLoadingView(false)
        }
    }
    
    
    
    @IBAction func whatsappShareWithImages(_ sender: AnyObject) {
        let message = self.Aproperties[0].Category.localizedStr() + " https://tradapp-56582.web.app/?page=Properties&id=\(self.Aproperties[0].documentID)&language=\(language)"
        var queryCharSet = NSCharacterSet.urlQueryAllowed
        queryCharSet.remove(charactersIn: "+&")
        if let escapedString = message.addingPercentEncoding(withAllowedCharacters: queryCharSet) {
            if let whatsappURL = URL(string: "whatsapp://send?text=\(escapedString)") {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: [: ], completionHandler: nil)
                } else {
                    debugPrint("please install WhatsApp")
                    let snackbar = TTGSnackbar.init(message: "Please install WhatsApp", duration: TTGSnackbarDuration.short)
                    snackbar.show()
                }
            }
        }
    }
    
    
    @objc func changeImage() {
        if counter < self.Aproperties[0].ImageUrl.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.ImagescollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        }else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.ImagescollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
    
    func updateview(){
        let largeNumber = (Int(self.Aproperties[0].valueOftotalPrice) ?? 0 )
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
        self.LblSar.text = (formattedNumber ?? "") + " " + "SAR".localizedStr()
        self.levelView.isHidden = true
        self.extraspaceViewBool.isHidden = true
        self.CategoryView.isHidden = true
        self.StreetDirectionView.isHidden = true
        self.PropertySourceView.isHidden = true
        self.DailyMonthlyView.isHidden = true
        self.FamilyTypeView.isHidden = true
        self.BedroomView.isHidden = true
        self.LivingRoomView.isHidden = true
        self.ApartmentView.isHidden = true
        self.BathroomView.isHidden = true
        self.InternalStairsView.isHidden = true
        self.AgeView.isHidden = true
        self.FurnishedviewBool.isHidden = true
        self.StreetWidthView.isHidden = true
        self.ACBoolView.isHidden = true
        self.KitchenBoolView.isHidden = true
        self.ExtraSpace.isHidden = true
        self.ExtraUnitBoolView.isHidden = true
        self.BaseMentView.isHidden = true
        self.CarentEranceView.isHidden = true
        self.MaidRoomView.isHidden = true
        self.DriverRoomView.isHidden = true
        self.LiftBoolView.isHidden = true
        self.PoolView.isHidden = true
        self.DuplexViewiew.isHidden = true
        self.eetwidthView.isHidden = true
        self.tentViewBool.isHidden = true
        self.footballspaceViewBool.isHidden = true
        self.volleyballspaceViewBool.isHidden = true
        self.purposeView.isHidden = true
        self.playgroundViewBool.isHidden = true
        self.roomssliderView.isHidden = true
        self.valueOftotalPrice.isHidden = true
        self.valueOfsizeTextView.isHidden = true
        self.TotalpriceView.isHidden = true
        self.familysectionViewBool.isHidden = true
        self.StoresView.isHidden = true
        self.wellsView.isHidden = true
        self.treesView.isHidden = true
        self.valueofPriceTextView.isHidden = true
        
        if self.Aproperties[0].Category == "Apartment for rent" || self.Aproperties[0].Category == "Apartment for sale"{
            self.FamilyTypeView.isHidden = false
            self.DailyMonthlyView.isHidden = false
            self.BedroomView.isHidden = false
            self.LivingRoomView.isHidden = false
            self.BathroomView.isHidden = false
            self.levelView.isHidden = false
            self.AgeView.isHidden = false
            self.FurnishedviewBool.isHidden = false
            self.KitchenBoolView.isHidden = false
            self.ExtraUnitBoolView.isHidden = false
            self.CarentEranceView.isHidden = false
            self.LiftBoolView.isHidden = false
            self.ACBoolView.isHidden = false
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.StreetWidthView.isHidden = false
            //MARK:- Labels//:-
            LblFamilyTypeView.text = self.Aproperties[0].singleorfamily.localizedStr()
            LblDailyMonthlyView.text = self.Aproperties[0].dailyormonthlyoryearly.localizedStr()
            LblBedroomView.text = self.Aproperties[0].bedrooms.localizedStr()
            LblBathroomView.text = self.Aproperties[0].bathrooms.localizedStr()
            LblLevel.text = self.Aproperties[0].level.localizedStr()
            LblLivingRoomView.text = self.Aproperties[0].livingrooms.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            
        }else if self.Aproperties[0].Category == "Villa for rent" || self.Aproperties[0].Category == "Villa for sale"{
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.BedroomView.isHidden = false
            self.ApartmentView.isHidden = false
            self.LivingRoomView.isHidden = false
            self.BathroomView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.valueofPriceTextView.isHidden = false
            self.valueOfsizeTextView.isHidden = false
            self.AgeView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblDailyMonthlyView.text = self.Aproperties[0].dailyormonthlyoryearly.localizedStr()
            LblBedroomView.text = self.Aproperties[0].bedrooms.localizedStr()
            LblBathroomView.text = self.Aproperties[0].bathrooms.localizedStr()
            LblApartmentView.text = self.Aproperties[0].apartment.localizedStr()
            LblLivingRoomView.text = self.Aproperties[0].livingrooms.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblFamilyTypeView.text = self.Aproperties[0].singleorfamily.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            LblValueOfPrice.text = self.Aproperties[0].valueofPriceTextView.localizedStr()
            LblValueofSize.text = self.Aproperties[0].valueOfsizeTextView.localizedStr() + " m² "
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }else if self.Aproperties[0].Category == "Floor for rent" || self.Aproperties[0].Category == "Floor for sale"{
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.BedroomView.isHidden = false
            self.LivingRoomView.isHidden = false
            self.BathroomView.isHidden = false
            self.levelView.isHidden = false
            self.AgeView.isHidden = false
            self.CarentEranceView.isHidden = false
            self.ACBoolView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblBedroomView.text = self.Aproperties[0].bedrooms.localizedStr()
            LblBathroomView.text = self.Aproperties[0].bathrooms.localizedStr()
            LblLivingRoomView.text = self.Aproperties[0].livingrooms.localizedStr()
            LblLevel.text =  self.Aproperties[0].level.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }else if self.Aproperties[0].Category == "Building for rent" || self.Aproperties[0].Category == "Building for sale" {
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.purposeView.isHidden = false
            self.ApartmentView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.AgeView.isHidden = false
            self.FurnishedviewBool.isHidden = false
            self.roomssliderView.isHidden = false
            self.StoresView.isHidden = false
            self.valueofPriceTextView.isHidden = false
            self.valueOfsizeTextView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblPurposeView.text = self.Aproperties[0].purpose.localizedStr()
            LblApartmentView.text = self.Aproperties[0].apartment.localizedStr()
            LblStoresView.text = self.Aproperties[0].stores.localizedStr()
            LblStreetWidthView.text =  self.Aproperties[0].eetwidth.localizedStr()
            LblRoomSlider.text =  self.Aproperties[0].OfRooms.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            LblValueOfPrice.text = self.Aproperties[0].valueofPriceTextView.localizedStr()
            LblValueofSize.text = self.Aproperties[0].valueOfsizeTextView.localizedStr() + " m² "
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }else if self.Aproperties[0].Category == "Esteraha for rent" || self.Aproperties[0].Category == "Esteraha for sale"{
            
            self.DailyMonthlyView.isHidden = false
            self.LivingRoomView.isHidden = false
            self.BathroomView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.roomssliderView.isHidden = false
            self.AgeView.isHidden = false
            self.PoolView.isHidden = false
            self.tentViewBool.isHidden = false
            self.tentViewBool.isHidden = false
            self.KitchenBoolView.isHidden = false
            self.footballspaceViewBool.isHidden = false
            self.volleyballspaceViewBool.isHidden = false
            self.playgroundViewBool.isHidden = false
            self.familysectionViewBool.isHidden = false
            self.StreetDirectionView.isHidden = true
            self.PropertySourceView.isHidden = true
            //MARK:- Labels//:-
            LblDailyMonthlyView.text = self.Aproperties[0].dailyormonthlyoryearly.localizedStr()
            LblBathroomView.text = self.Aproperties[0].bathrooms.localizedStr()
            LblLivingRoomView.text = self.Aproperties[0].livingrooms.localizedStr()
            LblRoomSlider.text = self.Aproperties[0].OfRooms.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            
        }else if self.Aproperties[0].Category == "Store for rent" || self.Aproperties[0].Category == "Store for sale" {
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.AgeView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }else if self.Aproperties[0].Category == "Farm for rent" || self.Aproperties[0].Category == "Farm for sale" { self.PropertySourceView.isHidden = false
            self.treesView.isHidden = false
            self.wellsView.isHidden = false
            self.valueofPriceTextView.isHidden = false
            self.valueOfsizeTextView.isHidden = false
            //MARK:- Labels//:-
            LblTreesView.text = self.Aproperties[0].ofTreeText.localizedStr()
            LblwellsView.text = self.Aproperties[0].ofWellsText.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            LblValueOfPrice.text = self.Aproperties[0].valueofPriceTextView.localizedStr()
            LblValueofSize.text = self.Aproperties[0].valueOfsizeTextView.localizedStr() + " m² "
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            
        }else if self.Aproperties[0].Category == "Land for rent" || self.Aproperties[0].Category == "Land for sale" {
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.purposeView.isHidden = false
            self.StreetWidthView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblPurposeView.text = self.Aproperties[0].purpose.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }else if self.Aproperties[0].Category == "Room for rent" || self.Aproperties[0].Category == "Room for sale" {
            self.DailyMonthlyView.isHidden = false
            self.AgeView.isHidden = false
            self.FurnishedviewBool.isHidden = false
            self.KitchenBoolView.isHidden = false
            self.PropertySourceView.isHidden = false
            //MARK:- Labels//:-
            LblDailyMonthlyView.text = self.Aproperties[0].dailyormonthlyoryearly.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            
        }else if self.Aproperties[0].Category == "Office for rent" || self.Aproperties[0].Category == "Office for sale" {
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.FurnishedviewBool.isHidden = false
            self.AgeView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }
        else if self.Aproperties[0].Category == "Tent for rent" || self.Aproperties[0].Category == "Tent for sale" {
            self.DailyMonthlyView.isHidden = false
            self.familysectionViewBool.isHidden = false
            self.PropertySourceView.isHidden = false
            //MARK:- Labels//:-
            LblDailyMonthlyView.text = self.Aproperties[0].dailyormonthlyoryearly.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            
        }else if self.Aproperties[0].Category == "Warehouse for rent" || self.Aproperties[0].Category == "Warehouse for sale" {
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.AgeView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }else if self.Aproperties[0].Category == "Store for rent" || self.Aproperties[0].Category == "Store for sale" {
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.AgeView.isHidden = false
            self.valueofPriceTextView.isHidden = false
            self.valueOfsizeTextView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].propertySource.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
            LblValueOfPrice.text = self.Aproperties[0].valueofPriceTextView.localizedStr()
            LblValueofSize.text = self.Aproperties[0].valueOfsizeTextView.localizedStr() + " m²"
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            
        }else if self.Aproperties[0].Category == "Furnished Apartment for rent" || self.Aproperties[0].Category == "Furnished Apartment for sale" {
            self.StreetDirectionView.isHidden = false
            self.PropertySourceView.isHidden = false
            self.BedroomView.isHidden = false
            self.LivingRoomView.isHidden = false
            self.BathroomView.isHidden = false
            self.StreetWidthView.isHidden = false
            self.levelView.isHidden = false
            self.AgeView.isHidden = false
            self.KitchenBoolView.isHidden = false
            self.ExtraUnitBoolView.isHidden = false
            self.CarentEranceView.isHidden = false
            self.LiftBoolView.isHidden = false
            //MARK:- Labels//:-
            LblStreetDirectionView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblPropertySourceView.text = self.Aproperties[0].streetdirection.localizedStr()
            LblBedroomView.text = self.Aproperties[0].bedrooms.localizedStr()
            LblBathroomView.text = self.Aproperties[0].bathrooms.localizedStr()
            LblStreetWidthView.text = self.Aproperties[0].eetwidth.localizedStr()
            LblLivingRoomView.text = self.Aproperties[0].livingrooms.localizedStr()
            LblLevel.text = self.Aproperties[0].level.localizedStr()
            LblAgeView.text = self.Aproperties[0].age.localizedStr()
            contactInfoLbl.text = self.Aproperties[0].valueOfContactInfo.localizedStr()
            textExtraDetailView.text = self.Aproperties[0].valueofExtraDetail.localizedStr()
        }
        
        self.InternalStairsView.isHidden = !self.Aproperties[0].internalstairs
        self.DriverRoomView.isHidden = !self.Aproperties[0].driverroom
        self.MaidRoomView.isHidden = !self.Aproperties[0].maidroom
        self.PoolView.isHidden = !self.Aproperties[0].pool
        self.FurnishedviewBool.isHidden = !self.Aproperties[0].furnished
        self.tentViewBool.isHidden = !self.Aproperties[0].tent
        self.ExtraSpace.isHidden = !self.Aproperties[0].extraspace
        self.KitchenBoolView.isHidden = !self.Aproperties[0].kitchen
        self.ExtraUnitBoolView.isHidden = !self.Aproperties[0].extraunit
        self.CarentEranceView.isHidden = !self.Aproperties[0].carentrance
        self.BaseMentView.isHidden = !self.Aproperties[0].basement
        self.LiftBoolView.isHidden = !self.Aproperties[0].lift
        self.ACBoolView.isHidden = !self.Aproperties[0].airconditioner
        self.DuplexViewiew.isHidden = !self.Aproperties[0].duplex
        self.familysectionViewBool.isHidden = !self.Aproperties[0].familysection
        self.footballspaceViewBool.isHidden = !self.Aproperties[0].footballspace
        self.volleyballspaceViewBool.isHidden = !self.Aproperties[0].volleyballspace
        self.playgroundViewBool.isHidden = !self.Aproperties[0].playground
        let DateandTime = self.Aproperties[0].createdDate.components(separatedBy: " ")
        if L102Language.currentAppleLanguage() == "ar" {
            createdDateLbl.text = String(DateandTime[0])
        }else{
            createdDateLbl.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
        }
        let submit = "Submitted By"
        self.userNameLbl.text = submit.localizedStr() + " " +  self.Aproperties[0].userName.localizedStr()
    }
    
    @IBAction func leftBtnAction(_ sender: Any)  {
        self.navigationController?.popViewController(animated: true)
    }
}


extension detailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return self.Aproperties[0].ImageUrl.count
        }else{
            return self.Aproperties[0].videoUrl.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCollectionViewCell", for: indexPath) as! detailCollectionViewCell
        if indexPath.section == 0{
            print(self.Aproperties[0].ImageUrl)
            cell.playPauseBtn.isHidden = true
            cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imageView?.sd_setImage(with: URL(string:self.Aproperties[0].ImageUrl[indexPath.row]))
        } else {
            cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imageView?.sd_setImage(with: URL(string:self.Aproperties[0].ImageUrl[indexPath.row]))
            cell.playPauseBtn.isHidden = false
            cell.largeImageBtn.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            playVideo(url:URL(string:self.Aproperties[0].videoUrl[indexPath.row])!)
        }
    }
    
    
    func playVideo(url: URL) {         
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) { vc.player?.play() }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pageView.currentPage == indexPath.row {
            guard let visible = collectionView.visibleCells.first else { return }
            guard let index = collectionView.indexPath(for: visible)?.row else { return }
            pageView.currentPage = index
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width), y: (scrollView.frame.height))
        if let ip = ImagescollectionView.indexPathForItem(at: center) {
            self.pageView.currentPage = ip.row
        }
    }
    
}


extension detailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = ImagescollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}


extension detailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if imagesBtn.isSelected == true{
            return self.Aproperties[0].ImageUrl.count
        }else{
            return self.Aproperties[0].videoUrl.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = imagesTableView.dequeueReusableCell(withIdentifier: "imagesTableViewCell", for: indexPath) as! imagesTableViewCell
        if imagesBtn.isSelected == true{
            cell.images.image = nil
            cell.images.sd_setImage(with: URL(string:self.Aproperties[0].ImageUrl[indexPath.row]))
            cell.play.isHidden = true
        }else{
            cell.images.image = nil
            cell.images.sd_setImage(with: URL(string:self.Aproperties[0].ImageUrl[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "simple_home"))
            cell.play.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if videosBtn.isSelected == true{
            playVideo(url:URL(string:self.Aproperties[0].videoUrl[indexPath.row])!)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

struct SinglePropertiesdata : Decodable {
    
    let Category: String
    let singleorfamily: String
    let dailyormonthlyoryearly: String
    let bedrooms: String
    let apartment: String
    let livingrooms: String
    let bathrooms: String
    let eetwidth: String
    let internalstairs: Bool
    let level: String
    let age: String
    let driverroom: Bool
    let maidroom: Bool
    let pool: Bool
    let furnished: Bool
    let tent: Bool
    let extraspace: Bool
    let kitchen: Bool
    let extraunit: Bool
    let carentrance: Bool
    let basement: Bool
    let lift: Bool
    let duplex: Bool
    let airconditioner: Bool
    let purpose: String
    let streetdirection: String
    let propertySource:String
    let stores: String
    let footballspace: Bool
    let volleyballspace: Bool
    let playground: Bool
    let roomsslider: String
    let familysection: Bool
    let valueOfsizeTextView: String
    let valueofPriceTextView: String
    let valueOftotalPrice: String
    let valueofExtraDetail: String
    let createdDate: String
    let valueOfContactInfo: String
    let userUid: String
    let adminUid: String
    let masterUid: String
}

class imagesTableViewCell: UITableViewCell{
    
    @IBOutlet var images: UIImageView!
    @IBOutlet var play: UIImageView!
}

