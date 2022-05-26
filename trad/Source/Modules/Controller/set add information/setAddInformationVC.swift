//
//  setAddInformationVC.swift
//  trad
//
//  Created by Imac on 11/05/21.
//

import UIKit
import Firebase
import GoogleMaps
import FirebaseFirestoreSwift
import FirebaseStorage
import SDWebImage
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging
import UserNotifications



class setAddInformationVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    //MARK:- // Outlets:-
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var forSaleView: UIView!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var priceTextView: UITextField!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var totalPriceTextView: UITextField!
    @IBOutlet weak var forSaleCheckView: UIView!
    @IBOutlet weak var forSaleCheckImage: UIImageView!
    @IBOutlet weak var forRentView: UIView!
    @IBOutlet weak var extraDetailLbl: UILabel!
    @IBOutlet weak var sizeTextView: UITextField!
    @IBOutlet weak var forRentCheckImage: UIImageView!
    @IBOutlet weak var forSaleheckBtn: UIButton!
    @IBOutlet weak var extraDetailTextView: UITextView!
    @IBOutlet weak var forSaleLbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var forRentBtn: UIButton!
    @IBOutlet weak var forRentImg: UIImageView!
    @IBOutlet weak var forRentTextField: UITextField!
    @IBOutlet var propertyType: UILabel!
    @IBOutlet var contactInfoLbl: UILabel!
    @IBOutlet var contactTextView: UITextView!
    var count : Int = 0
    
    var ForSaleBool : Bool = false
    var ForRentBool : Bool = false
    var ForSoldAndRented : Bool = false
    var userType: String? = ""
    var userName: String? = ""
    var countProperty : Int = 0
    var adminUid: String? = ""
    var userUid: String? = ""
    var masterUid: String? = ""
    var Category =  String()
    var singleorfamily = ""
    var dailyormonthlyoryearly = ""
    var bedrooms = ""
    var apartment = ""
    var livingrooms = ""
    var bathrooms = ""
    var eetwidth = ""
    var internalstairs = false
    var level = ""
    var age = ""
    var propertySource = ""
    var driverroom = false
    var maidroom = false
    var pool = false
    var furnished = false
    var tent = false
    var extraspace = false
    var kitchen = false
    var extraunit = false
    var carentrance = false
    var basement = false
    var lift = false
    var duplex = false
    var airconditioner = false
    var purpose = ""
    var streetdirection = ""
    var stores = ""
    var footballspace = false
    var volleyballspace = false
    var playground = false
    var roomsslider = ""
    var familysection = false
    var valueOfsizeTextView = ""
    var valueofPriceTextView = ""
    var valueOftotalPrice = ""
    var valueofExtraDetail = ""
    var valueOfContactInfo = ""
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    var imageUrlArray = [String]()
    var videosUrlArray = [String]()
    var categoryindex =  Int()
    var ofWellsText = ""
    var ofTreeText = ""
    var ofPlateNumberText = ""
    var LandType = ""
    var valueForOfRooms = ""
    var OfRooms = ""
    var wantToSendNotification = String()
    var updateProperty : [Propertiesdata] = []
    var countData : [userData] = []
    var user: User!
    var userTokenData: [UserData] = []
    var mainArrayTokenData : [UserData] = []
    var sale_rentNotification = ""
    var saleNotification = ""
    var rentNotification = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDocument()
        userFetchDatafromFirebase()
        propertyType.text = Category.localizedStr()
        user = Auth.auth().currentUser
        forSaleView.isHidden = true
        forRentView.isHidden = true
        priceTextView.delegate = self
        totalPriceTextView.delegate = self
        sizeTextView.delegate = self
        extraDetailTextView.delegate = self
        contactTextView.delegate = self
        forRentTextField.delegate = self
        continueBtn.layer.cornerRadius = 24
        extraDetailTextView.layer.cornerRadius = 6
        extraDetailTextView.layer.borderWidth = 1
        extraDetailTextView.layer.borderColor  = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.extraDetailTextView.addDoneButton(title: "Done".localizedStr(), target: self, selector: #selector(tapDone(sender:)))
        
        
        contactTextView.layer.cornerRadius = 6
        contactTextView.layer.borderWidth = 1
        contactTextView.layer.borderColor  = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.contactTextView.addDoneButton(title: "Done".localizedStr(), target: self, selector: #selector(tapDone(sender:)))
        
        
        //        if Category == "Office for rent" || Category == "Room for rent" || Category == "Warehouse for rent" || Category == "Tent for rent" {
        //            forSaleView.isHidden = true
        //            forSaleCheckView.isHidden = true
        //        }
        //        if Category == "Office" || Category == "Room" || Category == "Warehouse" || Category == "Store" {
        //           forSaleView.isHidden = true
        //            forSaleCheckView.isHidden = true
        //            forRentView.isHidden = false
        //            forRentCheckImage.image = UIImage(named:"icons8-checked-checkbox-50.png")
        //            ForRentBool = true
        //        }
        hideKeyboardWhenTappedAround()
        // welcomeName()
        
        if self.updateProperty.count == 0 {
            
            sizeTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            priceTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            totalPriceTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
        } else {
            if updateProperty[0].Category == "\(Category)" + " for sale" {
                forSaleCheckImage.image = UIImage(named:"icons8-checked-checkbox-50.png")
                forSaleView.isHidden = false
                self.sizeTextView.text = updateProperty[0].valueOfsizeTextView
                self.priceTextView.text = updateProperty[0].valueofPriceTextView
                self.totalPriceTextView.text = updateProperty[0].valueOftotalPrice
                self.extraDetailTextView.text = updateProperty[0].valueofExtraDetail
                self.contactTextView.text = updateProperty[0].valueOfContactInfo
                self.ForSaleBool = true
            } else if updateProperty[0].Category == "\(Category)" + " for rent" {
                self.forRentTextField.text = updateProperty[0].valueOftotalPrice
                self.forRentView.isHidden = false
                self.forRentCheckImage.image = UIImage(named:"icons8-checked-checkbox-50.png")
                self.extraDetailTextView.text = updateProperty[0].valueofExtraDetail
                self.sizeTextView.text = updateProperty[0].valueOfsizeTextView
                self.priceTextView.text = updateProperty[0].valueofPriceTextView
                self.contactTextView.text = updateProperty[0].valueOfContactInfo
                self.ForRentBool = true
            }
            
            
        }
        
        
    }
    
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let firstValue = sizeTextView.text!
        let secondValue = priceTextView.text!
        print(secondValue)
        let finalPrice = totalPriceTextView.text!
        let myInt1 = Int(firstValue) ?? 0
        let myInt2 = Int(secondValue) ?? 0
        let myInt3 = Int(finalPrice) ?? 0
        if textField == priceTextView {
            if   myInt1 != 0 && myInt2 != 0
            {
                print(myInt2)
                print(myInt1)
                let result = myInt2 * myInt1
                print(result)
                totalPriceTextView.text = "\(result)"
                print(totalPriceTextView.text!)
            }
        }
        else if textField == totalPriceTextView{
            if myInt3 != 0 && myInt1 != 0 {
                let division = myInt3 / myInt1
                priceTextView.text = "\(division)"
            }
        }
    }
    
    func textViewShouldReturn(textView: UITextView!) -> Bool {
        self.view.endEditing(true)
        extraDetailTextView.endEditing(true)
        contactTextView.endEditing(true)
        return true }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        priceTextView.endEditing(true)
        totalPriceTextView.endEditing(true)
        sizeTextView.endEditing(true)
        forRentTextField.endEditing(true)
        return false
    }
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    @IBAction func forSaleBtnAction(_ sender: Any){
        
        if ForSaleBool == false {
            forSaleCheckImage.image = UIImage(named:"icons8-checked-checkbox-50.png")
            forSaleView.isHidden = false
            ForSaleBool = true
        }
        else
        {
            forSaleView.isHidden = true
            forSaleCheckImage.image = UIImage(named:"icons8-unchecked-checkbox-50.png")
            
            ForSaleBool = false
        }
        
    }
    
    @IBAction func forRent(_ sender: Any){
        
        if ForRentBool == false {
            forRentView.isHidden = false
            forRentCheckImage.image = UIImage(named:"icons8-checked-checkbox-50.png")
            ForRentBool = true
        }
        else
        {
            forRentView.isHidden = true
            forRentCheckImage.image = UIImage(named:"icons8-unchecked-checkbox-50.png")
            //    forSaleLbl.text = "For Rent"
            ForRentBool = false
        }
        
    }
    
    
    func getDocument() {
        //Get specific document from current user
        let docRef = Firestore.firestore()
            .collection("Users")
            .document(UserDefaults.standard.value(forKey: "loginUID") as! String)
        
        // Get data
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            let dataDescription = document.data()
            self.userType = dataDescription?["UserType"] as? String
            self.adminUid = dataDescription?["adminUid"] as? String
            self.userUid = dataDescription?["uid"] as? String
            self.masterUid = dataDescription?["masterUid"] as? String
            self.userName = dataDescription?["UserName"] as? String
            self.countProperty = dataDescription?["propertyCount"] as! Int
            self.wantToSendNotification = dataDescription?["deviceToken"] as! String
        }
    }
    
    
    
    
    func userFetchDatafromFirebase(){
        
        Helper().showUniversalLoadingView(true)
        
        let db = Firestore.firestore()
        db.collection("Users").getDocuments() { [self] (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.mainArrayTokenData = querySnapshot?.documents.reversed().compactMap { document in
                    // 6
                    try? document.data(as: UserData.self)
                } ?? []
                
                self.userTokenData = self.mainArrayTokenData
            }
            Helper().showUniversalLoadingView(false)
        }
    }
    
    
    @IBAction func continueAction(_ sender: Any)  {
        
        Helper().showUniversalLoadingView(true)
        valueOfsizeTextView = sizeTextView.text ?? ""
        valueofPriceTextView = priceTextView.text ?? ""
        valueOftotalPrice = totalPriceTextView.text ?? ""
        valueofExtraDetail = extraDetailTextView.text ?? "".localizedStr()
        valueOfContactInfo = contactTextView.text ?? "".localizedStr()
        
        
        
        if ForSaleBool == true && ForRentBool == true {
            if forRentTextField.text  == "" && sizeTextView.text == "" && priceTextView.text == "" && totalPriceTextView.text == "" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Size , Sale Price Per Meter and Rent Price".localizedStr(), VC: self, cancel_action: false)
                Helper().showUniversalLoadingView(false)
            } else  if forRentTextField.text  == "" && sizeTextView.text != "" && priceTextView.text != "" && totalPriceTextView.text != "" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Rent Price".localizedStr(), VC: self, cancel_action: false)
                Helper().showUniversalLoadingView(false)
            } else {
                saveValuesToFirebase(Propertytype: Category + " for sale", Price: valueOftotalPrice )
                saveValuesToFirebase(Propertytype: Category + " for rent", Price: forRentTextField.text ?? "" )
            }
            
        } else if ForSaleBool == true {
            if sizeTextView.text == "" && priceTextView.text == "" && totalPriceTextView.text == ""  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Size and Sale Price Per Meter ".localizedStr(), VC: self, cancel_action: false)
                Helper().showUniversalLoadingView(false)
            } else {
                saveValuesToFirebase(Propertytype: Category + " for sale", Price: valueOftotalPrice ) }
            
        } else if ForRentBool == true {
            if forRentTextField.text  == "" && sizeTextView.text == "" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Rent Price And Size".localizedStr(), VC: self, cancel_action: false)
                Helper().showUniversalLoadingView(false)
                
            } else {
                saveValuesToFirebase(Propertytype: Category + " for rent", Price: forRentTextField.text ?? "") }
        } else {
            TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please select Rent or Sale".localizedStr(), VC: self, cancel_action: false)
            Helper().showUniversalLoadingView(false)
        }
        
    }
    
    
    
    func saveValuesToFirebase(Propertytype: String, Price: String) {
        
        let db = Firestore.firestore()
        let userEmail = Auth.auth().currentUser?.email
        let newDocumentID = UUID().uuidString
        let ref = db.collection("Properties").document(newDocumentID)
        let someData = [
            "Category" : Propertytype,
            "selectCategory" : Category,
            "singleorfamily" : singleorfamily,
            "dailyormonthlyoryearly" : dailyormonthlyoryearly,
            "bedrooms" : bedrooms,
            "apartment" : apartment,
            "livingrooms" : livingrooms,
            "bathrooms" : bathrooms,
            "eetwidth" : eetwidth,
            "internalstairs" : internalstairs,
            "level" : level,
            "age" : age,
            "propertySource" : propertySource,
            "driverroom" : driverroom,
            "maidroom" : maidroom,
            "pool" : pool,
            "furnished" : furnished,
            "tent" : tent,
            "extraspace" : extraspace,
            "kitchen" : kitchen,
            "extraunit" : extraunit,
            "carentrance" : carentrance,
            "basement" : basement,
            "lift" : lift,
            "duplex" : duplex,
            "airconditioner" : airconditioner,
            "purpose" : purpose,
            "streetdirection" : streetdirection,
            "stores" : stores,
            "footballspace" : footballspace,
            "volleyballspace" : volleyballspace,
            "playground" : playground,
            "roomsslider" : roomsslider,
            "familysection" : familysection,
            "valueOfsizeTextView": valueOfsizeTextView.replacedArabicDigitsWithEnglish,
            "valueOftotalPrice": Price.replacedArabicDigitsWithEnglish,
            "valueofExtraDetail": valueofExtraDetail.replacedArabicDigitsWithEnglish,
            "valueOfContactInfo": valueOfContactInfo.replacedArabicDigitsWithEnglish,
            "valueofPriceTextView": valueofPriceTextView.replacedArabicDigitsWithEnglish,
            "createdDate":Date().getFormattedDate().localizedStr(),
            "latitude": "\(latitude)",
            "longitude": "\(longitude)",
            "ofWellsText": ofWellsText,
            "ofTreeText": ofTreeText,
            "forSoldAndRented" :  ForSoldAndRented ,
            "ImageUrl" : updateProperty.count == 0 ? imageUrlArray : updateProperty[0].ImageUrl ,
            "OfRooms" : valueForOfRooms,
            "deviceType":"iOS",
            "userType": userType! ,
            "userUid" : userUid!,
            "adminUid" : adminUid!,
            "masterUid": masterUid!,
            "userName" : userName!,
            "plateNo": ofPlateNumberText,
            "videoUrl":videosUrlArray,
            "documentID": updateProperty.count == 0 ? newDocumentID : updateProperty[0].documentID
            
        ] as [String : Any]
        
        self.count = countProperty
        if self.ForSaleBool == true && self.ForRentBool == true {
        let countdata = ["propertyCount" : self.count + 2 ]
        
        if updateProperty.count == 0 {
            
            let UpdateRef =  db.collection("Users").document(UserDefaults.standard.value(forKey: "loginUID") as! String)
            UpdateRef.updateData(countdata) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please try again".localizedStr(), VC: self, cancel_action: false)
                    
                } else {
                    print("Document added with ID: \(UserDefaults.standard.value(forKey: "loginUID") as! String)")
                    
                }
                
            }
        }
        }else{
            
            let countdata = ["propertyCount" : self.count + 1]
            
            if updateProperty.count == 0 {
                
                let UpdateRef =  db.collection("Users").document(UserDefaults.standard.value(forKey: "loginUID") as! String)
                UpdateRef.updateData(countdata) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please try again".localizedStr(), VC: self, cancel_action: false)
                        
                    } else {
                        print("Document added with ID: \(UserDefaults.standard.value(forKey: "loginUID") as! String)")
                        
                    }
                    
                }
            }
            
            
        }
        
        if updateProperty.count == 0 {
            Helper().showUniversalLoadingView(true)
            ref.setData(someData) { [self] err in
                if let err = err {
                    print("Error adding document: \(err)")
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please try again".localizedStr(), VC: self, cancel_action: false)
                    
                } else {
                    print("Document added with ID: \(newDocumentID)")
                    
                    if self.ForSaleBool == true && self.ForRentBool == true {
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List for Sale And Rent Has been Submitted".localizedStr(), VC: self, cancel_action: false)
                        self.tabBarController?.tabBar.isHidden = false
                        self.tabBarController?.selectedIndex = 0
                        
                        for item in userTokenData {
                            let currentUserToken = Messaging.messaging().fcmToken
                            if item.deviceToken != currentUserToken && item.appLanguage != "ar" {
                                wantToSendNotification = item.deviceToken
                                saleNotification = "added"
                                sale_rentNotification = "for sale and rent"
                                let sender = PushNotificationSender()
                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + Category + " " + self.sale_rentNotification)
                                print(wantToSendNotification)
                            } else if item.deviceToken != currentUserToken && item.appLanguage != "en"{
                                wantToSendNotification = item.deviceToken
                                saleNotification = "اضاف"
                                sale_rentNotification = "للبيع و للإجار"
                                let sender = PushNotificationSender()
                                if Category == "Land"{
                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "أرض" + " " + self.sale_rentNotification)
                                print(wantToSendNotification)
                                } else if Category == "Villa"{
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "فيلا" + " " + self.sale_rentNotification)
                                    print(wantToSendNotification)
                                    }else if Category == "Floor"{
                                        sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "دور" + " " + self.sale_rentNotification)
                                        print(wantToSendNotification)
                                        }else if Category == "Apartment"{
                                            sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "شقة" + " " + self.sale_rentNotification)
                                            print(wantToSendNotification)
                                            }else if Category == "Building"{
                                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "عمارة" + " " + self.sale_rentNotification)
                                                print(wantToSendNotification)
                                                }else if Category == "Esteraha"{
                                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "استراحة" + " " + self.sale_rentNotification)
                                                    print(wantToSendNotification)
                                                    }else if Category == "Store"{
                                                        sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "محل" + " " + self.sale_rentNotification)
                                                        print(wantToSendNotification)
                                                        }else if Category == "Farm"{
                                                            sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "مزرعة" + " " + self.sale_rentNotification)
                                                            print(wantToSendNotification)
                                                            }else if Category == "Room"{
                                                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "غرفة" + " " + self.sale_rentNotification)
                                                                print(wantToSendNotification)
                                                                }else if Category == "Office"{
                                                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "مكتب" + " " + self.sale_rentNotification)
                                                                    print(wantToSendNotification)
                                                                    }else if Category == "Warehouse"{
                                                                        sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "مستودع" + " " + self.sale_rentNotification)
                                                                        print(wantToSendNotification)
                                                                        }else if Category == "Furnished Apartment"{
                                                                            sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "شقة مفروشة" + " " + self.sale_rentNotification)
                                                                            print(wantToSendNotification)
                                                                            }else if Category == "Tent"{
                                                                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + "مخيم" + " " + self.sale_rentNotification)
                                                                                print(wantToSendNotification)
                                                                                }
                            }
                            }
                     
                        Helper().showUniversalLoadingView(false)
                    } else if self.ForSaleBool == true  {
                        Helper().showUniversalLoadingView(false)
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List for Sale Has been Submitted".localizedStr(), VC: self, cancel_action: false)
                        self.tabBarController?.tabBar.isHidden = false
                        self.tabBarController?.selectedIndex = 0
                        for item in userTokenData {
                            let currentUserToken = Messaging.messaging().fcmToken
                            if item.deviceToken != currentUserToken && item.appLanguage != "ar" {
                                wantToSendNotification = item.deviceToken
                                saleNotification = "added"
                                let sender = PushNotificationSender()
                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + Propertytype)
                                print(wantToSendNotification)
                            } else if item.deviceToken != currentUserToken && item.appLanguage != "en"{
                                wantToSendNotification = item.deviceToken
                                saleNotification = "اضاف"
                                let sender = PushNotificationSender()
                                if Propertytype == "Land for sale"{
                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "أرض للبيع")
                                print(wantToSendNotification)
                                }else if Propertytype == "Villa for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "فيلا للبيع")
                                }else if Propertytype == "Floor for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "دور للبيع")
                                }
                                else if Propertytype == "Apartment for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "شقة للبيع")
                                }
                                else if Propertytype == "Building for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "عمارة للبيع")
                                }
                                else if Propertytype == "Esteraha for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "استراحه للبيع")
                                }
                                else if Propertytype == "Farm for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مزرعة للبيع")
                                }
                                else if Propertytype == "Tent for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مخيم للبيع")
                                }
                                else if Propertytype == "Room for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "غرفة للبيع")
                                }
                                else if Propertytype == "Office for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مكتب للبيع")
                                }
                                else if Propertytype == "Warehouse for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مستودع للبيع")
                                }
                                else if Propertytype == "Furnished Apartment for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "شقة مفروشة للبيع")
                                }
                                else if Propertytype == "Store for sale" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "محل للايجار")
                                }
                                
                            }
                            }
                    
                        Helper().showUniversalLoadingView(false)
                    } else if self.ForRentBool == true  {
                        Helper().showUniversalLoadingView(false)
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List for Rent Has been Submitted".localizedStr(), VC: self, cancel_action: false)
                        self.tabBarController?.tabBar.isHidden = false
                        self.tabBarController?.selectedIndex = 0
                        for item in userTokenData {
                            let currentUserToken = Messaging.messaging().fcmToken
                            if item.deviceToken != currentUserToken && item.appLanguage != "ar" {
                                wantToSendNotification = item.deviceToken
                                saleNotification = "added"
                                let sender = PushNotificationSender()
                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + " " + Propertytype)
                                print(wantToSendNotification)
                            } else if item.deviceToken != currentUserToken && item.appLanguage != "en"{
                                wantToSendNotification = item.deviceToken
                                saleNotification = "اضاف"
                                let sender = PushNotificationSender()
                                if Propertytype == "Land for rent"{
                                sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "ارض للايجار")
                                print(wantToSendNotification)
                                }else if Propertytype == "Villa for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "فيلا للايجار")
                                }else if Propertytype == "Floor for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "دور للايجار")
                                }
                                else if Propertytype == "Apartment for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "شقة للايجار")
                                }
                                else if Propertytype == "Building for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "عمارة للايجار")
                                }
                                else if Propertytype == "Esteraha for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "استراحة للايجار")
                                }
                                else if Propertytype == "Farm for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مزرعة للايجار")
                                }
                                else if Propertytype == "Tent for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مخيم للايجار")
                                }
                                else if Propertytype == "Room for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "غرفة للايجار")
                                }
                                else if Propertytype == "Office for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مكتب للايجار")
                                }
                                else if Propertytype == "Warehouse for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "مستودع للايجار")
                                }
                                else if Propertytype == "Furnished Apartment for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "شقة مفروشة للايجار")
                                }
                                else if Propertytype == "Store for rent" {
                                    sender.sendPushNotification(to: wantToSendNotification, title: "Trad", body: self.userName! + " " + self.saleNotification + "  " + "محل للايجار")
                                }
                                
                            }
                            }
                        
                        
                        
                        
                        
                        
                        Helper().showUniversalLoadingView(false)
                    } else {
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please select Rent or Sale".localizedStr(), VC: self, cancel_action: false)
                        Helper().showUniversalLoadingView(false)
                        
                    }
                }
            }
            
            
        } else {
            Helper().showUniversalLoadingView(true)
            let UpdateRef = db.collection("Properties").document(updateProperty[0].documentID)
            UpdateRef.updateData(someData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please try again".localizedStr(), VC: self, cancel_action: false)
                    
                } else {
                    print("Document added with ID: \(self.updateProperty[0].documentID)")
                    if self.ForSaleBool && self.ForRentBool == true &&  self.categoryindex == 0 &&  self.categoryindex == 1 {
                        
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List for Sale And Rent Has been Submitted".localizedStr(), VC: self, cancel_action: false)
                        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainTabBarController")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.navigationController?.pushViewController(controller, animated: true) }
                        Helper().showUniversalLoadingView(false)
                    } else if self.ForSaleBool == true  {
                        
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List for Sale Has been Submitted".localizedStr(), VC: self, cancel_action: false)
                        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainTabBarController")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.navigationController?.pushViewController(controller, animated: true) }
                        Helper().showUniversalLoadingView(false)
                    } else if self.ForRentBool == true  {
                        
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List for Rent Has been Submitted".localizedStr(), VC: self, cancel_action: false)
                        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainTabBarController")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.navigationController?.pushViewController(controller, animated: true) }
                        Helper().showUniversalLoadingView(false)
                        
                    } else {
                        
                        TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please select Rent or Sale".localizedStr(), VC: self, cancel_action: false)
                        Helper().showUniversalLoadingView(false)
                    }
                }
                
            }
        }
    }
}


extension Date {
    func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        //dateformat.dateFormat = format
        dateformat.dateFormat = "dd-MM-yyyy h:mm:ss a "
        dateformat.amSymbol = "AM"
        dateformat.pmSymbol = "PM"
        return dateformat.string(from: self)
    }
}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}


public extension String {
    
    var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
}


