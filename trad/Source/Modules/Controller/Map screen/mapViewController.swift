//
//  mapViewController.swift
//  trad
//
//  Created by Imac on 10/05/21.

import UIKit
import FirebaseFirestore
import FirebaseAuth
import GoogleMaps
import GooglePlaces

class mapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet var collView: UIView!
    @IBOutlet var forSaleCollectionView: UICollectionView!
    @IBOutlet weak var mapCenterPinImage: UIImageView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet var currentLocationBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!    
    @IBOutlet weak var dropDownSearchView: UIView!
    @IBOutlet weak var minPriceRange: UITextField!
    @IBOutlet weak var maxPriceRange: UITextField!
    @IBOutlet weak var maxSizeRange: UITextField!
    @IBOutlet weak var minSizeRange: UITextField!
    @IBOutlet weak var searchPropertyBtn: UIButton!
    @IBOutlet weak var propertySourceLbl: UILabel!
    @IBOutlet weak var propertySourceBtn: UIButton!
    
    //MARK:- Variables
    private let locationManager = CLLocationManager()
    var properties: [Propertiesdata] = []
    var mainArrayProperties: [Propertiesdata] = []
    var rangeArray : [Propertiesdata] = []
    var PriceRange = ""
    var SizeRange = ""
    var selectedIndex = Int ()
    var selectedIndexPath : IndexPath?
    var levelCheck = ""
    var CountData : [UserData] = []
    var mainArrayData3 : [UserData] = []
    var pickerView = UIPickerView()
    var toolBar = UIToolbar()
    var arrCategories = ["All Categories","Apartment for rent","Villa for sale","Land for sale","Villa for rent","Floor for rent","Floor for sale","Apartment for sale","Building for sale","Esteraha for rent","Esteraha for sale","Store for rent","Farm for sale","Building for rent","Land for rent","Room for rent","Room for sale","Office for rent","Office for sale","Warehouse for rent","Warehouse for sale", "Furnished Apartment for sale","Furnished Apartment for rent","Tent for rent", "Tent for sale"]
    
   //var droplist = ["Owner","Agent","Government"]
    var droplist = [" ","0","1","2"]
    var valueDropDown = ""
    var tappedmarker : GMSMarker?
    var markerwindow  = markerWindow()
    var Aproperties : [Propertiesdata] = []
    var Aproperties_1 : [Propertiesdata] = []
    var distanceInMeters : CLLocationDistance?
    var  adminUid = ""
    var  userUid = ""
    
    
    //MARK:- View life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        languageUpdate()
        self.markerwindow = markerWindow().loadview()
        self.tappedmarker = GMSMarker()
        markerwindow.infoWindowTableView.delegate = self
        markerwindow.infoWindowTableView.dataSource = self
        markerwindow.infoWindowTableView.register(UINib(nibName: "infoWindowTableViewCell", bundle: nil), forCellReuseIdentifier: "infoWindowTableViewCell")
        mapCenterPinImage.isHidden = true
        currentLocationBtn.layer.cornerRadius = 26
        currentLocationBtn.alpha = 0.8
        mapView.delegate = self
        forSaleCollectionView.delegate = self
        forSaleCollectionView.dataSource = self
        collView.layer.cornerRadius = 18
        forSaleCollectionView.layer.cornerRadius = 18
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        fetchDatafromFirebase1()
        currentLocationBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        currentLocationBtn.imageView?.alpha = 0.70
        mapView.isMyLocationEnabled = true
        self.getMyCurrentLocation()
        searchBtn.layer.borderWidth = 1
        searchBtn.layer.borderColor = UIColor.black.cgColor
        searchBtn.layer.cornerRadius = 18
        searchPropertyBtn.layer.cornerRadius = 16
        searchPropertyBtn.layer.borderWidth = 1
        searchPropertyBtn.layer.borderColor = UIColor.black.cgColor
        self.pickerView.isHidden = true
        self.dropDownSearchView.isHidden = true
        self.getdata()
        self.hideKeyboardWhenTappedAround()
        print(valueDropDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.getdata()
        self.hideKeyboardWhenTappedAround()
        print(valueDropDown)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
            dropDownSearchView.isHidden = true
       
    }

    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func ActionPropertySource(_ sender: Any) {
        if pickerView.isHidden {
        pickerView.isHidden = false
        pickerView = UIPickerView.init()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerView)
      
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
        }else if !pickerView.isHidden{
            toolBar.removeFromSuperview()
            pickerView.removeFromSuperview()
            pickerView.isHidden = true
            toolBar.isHidden = true
        }
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
        pickerView.isHidden = true
        toolBar.isHidden = true
    }
    
    func getdata(){
        let db = Firestore.firestore()
        db.collection("Properties").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.mainArrayProperties = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Propertiesdata.self)
                } ?? []
                
                self.properties = self.mainArrayProperties
            }
        }
     
    }
    
    
    @IBAction func searchPropertyAction(_ sender: Any) {
        self.getdata()
        let minPrice = minPriceRange.text ?? ""
        let maxPrice = maxPriceRange.text ?? ""
        let minSize = minSizeRange.text ?? ""
        let maxSize = maxSizeRange.text ?? ""
        
        
        if (self.minPriceRange.text == "" && self.maxPriceRange.text == "") && (self.minSizeRange.text == "" && self.maxSizeRange.text == "") && (propertySourceLbl.text != "")
        {
            for filteredProperty in properties {
                if valueDropDown == filteredProperty.propertySource {
                self.properties = self.mainArrayProperties.filter { data in
                    return data.propertySource.contains("\(valueDropDown)")
                }
                    rangeArray.append(filteredProperty)
                }
                
                
                }
          
        }
       else if (self.minPriceRange.text != "" && self.maxPriceRange.text != "") && (self.minSizeRange.text != "" && self.maxSizeRange.text != "") && (propertySourceLbl.text != ""){
                for filteredPrice in properties {
                    let pricerange = filteredPrice.valueOftotalPrice
                    if Int(pricerange) ?? 0 >= Int(minPrice) ?? 0 && Int(pricerange) ?? 0 <= Int(maxPrice) ?? 0 {
                        print("pricerange \(pricerange)")
                        let sizeRange = filteredPrice.valueOfsizeTextView
                        if Int(sizeRange) ?? 0 >= Int(minSize) ?? 0 && Int(sizeRange) ?? 0 <= Int(maxSize) ?? 0 {
                          print("sizeRange \(sizeRange)")
                          rangeArray.append(filteredPrice)
                        }
                    }
                }
        }
    
       else if (self.minPriceRange.text != "" && self.maxPriceRange.text != "") && (self.minSizeRange.text == ""  && self.maxSizeRange.text == "") && (propertySourceLbl.text == ""){
                for filteredPrice in properties {
                    let pricerange = filteredPrice.valueOftotalPrice
                    if Int(pricerange) ?? 0 >=  Int(minPrice) ?? 0 && Int(pricerange) ?? 0 <=  Int(maxPrice) ?? 0 {
                      print("pricerange \(pricerange)")
                       rangeArray.append(filteredPrice)
                    }
                }
          

    }  else if (self.minPriceRange.text == "" && self.maxPriceRange.text == "") || (self.minSizeRange.text != "" && self.maxSizeRange.text != "") && (propertySourceLbl.text == "") {
                for filteredSize in properties {
                    let sizeRange = filteredSize.valueOfsizeTextView
                    if Int(sizeRange) ?? 0 >=  Int(minSize) ?? 0 && Int(sizeRange) ?? 0 <=  Int(maxSize) ?? 0 {
                        SizeRange = sizeRange
                        print("sizeRange \(SizeRange)")
                        rangeArray.append(filteredSize)
                    }
                }
        print(rangeArray)
        }
        self.showMarker_1()
        self.dropDownSearchView.isHidden = true
        UIView.animate(withDuration: 0.9, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
               self.dropDownSearchView.alpha = 1
               self.dropDownSearchView.layoutIfNeeded()
               }, completion: nil)
        self.markerwindow = markerWindow().loadview()
    }
  
    @IBAction func showSearchViewAction(_ sender: Any) {
        mapView.clear()
        propertySourceLbl.text?.removeAll()
        minSizeRange.text?.removeAll()
        minPriceRange.text?.removeAll()
        maxSizeRange.text?.removeAll()
        maxPriceRange.text?.removeAll()
        self.rangeArray.removeAll()
        self.dropDownSearchView.isHidden = false
        UIView.animate(withDuration: 0.9, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
               self.dropDownSearchView.alpha = 1
               self.dropDownSearchView.layoutIfNeeded()
               }, completion: nil)
    }
    
    func UpdatedLanguage(){
        Helper().showUniversalLoadingView(true)
        let db = Firestore.firestore()
        db.collection("Users").getDocuments() { [self] (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.mainArrayData3 = querySnapshot?.documents.reversed().compactMap { document in
                    // 6
                    try? document.data(as: UserData.self)
                } ?? []

                self.CountData = self.mainArrayData3
            }
        }
    }
    
    func languageUpdate(){
        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser?.uid
        print(userID!)
//        let email = CountData[0].Email
//        print("email is = \(email)")
        let someData = ["appLanguage" : L102Language.currentAppleLanguage()
        ] as [String : Any]
//
        let UpdateRef = db.collection("Users").document(userID!)
        UpdateRef.updateData(someData) { err in
            if let err = err {
                print("Error adding document: \(err)")

                Helper().showUniversalLoadingView(false)

            } else {
                      //print(userID)
                }
                self.UpdatedLanguage()
                Helper().showUniversalLoadingView(false)
            }
        }

    
    override func viewDidAppear(_ animated: Bool) {
        markerwindow.removeFromSuperview()
    }
    
    
    func drawText(text: NSString, inImage:UIImage) -> UIImage? {
        
        let font = UIFont.systemFont(ofSize: 14)
        let size = inImage.size
        //UIGraphicsBeginImageContext(size)
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        inImage.draw(in: CGRect(x: 0, y: 0, width: 50, height: 30))
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = .center
        let attributes:NSDictionary = [ NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.foregroundColor : UIColor.white ]
        
        let textSize = text.size(withAttributes: attributes as? [NSAttributedString.Key : Any])
        let rect = CGRect(x: 0, y: 0, width: 50, height: 30)
        let textRect = CGRect(x: (rect.size.width - textSize.width)/2, y: (rect.size.height - textSize.height)/2 - 2, width: textSize.width, height: textSize.height)
        text.draw(in: textRect.integral, withAttributes: attributes as? [NSAttributedString.Key : Any])
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    func formatNumber(_ n: Int) -> String {
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        print(formatter.string(from: 1.0000)!) // 1
        print(formatter.string(from: 1.2345)!) //
        
        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            print(formatter.string(from: NSNumber(value: formatted))!) //
            let decimal = formatter.string(from: NSNumber(value: formatted))!
            return "\(sign)\(decimal)B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            let decimal = formatter.string(from: NSNumber(value: formatted))!
            return "\(sign)\(decimal)M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            let decimal = formatter.string(from: NSNumber(value: formatted))!
            return "\(sign)\(decimal)K"
            
        case 0...:
            return "\(n)"
            
        default:
            return "\(sign)\(n)"
        }
    }

    func showMarker_1(){
        var bounds = GMSCoordinateBounds()
      
            for item in rangeArray{
                if item.forSoldAndRented == true{
                    print("done")
                }else{
                    let latStr = item.latitude
                    let longStr = item.longitude
                    let lat = Double(latStr)
                    let long = Double(longStr)
                    let marker = GMSMarker()
                    marker.map = mapView
                    marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                    print(item.valueOftotalPrice)
                    let int = ((item.valueOftotalPrice as NSString).integerValue)
                    print(int)
                    let ab = (formatNumber(int))
                    print(ab)
                    
                    if item.Category.contains("rent"){
                        marker.icon = self.drawText(text:"\(ab)" as NSString, inImage: #imageLiteral(resourceName: "imgpsh_fullsize_anim"))
                        
                    }else{
                        marker.icon = self.drawText(text:"\(ab)" as NSString, inImage: #imageLiteral(resourceName: "marker_green"))
                    }
                    marker.isFlat = true
                    marker.userData = item
                    bounds = bounds.includingCoordinate(marker.position)
                }
          
        }
       
    }
    
    
    
    
    func showMarker(){
        var bounds = GMSCoordinateBounds()
        for item in properties{
            
            if item.forSoldAndRented == true{
                print("done")
            }else{
                let latStr = item.latitude
                let longStr = item.longitude
                let lat = Double(latStr)
                let long = Double(longStr)
                let marker = GMSMarker()
                marker.map = mapView
                marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                print(item.valueOftotalPrice)
                let int = ((item.valueOftotalPrice as NSString).integerValue)
                print(int)
                let ab = (formatNumber(int))
                print(ab)
                
                
                if item.Category.contains("rent"){
                    marker.icon = self.drawText(text:"\(ab)" as NSString, inImage: #imageLiteral(resourceName: "imgpsh_fullsize_anim"))
                    
                }else{
                    marker.icon = self.drawText(text:"\(ab)" as NSString, inImage: #imageLiteral(resourceName: "marker_green"))
                }
                marker.isFlat = true
                marker.userData = item
                bounds = bounds.includingCoordinate(marker.position)
            }
           
        }
    
    }
    
    
 
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("didTap marker \(String(describing: marker.userData))")
        Aproperties.removeAll()
        Aproperties_1.removeAll()
        tappedmarker = marker
        //get position of tapped marker
        let position = marker.position
        mapView.animate(toLocation: position)
        let point = mapView.projection.point(for: position)
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)
        
        self.mapView.addSubview(markerwindow)
        markerwindow.infoWindowTableView.delegate = self
        markerwindow.infoWindowTableView.dataSource = self
        // get lat long from current marker
        let markerlat = marker.position.latitude
        let markerlng = marker.position.longitude
        // now check for properties in 5 km radius from the array
        if  valueDropDown != "" {
            for item in rangeArray {
                let latStr = item.latitude
                let longStr = item.longitude
                let lat = Double(latStr)
                let long = Double(longStr)
                let coordinate0 = CLLocation(latitude:markerlat, longitude: markerlng)
                let coordinate1 = CLLocation(latitude: lat!, longitude: long!)
                distanceInMeters = coordinate0.distance(from: coordinate1)
                print(distanceInMeters!)
                let radious = 3 as CLLocationDistance?
                if self.distanceInMeters! <= radious!{
                    Aproperties_1.append(item)
                }
            }
        }else{
            for item_1 in properties {
                let latStr = item_1.latitude
                let longStr = item_1.longitude
                let lat = Double(latStr)
                let long = Double(longStr)
                let coordinate0 = CLLocation(latitude:markerlat, longitude: markerlng)
                let coordinate1 = CLLocation(latitude: lat!, longitude: long!)
                distanceInMeters = coordinate0.distance(from: coordinate1)
                print(distanceInMeters!)
                let radious = 3 as CLLocationDistance?
                if self.distanceInMeters! <= radious!{
                    Aproperties.append(item_1)
                }
            }
           
           
        }
        markerwindow.infoWindowTableView.reloadData()
   
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        // let view = Bundle.main.loadNibNamed("markerWindow", owner: self, options: nil)?[0] as! markerWindow
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        vc.Aproperties = [(marker.userData) as! Propertiesdata]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        markerwindow.removeFromSuperview()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let position = tappedmarker?.position
        markerwindow.center = mapView.projection.point(for: position!)
        markerwindow.center.y -= 100
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool)
    {
        if mapView.selectedMarker != nil
        {
            mapView.selectedMarker = nil
        }
    }

    
    func fetchDatafromFirebase1(){
        Helper().showUniversalLoadingView(true)
        let db = Firestore.firestore()
        db.collection("Properties").getDocuments() { [self] (querySnapshot, err) in
            
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.properties = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Propertiesdata.self)
                } ?? []
                
                print(self.properties)
                showMarker()
                self.markerwindow = markerWindow().loadview()
                mapView.isMyLocationEnabled = true
                guard let lat = self.mapView.myLocation?.coordinate.latitude,
                      let lng = self.mapView.myLocation?.coordinate.longitude else { return }
                let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng, zoom: 14.0)
                self.mapView.animate(to: camera)
                mapCenterPinImage.isHidden = false
                
            }
            
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy h:mm:ss a"
            df.amSymbol = "AM"
            df.pmSymbol = "PM"
            self.properties.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
        }
        
        Helper().showUniversalLoadingView(false)
    }
    
 
  
    @IBAction func swapScreenBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "salepriceViewController") as! salepriceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getMyCurrentLocation() {
        markerwindow.removeFromSuperview()
        mapView.isMyLocationEnabled = true
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
              let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng, zoom: 14.0)
        self.mapView.animate(to: camera)
        mapCenterPinImage.isHidden = false
    }
    
    
    @IBAction func currentLocationAction(_ sender: Any) {
        self.getMyCurrentLocation()
        
    }
    
    
    
    
}


extension mapViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return arrCategories.count}
 
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = forSaleCollectionView.dequeueReusableCell(withReuseIdentifier: "forSaleCollectionViewCell", for: indexPath) as! forSaleCollectionViewCell
        
        cell.cellView.layer.cornerRadius = 13
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = #colorLiteral(red: 0.01752752591, green: 0.01752752591, blue: 0.01752752591, alpha: 1)
        cell.ForSaleItemsLbl.text = arrCategories[indexPath.row].localizedStr()
        cell.cellView.layer.borderColor = indexPath == selectedIndexPath ? #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1) : #colorLiteral(red: 0.01752752591, green: 0.01752752591, blue: 0.01752752591, alpha: 1)
        cell.ForSaleItemsLbl.textColor = indexPath == selectedIndexPath ? #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1) : #colorLiteral(red: 0.01752752591, green: 0.01752752591, blue: 0.01752752591, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        markerwindow.removeFromSuperview()
        selectedIndexPath = indexPath
        collectionView.reloadData()
        valueDropDown = ""
        let propertytype = arrCategories[indexPath.row]
        
        if propertytype != "All Categories"  {
            let db = Firestore.firestore()
            db.collection("Properties").whereField("Category", isEqualTo: propertytype).getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.properties = querySnapshot?.documents.compactMap { document in
                        try? document.data(as: Propertiesdata.self)
                    } ?? []
                    print(self.properties)
                    mapView.clear()
                    showMarker()
                    self.markerwindow = markerWindow().loadview()
                    mapView.isMyLocationEnabled = true
                    guard let lat = self.mapView.myLocation?.coordinate.latitude,
                          let lng = self.mapView.myLocation?.coordinate.longitude else { return }
                    let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng, zoom: 14.0)
                    self.mapView.animate(to: camera)
                    mapCenterPinImage.isHidden = false
                }
                
            }} else if valueDropDown != ""{
                getdata()
                showMarker_1()
            } else { fetchDatafromFirebase1()}
        
        
        
    }
    
  
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if L102Language.currentAppleLanguage() == "ar" {
           
            return CGSize(width: arrCategories[indexPath.item].localizedStr().size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]).width + 44 , height: 40)
        }else{
            return CGSize(width: arrCategories[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]).width + 44 , height: 40)
    }
    }
        
        
        
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return -10
       }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }

}


extension mapViewController: UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if valueDropDown != "" {
            return Aproperties_1.count
        }else{
            return Aproperties.count
        }
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        markerwindow.infoWindowTableView.register(UINib(nibName: "infoWindowTableViewCell", bundle: nil), forCellReuseIdentifier: "infoWindowTableViewCell")
        Helper().showUniversalLoadingView(true)
        let cell =  tableView.dequeueReusableCell(withIdentifier: "infoWindowTableViewCell", for: indexPath) as! infoWindowTableViewCell
        
        if valueDropDown != "" {
       
            if Aproperties_1[indexPath.row].forSoldAndRented == true
        {
            cell.isHidden = true
            tableView.rowHeight = 0.0
            
        }
        else{
            // show cell values
            tableView.rowHeight = 130
            cell.isHidden = false
            
            let DateandTime = self.Aproperties_1[indexPath.item].createdDate.components(separatedBy: " ")
                cell.lblDays.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
             cell.lblBuildingType.text = self.Aproperties_1[indexPath.item].Category.localizedStr()
            let largeNumber = Int(self.Aproperties_1[indexPath.item].valueOftotalPrice.localizedStr())
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
            cell.LblSAR.text = formattedNumber! + " " + "SAR".localizedStr()
            let meter = " m² ";
            cell.LblMeter.text = "📍" + self.Aproperties_1[indexPath.item].valueOfsizeTextView + meter .localizedStr()
            
            cell.purposeLbl.text = self.Aproperties_1[indexPath.item].purpose.localizedStr()
            
            cell.LblDescription.text = self.Aproperties_1[indexPath.item].valueofExtraDetail.localizedStr()
            cell.houseImages.sd_setImage(with: URL(string:self.Aproperties_1[indexPath.item].ImageUrl.first ?? ""), placeholderImage: #imageLiteral(resourceName: "simple_home"))
            
            if Aproperties_1[indexPath.row].bathrooms == "" || Aproperties_1[indexPath.row].bathrooms == "0"{
                cell.bathroomTubLbl.isHidden = true
                cell.bathTubIMG.isHidden = true
           
            }else{
                cell.bathroomTubLbl.isHidden = false
                cell.bathTubIMG.isHidden = false
                cell.bathroomTubLbl.text = self.Aproperties_1[indexPath.item].bathrooms.localizedStr()
           }
            
            if Aproperties_1[indexPath.row].bedrooms == "" || Aproperties_1[indexPath.row].bedrooms == "0" {
                cell.bedroomLbl.isHidden = true
                cell.bedIMG.isHidden = true
           
            }else{
                cell.bedroomLbl.isHidden = false
                cell.bedIMG.isHidden = false
                cell.bedroomLbl.text = self.Aproperties_1[indexPath.item].bedrooms.localizedStr()
           }
            
            
            if Aproperties_1[indexPath.row].eetwidth == "" {
                cell.widthLbl.isHidden = true
                cell.widthImg.isHidden = true
           
            }else{
                cell.widthLbl.isHidden = false
                cell.widthImg.isHidden = false
                let meterwidth = " m ";
                cell.widthLbl.text = self.Aproperties_1[indexPath.item].eetwidth +  meterwidth.localizedStr()
           }
        
            if Aproperties_1[indexPath.row].streetdirection == "" {
                cell.streetImg.isHidden = true
                cell.streetLbl.isHidden = true
                cell.streetView.isHidden = true
               
            }else{
                cell.streetView.isHidden = false
                cell.streetImg.isHidden = false
                cell.streetLbl.isHidden = false
                cell.streetLbl.text = self.Aproperties_1[indexPath.item].streetdirection.localizedStr()
            }
            
        
        }} else {
            
            if Aproperties[indexPath.row].forSoldAndRented == true
            {
                cell.isHidden = true
                tableView.rowHeight = 0.0
                
            }
            else{
                // show cell values
                tableView.rowHeight = 130
                cell.isHidden = false
                
                let DateandTime = self.Aproperties[indexPath.item].createdDate.components(separatedBy: " ")
                    cell.lblDays.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
                 cell.lblBuildingType.text = self.Aproperties[indexPath.item].Category.localizedStr()
                let largeNumber = Int(self.Aproperties[indexPath.item].valueOftotalPrice.localizedStr())
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
                cell.LblSAR.text = formattedNumber! + " " + "SAR".localizedStr()
                let meter = " m² ";
                cell.LblMeter.text = "📍" + self.Aproperties[indexPath.item].valueOfsizeTextView + meter .localizedStr()
                
                cell.purposeLbl.text = self.Aproperties[indexPath.item].purpose.localizedStr()
                
                cell.LblDescription.text = self.Aproperties[indexPath.item].valueofExtraDetail.localizedStr()
                cell.houseImages.sd_setImage(with: URL(string:self.Aproperties[indexPath.item].ImageUrl.first ?? ""), placeholderImage: #imageLiteral(resourceName: "simple_home"))
                
                if Aproperties[indexPath.row].bathrooms == "" || Aproperties[indexPath.row].bathrooms == "0"{
                    cell.bathroomTubLbl.isHidden = true
                    cell.bathTubIMG.isHidden = true
               
                }else{
                    cell.bathroomTubLbl.isHidden = false
                    cell.bathTubIMG.isHidden = false
                    cell.bathroomTubLbl.text = self.Aproperties[indexPath.item].bathrooms.localizedStr()
               }
                
                if Aproperties[indexPath.row].bedrooms == "" || Aproperties[indexPath.row].bedrooms == "0" {
                    cell.bedroomLbl.isHidden = true
                    cell.bedIMG.isHidden = true
               
                }else{
                    cell.bedroomLbl.isHidden = false
                    cell.bedIMG.isHidden = false
                    cell.bedroomLbl.text = self.Aproperties[indexPath.item].bedrooms.localizedStr()
               }
                
                
                if Aproperties[indexPath.row].eetwidth == "" {
                    cell.widthLbl.isHidden = true
                    cell.widthImg.isHidden = true
               
                }else{
                    cell.widthLbl.isHidden = false
                    cell.widthImg.isHidden = false
                    let meterwidth = " m ";
                    cell.widthLbl.text = self.Aproperties[indexPath.item].eetwidth +  meterwidth.localizedStr()
               }
            
                if Aproperties[indexPath.row].streetdirection == "" {
                    cell.streetImg.isHidden = true
                    cell.streetLbl.isHidden = true
                    cell.streetView.isHidden = true
                   
                }else{
                    cell.streetView.isHidden = false
                    cell.streetImg.isHidden = false
                    cell.streetLbl.isHidden = false
                    cell.streetLbl.text = self.Aproperties[indexPath.item].streetdirection.localizedStr()
                }
                
            
            }
            
            
        }
        
        Helper().showUniversalLoadingView(false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if valueDropDown != ""{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
            vc.Aproperties = [(Aproperties_1[indexPath.item])]
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        vc.Aproperties = [(Aproperties[indexPath.item])]
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class forSaleCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet var cellView: UIView!
    @IBOutlet var ForSaleItemsLbl: UILabel!
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}


extension mapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return droplist.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let mylist = droplist[row]
       // propertySourceLbl.text = "\(mylist)"
        return mylist
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        propertySourceLbl.text = droplist[row].localizedStr()
        valueDropDown = droplist[row]
    }
}
