//
//  setFilterVC.swift
//  trad
//
//  Created by Imac on 11/05/21.
//

import UIKit
import GoogleMaps



class setFilterVC: UIViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout {
    
    var pickerView = UIPickerView()
    var arrayAge = [" ","New","1 year","2 year","3 year","4 year","5 year","6 year","7 year","8 year","9 year","10 year","11 year","12 year","13 year","14 year","15 year","16 year","17 year","18 year","19 year","20 year","21 year","22 year","23 year","24 year","25 year","26 year","27 year","28 year","29 year","30 year","31 year","32 year","33 year","34 year","35+ year"]
    
    var arrayLevel = [" " ,"0","1 ","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    
    var arrayEetwidth = [" ","5","8","10","12","15","18","20","25","28","30","36","40","60","80","100"]
    
    
    var arrayStreetData = [" ","North","East","West","South","Northeast","Southeast","southwest","Northwest","3 streets", "4 streets"]
    
   // var arrayPropertySource = ["Owner","Agent","Government"]
    var arrayPropertySource = [" ","0","1","2"]
    
    var toolBar = UIToolbar()
    var levelCheck = ""
    var StreetCheck = ""
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    
    @IBOutlet var backgroundscrollview: UIScrollView!
    @IBOutlet var backgroundstackview: UIStackView!
    @IBOutlet var streetDirectionCollectionView: UICollectionView!
    @IBOutlet var continueBtn: UIButton!
    @IBOutlet var viewforsingleorfamily: UIView!
    @IBOutlet var viewfordailyormonthlyoryearly: UIView!
    @IBOutlet var streetDirectionLblView: UIView!
    @IBOutlet var purposeLblView: UIView!
    @IBOutlet var viewforbedrooms: UIView!
    @IBOutlet var viewforappartments: UIView!
    @IBOutlet var viewforlivingrooms: UIView!
    @IBOutlet var viewforbathrooms: UIView!
    @IBOutlet var viewstreetwidth: UIView!
    @IBOutlet var viewforinternalstairs: UIView!
    @IBOutlet var viewforlevel: UIView!
    @IBOutlet var viewforage: UIView!
    @IBOutlet var viewfordriverroom: UIView!
    @IBOutlet var viewformaidroom: UIView!
    @IBOutlet var viewforpool: UIView!
    @IBOutlet var viewforfurnished: UIView!
    @IBOutlet var viewfortent: UIView!
    @IBOutlet var viewforextraspace: UIView!
    @IBOutlet var viewforkitchen: UIView!
    @IBOutlet var viewforextraunit: UIView!
    @IBOutlet var viewforcarentrance: UIView!
    @IBOutlet var viewforbasement: UIView!
    @IBOutlet var viewforlift: UIView!
    @IBOutlet var viewforduplex: UIView!
    @IBOutlet var viewfortype: UIView!
    @IBOutlet var viewforairconditioner: UIView!
    @IBOutlet var viewforstores: UIView!
    @IBOutlet var viewforfootballspace: UIView!
    @IBOutlet var viewforvolleyballspace: UIView!
    @IBOutlet var viewforplayground: UIView!
    @IBOutlet var viewforfamilysection: UIView!
    @IBOutlet var viewforOfWells: UIView!
    @IBOutlet var viewforOfTrees: UIView!
    @IBOutlet var viewforOfRooms: UIView!
    @IBOutlet weak var streetDirectionView: UIView!
    
    @IBOutlet var propertySourceView: UIView!
    @IBOutlet var propertySourceBtn: UIButton!
    
    @IBOutlet weak var streetDirectionBtn: UIButton!
    @IBOutlet var singleBtn: UIButton!
    @IBOutlet var familyBtn: UIButton!
    @IBOutlet var dailyBtn: UIButton!
    @IBOutlet var monthlyBtn: UIButton!
    @IBOutlet var yearlyBtn: UIButton!
    
   
    @IBOutlet var bedRoomsValueLbl: UILabel!
    @IBOutlet var apartmentsValueLbl: UILabel!
    @IBOutlet var livingRoomsValueLbl: UILabel!
    @IBOutlet var bathRoomsValueLbl: UILabel!
    @IBOutlet var storesValueLbl: UILabel!
    @IBOutlet var streeetWidthvalueLbl: UILabel!
    @IBOutlet var ofRoomsValue: UILabel!
    
    @IBOutlet var bedRoomSlide: UISlider!
    @IBOutlet var apartmentsSlide: UISlider!
    @IBOutlet var livingRoomsSlide: UISlider!
    @IBOutlet var bathRoomsSlide: UISlider!
    @IBOutlet var storesSlide: UISlider!
    @IBOutlet var ofRoomsSlider: UISlider!
    
    @IBOutlet var residentialBtn: UIButton!
    @IBOutlet var commercialBtn: UIButton!
    @IBOutlet var bothBtn: UIButton!
    
    @IBOutlet var levelBtn: UIButton!
    @IBOutlet var ageBtn: UIButton!
    @IBOutlet var levelLbl: UILabel!
    @IBOutlet var ageLbl: UILabel!
    @IBOutlet var streetBtn: UIButton!
    
    @IBOutlet var ofWellsTextfield: UITextField!
    @IBOutlet var ofTreeTextfield: UITextField!
    @IBOutlet var propertyType: UILabel!
    @IBOutlet var propertySourceLbl: UILabel!
    @IBOutlet weak var streetDirectionLbl: UILabel!
    @IBOutlet var internalStraisSwitch: UISwitch!
    @IBOutlet var driverRoomSwitch: UISwitch!
    @IBOutlet var maidRoomSwitch: UISwitch!
    @IBOutlet var poolSwitch: UISwitch!
    @IBOutlet var furnishedSwitch: UISwitch!
    @IBOutlet var tentSwitch: UISwitch!
    @IBOutlet var extraSpaceSwitch: UISwitch!
    @IBOutlet var extraUnitSwitch: UISwitch!
    @IBOutlet var carEnterSwitch: UISwitch!
    @IBOutlet var basmentSwitch: UISwitch!
    @IBOutlet var liftSwitch: UISwitch!
    @IBOutlet var duplexSwitch: UISwitch!
    @IBOutlet var kitchenSwitch: UISwitch!
    @IBOutlet var footballSwitch: UISwitch!
    @IBOutlet var vollyBallSwitch: UISwitch!
    @IBOutlet var playgroundSwitch: UISwitch!
    @IBOutlet var familySwitch: UISwitch!
    @IBOutlet var airConditionerSwitch: UISwitch!
    @IBOutlet var plateNumberText: UITextField!
    @IBOutlet weak var plateNumberView: UIView!
    
    var updatePropertyData: [Propertiesdata] = []
    
    let step:Float = 1
    var valueForsingleorfamily = ""
    var valueFordailyormonthlyoryearly = ""
    var valueForbedrooms = ""
    var valueForappartments = ""
    var valueForlivingrooms = ""
    var valueForbathrooms = ""
    var valueForstreetwidth = ""
    var valueForinternalstairs = false
    var valueForlevel = ""
    var valueForage = ""
    var valueFordriverroom = false
    var valueFormaidroom = false
    var valueForpool = false
    var valueForfurnished = false
    var valueFortent = false
    var valueForextraspace = false
    var valueForkitchen = false
    var valueForextraunit = false
    var valueForcarentrance = false
    var valueForbasement = false
    var valueForlift = false
    var valueForduplex = false
    var valueForairconditioner = false
    var valueForpurpose = ""
    var valueForstreetdirection = ""
    var valueForPropertySource = ""
    var valueForstores = ""
    var valueForfootballspace = false
    var valueForvolleyballspace = false
    var valueForplayground = false
    var valueForroomsslider = ""
    var valueForfamilysection = false
    var valueFordirection = String()
    var valueForLandType = ""
    var valueForOfRooms = ""
    var CategoryDetail2 =  String()
    var categoryindex =  Int()
    var ArrayImages = [String]()
    var arrayVideos = [String]()
    var isHeightCalculated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.updatePropertyData.count == 0 {
            self.propertyType.text = CategoryDetail2.localizedStr()
            self.updateview()
            
            if self.propertyType.text == "Land".localizedStr() || self.propertyType.text == "Building".localizedStr() {
                
                valueForpurpose = "Residential"
               
            } else if self.propertyType.text == "Apartment".localizedStr() {
                valueForsingleorfamily = "Family"
                valueFordailyormonthlyoryearly = "Yearly"
                
            } else  if self.propertyType.text == "Room".localizedStr()  ||  self.propertyType.text == "Esteraha".localizedStr() {
              
                valueFordailyormonthlyoryearly = "Yearly"
                
            }else {
                
                valueForsingleorfamily = ""
                valueFordailyormonthlyoryearly = ""
                valueForpurpose = ""
            }
            
        
            
            
        } else {
            self.tabBarController?.tabBar.isHidden = true
            self.propertyType.text = updatePropertyData[0].selectCategory.localizedStr()
            self.CategoryDetail2 = updatePropertyData[0].selectCategory
            self.apartmentsValueLbl.text = updatePropertyData[0].apartment
            self.livingRoomsValueLbl.text = updatePropertyData[0].livingrooms
            self.bathRoomsValueLbl.text =  updatePropertyData[0].bathrooms
            self.storesValueLbl.text = updatePropertyData[0].stores
            self.ofRoomsValue.text = updatePropertyData[0].OfRooms
            self.updateview()
            self.checkSlider()
            self.typeProperty()
            self.dailyormonthlyoryearly()
            self.singleorfamily()
            self.sliderBedButtons()
            self.ageLbl.text = updatePropertyData[0].age
            self.valueForage = updatePropertyData[0].age
            self.levelLbl.text = updatePropertyData[0].level
            self.valueForlevel = updatePropertyData[0].level
            self.streetDirectionLbl.text = updatePropertyData[0].streetdirection
            self.valueForstreetdirection =  updatePropertyData[0].streetdirection
            self.valueForPropertySource =  updatePropertyData[0].propertySource
            self.propertySourceLbl.text = updatePropertyData[0].propertySource
            self.streeetWidthvalueLbl.text = updatePropertyData[0].eetwidth
            self.valueForstreetwidth = updatePropertyData[0].eetwidth
            self.ofWellsTextfield.text = updatePropertyData[0].ofWellsText
            self.ofTreeTextfield.text = updatePropertyData[0].ofTreeText
            self.plateNumberText.text = updatePropertyData[0].plateNo
        }
        self.continueBtn.layer.cornerRadius = 24
       // self.streetDirectionCollectionView.delegate = self
      //  self.streetDirectionCollectionView.dataSource = self
        self.residentialBtn.layer.borderWidth = 1
        self.residentialBtn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.residentialBtn.layer.cornerRadius = 16
        self.commercialBtn.layer.borderWidth = 1
        self.commercialBtn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.commercialBtn.layer.cornerRadius = 16
        self.bothBtn.layer.borderWidth = 1
        self.bothBtn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.bothBtn.layer.cornerRadius = 16
        plateNumberText.delegate = self
        self.pickerView.isHidden = true
        self.hideKeyboardWhenTappedAround()
       // if let flowLayout = streetDirectionCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
        //    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            ofWellsTextfield.delegate = self
            ofTreeTextfield.delegate = self
      //  }
        singleBtn.setTitle("singleBtn".localizedStr(), for: .normal)
        familyBtn.setTitle("familyBtn".localizedStr(), for: .normal)
        dailyBtn.setTitle("dailyBtn".localizedStr(), for: .normal)
        monthlyBtn.setTitle("monthlyBtn".localizedStr(), for: .normal)
        yearlyBtn.setTitle("yearlyBtn".localizedStr(), for: .normal)
        continueBtn.setTitle("continueBtn".localizedStr(), for: .normal)
        
        
        
        
        
        
    
    }
    
    
   
  
    
    override func viewWillAppear(_ animated: Bool) {
        self.backgroundscrollview.contentSize = CGSize(width:self.view.frame.size.width, height: self.backgroundstackview.frame.size.height)
        
    
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        ofWellsTextfield.endEditing(true)
        ofTreeTextfield.endEditing(true)
        plateNumberText.endEditing(true)
        return false }
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func typeProperty() {
        if updatePropertyData[0].purpose == "Residential"{
            residentialBtn.isSelected = true
            commercialBtn.isSelected = false
            bothBtn.isSelected = false
            residentialBtn.setTitleColor(.white, for: .normal)
            residentialBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            commercialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            commercialBtn.backgroundColor = .white
            bothBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            bothBtn.backgroundColor = .white
            residentialBtn.layer.borderWidth = 0
            commercialBtn.layer.borderWidth = 1
            bothBtn.layer.borderWidth = 1
            valueForpurpose = "Residential"
            
        } else if updatePropertyData[0].purpose == "Commercial" {
            
            residentialBtn.isSelected = false
            commercialBtn.isSelected = true
            bothBtn.isSelected = false
            residentialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            residentialBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            commercialBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            commercialBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            bothBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            bothBtn.backgroundColor = .white
            residentialBtn.layer.borderWidth = 1
            commercialBtn.layer.borderWidth = 0
            bothBtn.layer.borderWidth = 1
            valueForpurpose = "Commercial"
            
            
        } else if updatePropertyData[0].purpose == "Commercial&Residential" {
            
            
            residentialBtn.isSelected = false
            commercialBtn.isSelected = false
            bothBtn.isSelected = true
            residentialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            residentialBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            commercialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            commercialBtn.backgroundColor = .white
            bothBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            bothBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            residentialBtn.layer.borderWidth = 1
            commercialBtn.layer.borderWidth = 1
            bothBtn.layer.borderWidth = 0
            valueForpurpose = "Commercial&Residential"
        }
        
        
    }
    
    
    
    func  sliderBedButtons() {
        
        self.bedRoomSlide.minimumValue = 0
        self.bedRoomSlide.maximumValue = 7
        if updatePropertyData[0].bedrooms != "0" {
            if CategoryDetail2 == "Villa" || CategoryDetail2 == "Apartment" || CategoryDetail2 == "Furnished Apartment" {
                self.bedRoomSlide.setValue((updatePropertyData[0].bedrooms).floatValue, animated: true)
                let slideValue = Int(self.bedRoomSlide.value)
                self.bedRoomsValueLbl.text = "\(String(describing: slideValue))"
                self.valueForbedrooms = "\(slideValue)"
            }else if CategoryDetail2 == "Floor" || CategoryDetail2 == "Small house" {
                
                self.bedRoomSlide.setValue((updatePropertyData[0].bedrooms).floatValue, animated: true)
                let slideValue = Int(self.bedRoomSlide.value)
                self.bedRoomsValueLbl.text = "\(String(describing: slideValue))"
                self.valueForbedrooms = "\(slideValue)"
                
            }
        }
        
        self.apartmentsSlide.minimumValue = 0
        self.apartmentsSlide.maximumValue = 4
        
        if updatePropertyData[0].apartment != "0" {
            if CategoryDetail2 == "Villa"{
                self.apartmentsSlide.setValue((updatePropertyData[0].apartment).floatValue, animated: true)
                let slideValue = Int(self.apartmentsSlide.value)
                self.apartmentsValueLbl.text = "\(String(describing: slideValue))"
                self.valueForappartments = "\(slideValue)"
            } else  if CategoryDetail2 == "Building" {
                self.apartmentsSlide.setValue((updatePropertyData[0].apartment).floatValue, animated: true)
                let slideValue = Int(self.apartmentsSlide.value)
                self.apartmentsValueLbl.text = "\(String(describing: slideValue))"
                self.valueForappartments = "\(slideValue)"
            }
        }
        
        
        self.livingRoomsSlide.minimumValue = 0
        self.livingRoomsSlide.maximumValue = 5
        
        if updatePropertyData[0].livingrooms != "0" {
            
            self.livingRoomsSlide.setValue((updatePropertyData[0].livingrooms).floatValue, animated: true)
            let slideValue = Int(self.livingRoomsSlide.value)
            self.livingRoomsValueLbl.text = "\(String(describing: slideValue))"
            self.valueForlivingrooms = "\(slideValue)"
            
        }
        
        self.bathRoomsSlide.minimumValue = 0
        self.bathRoomsSlide.maximumValue = 5
        
        if updatePropertyData[0].bathrooms != "0" {
            
            self.bathRoomsSlide.setValue((updatePropertyData[0].bathrooms).floatValue, animated: true)
            let slideValue = Int(self.bathRoomsSlide.value)
            self.bathRoomsValueLbl.text = "\(String(describing: slideValue))"
            self.valueForbathrooms = "\(slideValue)"
            
        }
 
        
        self.storesSlide.minimumValue = 0
        self.storesSlide.maximumValue = 5
        
        if updatePropertyData[0].stores != "0" {
            
            self.storesSlide.setValue((updatePropertyData[0].stores).floatValue, animated: true)
            let slideValue = Int(self.storesSlide.value)
            self.storesValueLbl.text = "\(String(describing: slideValue))"
            self.valueForstores = "\(slideValue)"
        }
        
        self.ofRoomsSlider.minimumValue = 0
        self.ofRoomsSlider.maximumValue = 15
        
        if updatePropertyData[0].OfRooms != "0" {
            
            self.ofRoomsSlider.setValue((updatePropertyData[0].OfRooms).floatValue, animated: true)
            let slideValue = Int(self.ofRoomsSlider.value)
            self.ofRoomsValue.text = "\(String(describing: slideValue))"
            self.valueForOfRooms = "\(slideValue)"
        }
        
    }
    
    
    
    
    
    
    
    
    
    func checkSlider() {
        if updatePropertyData[0].internalstairs == true {
                internalStraisSwitch.setOn(updatePropertyData[0].internalstairs, animated : true)
                valueForinternalstairs = true
            }else{
                internalStraisSwitch.setOn(updatePropertyData[0].internalstairs, animated : true)
                valueForinternalstairs = false
            }
          
        if updatePropertyData[0].driverroom == true{
            driverRoomSwitch.setOn(updatePropertyData[0].driverroom, animated : true)
            valueFordriverroom = true
        }else{
            driverRoomSwitch.setOn(updatePropertyData[0].driverroom, animated : true)
            valueFordriverroom = false
        }
        
        if updatePropertyData[0].maidroom == true{
            maidRoomSwitch.setOn(updatePropertyData[0].maidroom, animated : true)
            valueFormaidroom = true
        }else{
            maidRoomSwitch.setOn(updatePropertyData[0].maidroom, animated : true)
            valueFormaidroom = false
        }
        
        if updatePropertyData[0].pool == true{
            poolSwitch.setOn(updatePropertyData[0].pool, animated : true)
            valueForpool = true
        }else{
            poolSwitch.setOn(updatePropertyData[0].pool, animated : true)
            valueForpool = false
        }
        
        if updatePropertyData[0].furnished == true{
            furnishedSwitch.setOn(updatePropertyData[0].furnished, animated : true)
            valueForfurnished = true
        }else{
            furnishedSwitch.setOn(updatePropertyData[0].furnished, animated : true)
            valueForfurnished = false
        }
        
        if updatePropertyData[0].tent == true{
            tentSwitch.setOn(updatePropertyData[0].tent, animated : true)
            valueFortent = true
        }else{
            tentSwitch.setOn(updatePropertyData[0].tent, animated : true)
            valueFortent = false
        }
        
        if updatePropertyData[0].extraspace == true{
            extraSpaceSwitch.setOn(updatePropertyData[0].extraspace, animated : true)
            valueForextraspace = true
        }else{
            extraSpaceSwitch.setOn(updatePropertyData[0].extraspace, animated : true)
            valueForextraspace = false
        }
        
        if updatePropertyData[0].kitchen == true{
            kitchenSwitch.setOn(updatePropertyData[0].kitchen, animated : true)
            valueForkitchen = true
        }else{
            kitchenSwitch.setOn(updatePropertyData[0].kitchen, animated : true)
            valueForkitchen = false
        }
        
        if updatePropertyData[0].extraunit == true{
            extraUnitSwitch.setOn(updatePropertyData[0].extraunit, animated : true)
            valueForextraunit = true
        }else{
            extraUnitSwitch.setOn(updatePropertyData[0].extraunit, animated : true)
            valueForextraunit = false
        }
        
        if updatePropertyData[0].carentrance == true{
            carEnterSwitch.setOn(updatePropertyData[0].carentrance, animated : true)
            valueForcarentrance = true
        }else{
            carEnterSwitch.setOn(updatePropertyData[0].carentrance, animated : true)
            valueForcarentrance = false
        }
        
        if updatePropertyData[0].basement == true{
            basmentSwitch.setOn(updatePropertyData[0].basement, animated : true)
            valueForbasement = true
        }else{
            basmentSwitch.setOn(updatePropertyData[0].basement, animated : true)
            valueForbasement = false
        }
        
        if updatePropertyData[0].lift == true{
            liftSwitch.setOn(updatePropertyData[0].lift, animated : true)
            valueForlift = true
        }else{
            liftSwitch.setOn(updatePropertyData[0].lift, animated : true)
            valueForlift = false
        }
        
        if updatePropertyData[0].duplex == true{
            duplexSwitch.setOn(updatePropertyData[0].duplex, animated : true)
            valueForduplex = true
        }else{
            liftSwitch.setOn(updatePropertyData[0].duplex, animated : true)
            valueForduplex = false
        }
        
        if updatePropertyData[0].airconditioner == true{
            airConditionerSwitch.setOn(updatePropertyData[0].airconditioner, animated : true)
            valueForairconditioner = true
        }else{
            airConditionerSwitch.setOn(updatePropertyData[0].airconditioner, animated : true)
            valueForairconditioner = false
        }
        
        if updatePropertyData[0].footballspace == true{
            footballSwitch.setOn(updatePropertyData[0].footballspace, animated : true)
            valueForfootballspace = true
        }else{
            footballSwitch.setOn(updatePropertyData[0].footballspace, animated : true)
            valueForfootballspace = false
        }
        
        if updatePropertyData[0].volleyballspace == true{
            vollyBallSwitch.setOn(updatePropertyData[0].volleyballspace, animated : true)
            valueForvolleyballspace = true
        }else{
            vollyBallSwitch.setOn(updatePropertyData[0].volleyballspace, animated : true)
            valueForvolleyballspace = false
        }
        
        if updatePropertyData[0].familysection == true{
            familySwitch.setOn(updatePropertyData[0].familysection, animated : true)
            valueForfamilysection = true
        }else{
            familySwitch.setOn(updatePropertyData[0].familysection, animated : true)
            valueForfamilysection = false
        }
    }
    
    
    
    
    func updateview(){
        self.viewforsingleorfamily.isHidden = true
        self.viewfordailyormonthlyoryearly.isHidden = true
        self.viewforbedrooms.isHidden = true
        self.viewforappartments.isHidden = true
        self.viewforlivingrooms.isHidden = true
        self.viewforbathrooms.isHidden = true
        self.viewstreetwidth.isHidden = true
        self.viewforinternalstairs.isHidden = true
        self.viewforlevel.isHidden = true
        self.viewforage.isHidden = true
        self.viewfordriverroom.isHidden = true
        self.viewformaidroom.isHidden = true
        self.viewforpool.isHidden = true
        self.viewforfurnished.isHidden = true
        self.viewfortent.isHidden = true
        self.viewforextraspace.isHidden = true
        self.viewforkitchen.isHidden = true
        self.viewforextraunit.isHidden = true
        self.viewforcarentrance.isHidden = true
        self.viewforbasement.isHidden = true
        self.viewforlift.isHidden = true
        self.viewforduplex.isHidden = true
        self.viewfortype.isHidden = true
        self.viewforairconditioner.isHidden = true
       // self.streetDirectionCollectionView.isHidden = true
        self.streetDirectionView.isHidden = true
        self.propertySourceView.isHidden = true
        self.viewforstores.isHidden = true
        self.viewforfootballspace.isHidden = true
        self.viewforvolleyballspace.isHidden = true
        self.viewforplayground.isHidden = true
        self.viewforfamilysection.isHidden = true
       // self.streetDirectionLblView.isHidden = true
        self.viewforOfWells.isHidden = true
        self.viewforOfTrees.isHidden = true
        self.viewforOfRooms.isHidden = true
        
        
        if CategoryDetail2 == "Apartment"{
            
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
           // self.streetDirectionLblView.isHidden = false
            self.viewforsingleorfamily.isHidden = false
            self.viewfordailyormonthlyoryearly.isHidden = false
            self.viewforbedrooms.isHidden = false
            self.viewforlivingrooms.isHidden = false
            self.viewforbathrooms.isHidden = false
            self.viewforlevel.isHidden = false
            self.viewforage.isHidden = false
            self.viewforfurnished.isHidden = false
            self.viewforkitchen.isHidden = false
            self.viewforextraunit.isHidden = false
            self.viewforcarentrance.isHidden = false
            self.viewforlift.isHidden = false
            self.viewforairconditioner.isHidden = false
            self.viewstreetwidth.isHidden = false
            
        }
        else if CategoryDetail2 == "Villa" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
           // self.streetDirectionLblView.isHidden = false
            self.viewforbedrooms.isHidden = false
            self.viewforappartments.isHidden = false
            self.viewforlivingrooms.isHidden = false
            self.viewforbathrooms.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewforinternalstairs.isHidden = false
            self.viewforage.isHidden = false
            self.viewfordriverroom.isHidden = false
            self.viewformaidroom.isHidden = false
            self.viewforpool.isHidden = false
            self.viewforfurnished.isHidden = false
            self.viewfortent.isHidden = false
            self.viewforextraspace.isHidden = false
            self.viewforkitchen.isHidden = false
            self.viewforextraunit.isHidden = false
            self.viewforcarentrance.isHidden = false
            self.viewforbasement.isHidden = false
            self.viewforlift.isHidden = false
            self.viewforduplex.isHidden = false
            self.viewforairconditioner.isHidden = false
            
        }
        else if CategoryDetail2 == "Land" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
           // self.streetDirectionLblView.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewfortype.isHidden = false
            
            
        }
        
        else if CategoryDetail2 == "Floor" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
          //  self.streetDirectionLblView.isHidden = false
            self.viewforbedrooms.isHidden = false
            self.viewforlivingrooms.isHidden = false
            self.viewforbathrooms.isHidden = false
            self.viewforlevel.isHidden = false
            self.viewforage.isHidden = false
            self.viewforfurnished.isHidden = false
            self.viewforcarentrance.isHidden = false
            self.viewforairconditioner.isHidden = false
            
        }
        
        else if CategoryDetail2 == "Building" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
           // self.streetDirectionLblView.isHidden = false
            self.viewfortype.isHidden = false
            self.viewforappartments.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewforage.isHidden = false
            self.viewforfurnished.isHidden = false
            self.viewforstores.isHidden = false
            self.viewforOfRooms.isHidden = false
            
            
        }
        
        else if CategoryDetail2 == "Esteraha" {
            self.viewfordailyormonthlyoryearly.isHidden = false
            self.viewforlivingrooms.isHidden = false
            self.viewforbathrooms.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewforpool.isHidden = false
            self.viewfortent.isHidden = false
            self.viewforkitchen.isHidden = false
            self.viewforfootballspace.isHidden = false
            self.viewforvolleyballspace.isHidden = false
            self.viewforplayground.isHidden = false
            //self.viewforroomsslider.isHidden = false
            self.viewforfamilysection.isHidden = false
            self.viewforage.isHidden = false
            self.viewforOfRooms.isHidden = false
            self.propertySourceView.isHidden = false
            
        }
        
        else if CategoryDetail2 == "Store" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
           // self.streetDirectionLblView.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewforage.isHidden = false
        }
        else if CategoryDetail2 == "Farm" {
            self.viewforOfWells.isHidden = false
            self.viewforOfTrees.isHidden = false
            self.viewfortent.isHidden = false
            self.propertySourceView.isHidden = false
        }
        
        else if CategoryDetail2 == "Room" {
            self.viewfordailyormonthlyoryearly.isHidden = false
            self.viewforage.isHidden = false
            self.viewforfurnished.isHidden = false
            self.viewforkitchen.isHidden = false
            self.propertySourceView.isHidden = false
            
        }
        else if CategoryDetail2 == "Office" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
           // self.streetDirectionLblView.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewforage.isHidden = false
            self.viewforfurnished.isHidden = false
            
        }
        else if CategoryDetail2 == "Tent" {
            self.propertySourceView.isHidden = false
            self.viewfordailyormonthlyoryearly.isHidden = false
            self.viewforfamilysection.isHidden = false
            
        }
        else if CategoryDetail2 == "Warehouse" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
          //  self.streetDirectionLblView.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewforage.isHidden = false
            
        }
        
        else if CategoryDetail2 == "Furnished Apartment" {
            self.propertySourceView.isHidden = false
            self.streetDirectionView.isHidden = false
           // self.streetDirectionLblView.isHidden = false
            self.viewforbedrooms.isHidden = false
            self.viewforlivingrooms.isHidden = false
            self.viewforbathrooms.isHidden = false
            self.viewstreetwidth.isHidden = false
            self.viewforlevel.isHidden = false
            self.viewforage.isHidden = false
            self.viewforkitchen.isHidden = false
            self.viewforextraunit.isHidden = false
            self.viewforcarentrance.isHidden = false
            self.viewforlift.isHidden = false
        }
    }
    
    
    
    
    func singleorfamily() {
        
        if updatePropertyData[0].singleorfamily == "Single" {
            singleBtn.isSelected = true
            familyBtn.isSelected = false
            singleBtn.setTitleColor(.white, for: .selected)
            singleBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            familyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            familyBtn.backgroundColor = .white
            valueForsingleorfamily = "Single".localizedStr()
        } else if updatePropertyData[0].singleorfamily == "Family" {
            
            singleBtn.isSelected = false
            familyBtn.isSelected = true
            singleBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            singleBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            familyBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
            familyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            valueForsingleorfamily = "Family".localizedStr()
            
        } }
    
    @IBAction func singleBtnAction(_ sender: Any) {
        singleBtn.isSelected = true
        familyBtn.isSelected = false
        singleBtn.setTitleColor(.white, for: .selected)
        singleBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        familyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        familyBtn.backgroundColor = .white
        valueForsingleorfamily = "Single"
    }
    
    @IBAction func familyBtnAction(_ sender: Any) {
        singleBtn.isSelected = false
        familyBtn.isSelected = true
        singleBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        singleBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        familyBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        familyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        valueForsingleorfamily = "Family"
    }
    
    
    
    func dailyormonthlyoryearly() {
        if updatePropertyData[0].dailyormonthlyoryearly == "Daily" {
            dailyBtn.isSelected = true
            monthlyBtn.isSelected = false
            yearlyBtn.isSelected = false
            dailyBtn.setTitleColor(.white, for: .selected)
            dailyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            monthlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            monthlyBtn.backgroundColor = .white
            yearlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            yearlyBtn.backgroundColor = .white
            valueFordailyormonthlyoryearly = "Daily"
        } else if updatePropertyData[0].dailyormonthlyoryearly == "Monthly" {
            
            dailyBtn.isSelected = false
            monthlyBtn.isSelected = true
            yearlyBtn.isSelected = false
            dailyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            dailyBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            monthlyBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
            monthlyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            yearlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            yearlyBtn.backgroundColor = .white
            valueFordailyormonthlyoryearly = "Monthly"
            
        } else if updatePropertyData[0].dailyormonthlyoryearly == "Yearly" {
            
            dailyBtn.isSelected = false
            monthlyBtn.isSelected = false
            yearlyBtn.isSelected = true
            dailyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            dailyBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            monthlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
            monthlyBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            yearlyBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
            yearlyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            valueFordailyormonthlyoryearly = "Yearly"
        }
    }
    
    @IBAction func dailyBtnAction(_ sender: Any) {
        dailyBtn.isSelected = true
        monthlyBtn.isSelected = false
        yearlyBtn.isSelected = false
        dailyBtn.setTitleColor(.white, for: .selected)
        dailyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        monthlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        monthlyBtn.backgroundColor = .white
        yearlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        yearlyBtn.backgroundColor = .white
        valueFordailyormonthlyoryearly = "Daily"
    }
    @IBAction func monthlyBtnAction(_ sender: Any) {
        dailyBtn.isSelected = false
        monthlyBtn.isSelected = true
        yearlyBtn.isSelected = false
        dailyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        dailyBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        monthlyBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        monthlyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        yearlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        yearlyBtn.backgroundColor = .white
        valueFordailyormonthlyoryearly = "Monthly"
    }
    @IBAction func yearlyBtnAction(_ sender: Any) {
        dailyBtn.isSelected = false
        monthlyBtn.isSelected = false
        yearlyBtn.isSelected = true
        dailyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        dailyBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        monthlyBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        monthlyBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        yearlyBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        yearlyBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        valueFordailyormonthlyoryearly = "Yearly"
    }
    @IBAction func bedRoomsSlider(_ sender: UISlider) {
        if CategoryDetail2 == "Villa" || CategoryDetail2 == "Apartment" || CategoryDetail2 == "Furnished Apartment" {
            let roundedStepValue = round(sender.value / step) * step
            bedRoomSlide.value = roundedStepValue
            bedRoomSlide.minimumValue = 0
            bedRoomSlide.maximumValue = 7
            let currentValue = Int(bedRoomSlide.value)
            bedRoomsValueLbl.text = "\(currentValue)"
            valueForroomsslider = "\(currentValue)"
            if "\(currentValue)" == "\(7)"{
                bedRoomsValueLbl.text = "7+"
            }
            valueForbedrooms = "\(currentValue)"
            
        } else if CategoryDetail2 == "Floor" || CategoryDetail2 == "Small house" {
            let roundedStepValue = round(sender.value / step) * step
            bedRoomSlide.value = roundedStepValue
            bedRoomSlide.minimumValue = 0
            bedRoomSlide.maximumValue = 5
            
            let currentValue = Int(bedRoomSlide.value)
            bedRoomsValueLbl.text = "\(currentValue)"
            valueForroomsslider = "\(currentValue)"
            if "\(currentValue)" == "\(5)"{
                bedRoomsValueLbl.text = "5+"
            }
            valueForbedrooms = "\(currentValue)"
        }
    }
    
    @IBAction func apartmentsSlider(_ sender: UISlider) {
        if CategoryDetail2 == "Villa"{
            let roundedStepValue = round(sender.value / step) * step
            apartmentsSlide.value = roundedStepValue
            apartmentsSlide.minimumValue = 0
            apartmentsSlide.maximumValue = 4
            
            let currentValue = Int(apartmentsSlide.value)
            apartmentsValueLbl.text = "\(currentValue)"
            valueForappartments = "\(currentValue)"
        } else  if CategoryDetail2 == "Building" {
            let roundedStepValue = round(sender.value / step) * step
            apartmentsSlide.value = roundedStepValue
            apartmentsSlide.minimumValue = 0
            apartmentsSlide.maximumValue = 30
            let currentValue = Int(apartmentsSlide.value)
            apartmentsValueLbl.text = "\(currentValue)"
            valueForappartments = "\(currentValue)"
        }
    }
    @IBAction func livingRoomsSlider(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / step) * step
        livingRoomsSlide.value = roundedStepValue
        livingRoomsSlide.minimumValue = 0
        livingRoomsSlide.maximumValue = 5
        let currentValue = Int(livingRoomsSlide.value)
        livingRoomsValueLbl.text = "\(currentValue)"
        if "\(currentValue)" == "\(5)"{
            livingRoomsValueLbl.text = "5+"
        }
        valueForlivingrooms = "\(currentValue)"
        
    }
    @IBAction func bathRoomsSlider(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / step) * step
        bathRoomsSlide.value = roundedStepValue
        bathRoomsSlide.minimumValue = 0
        bathRoomsSlide.maximumValue = 5
        let currentValue = Int(bathRoomsSlide.value)
        bathRoomsValueLbl.text = "\(currentValue)"
        if "\(currentValue)" == "\(5)"{
            bathRoomsValueLbl.text = "5+"
        }
        valueForbathrooms = "\(currentValue)"
    }
    @IBAction func storesSlider(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / step) * step
        storesSlide.value = roundedStepValue
        storesSlide.minimumValue = 0
        storesSlide.maximumValue = 5
        let currentValue = Int(storesSlide.value)
        storesValueLbl.text = "\(currentValue)"
        if "\(currentValue)" == "\(5)"{
            storesValueLbl.text = "5+"
        }
        valueForstores = "\(currentValue)"
    }
//    @IBAction func streetWidthSlider(_ sender: UISlider) {
//
//        let roundedStepValue = round(sender.value / step) * step
//        streetwidthSlide.value = roundedStepValue
//        streetwidthSlide.minimumValue = 0
//        streetwidthSlide.maximumValue = 100
//        let currentValue = Int(streetwidthSlide.value)
//        streeetWidthvalueLbl.text = "\(currentValue) m"
//        valueForstreetwidth = "\(currentValue)"
//        // }
//    }
    @IBAction func ofRoomsSliderr(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / step) * step
        ofRoomsSlider.value = roundedStepValue
        ofRoomsSlider.minimumValue = 0
        ofRoomsSlider.maximumValue = 15
        let currentValue = Int(ofRoomsSlider.value)
        ofRoomsValue.text = "\(currentValue)"
        valueForOfRooms = "\(currentValue)"
    }
    @IBAction func internalStairSwitch(_ sender: Any) {
        
        if internalStraisSwitch.isOn {
            valueForinternalstairs = true
            internalStraisSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForinternalstairs = false
            internalStraisSwitch.setOn(false, animated:true)
            print("off")
          }
        
        
        
    }
    @IBAction func driverRoomSwitch(_ sender: Any) {
        
        if driverRoomSwitch.isOn {
            valueFordriverroom = true
            driverRoomSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForinternalstairs = false
            driverRoomSwitch.setOn(false, animated:true)
            print("off")
          }
        
    }
    @IBAction func maidRoomSwitch(_ sender: Any) {
        if maidRoomSwitch.isOn {
            valueFormaidroom = true
            maidRoomSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueFormaidroom = false
            maidRoomSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func poolSwitch(_ sender: Any) {
        if poolSwitch.isOn {
            valueForpool = true
            poolSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForpool = false
            poolSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func furnishedSwitch(_ sender: Any) {
        if furnishedSwitch.isOn {
            valueForfurnished = true
            furnishedSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForfurnished = false
            furnishedSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func tentSwitch(_ sender: Any) {
        if tentSwitch.isOn {
            valueFortent = true
            tentSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueFortent = false
            tentSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func extraSpaceSwitch(_ sender: Any) {
        if extraSpaceSwitch.isOn {
            valueForextraspace = true
            extraSpaceSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForextraspace = false
            extraSpaceSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func kitchenSwitch(_ sender: Any) {
        if kitchenSwitch.isOn {
            valueForkitchen = true
            kitchenSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForkitchen = false
            kitchenSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func extraUnitSwitch(_ sender: Any) {
        if extraUnitSwitch.isOn {
            valueForextraunit = true
            extraUnitSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForextraunit = false
            extraUnitSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func carEntranceSwitch(_ sender: Any) {
        if carEnterSwitch.isOn {
            valueForcarentrance = true
            carEnterSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForcarentrance = false
            carEnterSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func basementSwitch(_ sender: Any) {
        if basmentSwitch.isOn {
            valueForbasement = true
            basmentSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForbasement = false
            basmentSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func liftSwitch(_ sender: Any) {
        if liftSwitch.isOn {
            valueForlift = true
            liftSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForlift = false
            liftSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func duplexSwitch(_ sender: Any) {
        if duplexSwitch.isOn {
            valueForduplex = true
            duplexSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForduplex = false
            duplexSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func airConditionerSwitch(_ sender: Any) {
        if airConditionerSwitch.isOn {
            valueForairconditioner = true
            airConditionerSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForairconditioner = false
            airConditionerSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func foortballSpaceSwitch(_ sender: Any) {
        if footballSwitch.isOn {
            valueForfootballspace = true
            footballSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForfootballspace = false
            footballSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func vollyballSpaceSwitch(_ sender: Any) {
        if vollyBallSwitch.isOn {
            valueForvolleyballspace = true
            vollyBallSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForvolleyballspace = false
            vollyBallSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func playgroundSwitch(_ sender: Any) {
        if playgroundSwitch.isOn {
            valueForplayground = true
            playgroundSwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForplayground = false
            playgroundSwitch.setOn(false, animated:true)
            print("off")
          }
    }
    @IBAction func familySectionSwitch(_ sender: Any) {
        if familySwitch.isOn {
            valueForfamilysection = true
            familySwitch.setOn(true, animated:true)
            print("on")
          } else {
            valueForfamilysection = false
            familySwitch.setOn(false, animated:true)
            print("off")
          }
    }
    
    @IBAction func residentialBtnAction(_ sender: Any) {
        residentialBtn.isSelected = true
        commercialBtn.isSelected = false
        bothBtn.isSelected = false
        residentialBtn.setTitleColor(.white, for: .normal)
        residentialBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        commercialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        commercialBtn.backgroundColor = .white
        bothBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        bothBtn.backgroundColor = .white
        residentialBtn.layer.borderWidth = 0
        commercialBtn.layer.borderWidth = 1
        bothBtn.layer.borderWidth = 1
        valueForpurpose = "Residential"
      
    }
    @IBAction func commercialBtnAction(_ sender: Any) {
        residentialBtn.isSelected = false
        commercialBtn.isSelected = true
        bothBtn.isSelected = false
        residentialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        residentialBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        commercialBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        commercialBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        bothBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        bothBtn.backgroundColor = .white
        residentialBtn.layer.borderWidth = 1
        commercialBtn.layer.borderWidth = 0
        bothBtn.layer.borderWidth = 1
        valueForpurpose = "Commercial"
        
    }
    @IBAction func bothBtnAction(_ sender: Any) {
        residentialBtn.isSelected = false
        commercialBtn.isSelected = false
        bothBtn.isSelected = true
        residentialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        residentialBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        commercialBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        commercialBtn.backgroundColor = .white
        bothBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bothBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        residentialBtn.layer.borderWidth = 1
        commercialBtn.layer.borderWidth = 1
        bothBtn.layer.borderWidth = 0
        valueForpurpose = "Commercial&Residential"
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func streetBtnAction(_ sender: Any) {
        if pickerView.isHidden{
         pickerView.isHidden = false
        levelCheck = "eetwidth"
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
    } else if !pickerView.isHidden {
               toolBar.removeFromSuperview()
               pickerView.removeFromSuperview()
               pickerView.isHidden = true
               toolBar.isHidden = true
               
           }
   
    }
    
  
 
     
    @IBAction func levelBtnAction(_ sender: Any) {
        if pickerView.isHidden{
         pickerView.isHidden = false
        levelCheck = "level"
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
    } else if !pickerView.isHidden {
               toolBar.removeFromSuperview()
               pickerView.removeFromSuperview()
               pickerView.isHidden = true
               toolBar.isHidden = true
               
           }
    }

    
    @IBAction func propertySourceBtnAction(_ sender: Any) {
        if pickerView.isHidden{
         pickerView.isHidden = false
        levelCheck = "propertySource"
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
    } else if !pickerView.isHidden {
            toolBar.removeFromSuperview()
            pickerView.removeFromSuperview()
            pickerView.isHidden = true
            toolBar.isHidden = true
            
        }
    }
  
    
  
    
    @IBAction func ageBtnAction(_ sender: Any) {
        if pickerView.isHidden{
         pickerView.isHidden = false
        levelCheck = "age"
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
        }else if !pickerView.isHidden {
            toolBar.removeFromSuperview()
            pickerView.removeFromSuperview()
            pickerView.isHidden = true
            toolBar.isHidden = true
            
        }
    
    }
  
    
    
    
    @IBAction func streetDirectionBtn(_ sender: Any) {
        if pickerView.isHidden{
            pickerView.isHidden = false
            levelCheck = "streetdirection"
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
            
        }else if !pickerView.isHidden {
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
    
    
    
    func postToNextScreen() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "setAddInformationVC") as! setAddInformationVC
        vc.Category = CategoryDetail2
        vc.singleorfamily = valueForsingleorfamily
        vc.dailyormonthlyoryearly = valueFordailyormonthlyoryearly
        vc.bedrooms = valueForbedrooms
        vc.apartment = valueForappartments
        vc.livingrooms = valueForlivingrooms
        vc.bathrooms = valueForbathrooms
        vc.eetwidth = valueForstreetwidth
        vc.propertySource = valueForPropertySource
        vc.internalstairs = valueForinternalstairs
        vc.level = valueForlevel
        vc.age = valueForage
        vc.driverroom = valueFordriverroom
        vc.maidroom = valueFormaidroom
        vc.pool = valueForpool
        vc.furnished = valueForfurnished
        vc.tent = valueFortent
        vc.extraspace = valueForextraspace
        vc.kitchen = valueForkitchen
        vc.extraunit = valueForextraunit
        vc.carentrance = valueForcarentrance
        vc.basement = valueForbasement
        vc.lift = valueForlift
        vc.duplex = valueForduplex
        vc.airconditioner = valueForairconditioner
        vc.purpose = valueForpurpose
        vc.streetdirection = valueForstreetdirection
        vc.stores = valueForstores
        vc.footballspace = valueForfootballspace
        vc.volleyballspace = valueForvolleyballspace
        vc.playground = valueForplayground
        vc.roomsslider = valueForroomsslider
        vc.familysection = valueForfamilysection
        vc.latitude = latitude
        vc.longitude = longitude
        vc.imageUrlArray = ArrayImages
        vc.videosUrlArray = arrayVideos
        vc.categoryindex = categoryindex
        vc.ofWellsText = ofWellsTextfield.text!
        vc.ofTreeText = ofTreeTextfield.text!
        vc.ofPlateNumberText = plateNumberText.text!
        vc.LandType = valueForLandType
        vc.valueForOfRooms = valueForOfRooms
        if updatePropertyData.count != 0 {
            vc.updateProperty = self.updatePropertyData
            print(vc.updateProperty)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }}
    
    @IBAction func continueAction(_ sender: Any) {
        
        if updatePropertyData.count != 0 {
            
            postToNextScreen()
            
            
            
        }else{
        if CategoryDetail2 == "Villa" {
            if valueForbedrooms.isEmpty == true || valueForbedrooms == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bed rooms".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            } else if valueForbathrooms.isEmpty == true  || valueForbathrooms == "0"{
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bath rooms".localizedStr(), VC: self, cancel_action: false)
                
            } else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            } else { postToNextScreen() }
            
        } else if CategoryDetail2 == "Land" {
            if valueForstreetdirection.isEmpty == true   {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true   {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            } else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            }else {
                postToNextScreen()
                
            }

        }
        else if CategoryDetail2 == "Apartment"{
            if valueForbedrooms.isEmpty == true || valueForbedrooms == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bed rooms".localizedStr(), VC: self, cancel_action: false)
            }
            
            else  if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            } else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForbathrooms.isEmpty == true  || valueForbathrooms == "0"{
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bath rooms".localizedStr(), VC: self, cancel_action: false)
                
            }  else { postToNextScreen() }
            
        } else if CategoryDetail2 == "Building"{
            if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            } else if valueForappartments.isEmpty == true  || valueForappartments == "0"{
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of apartment".localizedStr(), VC: self, cancel_action: false)
                
            } else if valueForPropertySource.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForage.isEmpty == true || valueForage == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter age".localizedStr(), VC: self, cancel_action: false)
                
            } else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            } else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            }else {
                postToNextScreen() }
        }
        
        else if CategoryDetail2 ==  "Esteraha" {
            
            if valueForbathrooms.isEmpty == true || valueForbathrooms == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bath rooms".localizedStr(), VC: self, cancel_action: false)
                
            }else  if valueForage.isEmpty == true || valueForage == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter age".localizedStr(), VC: self, cancel_action: false)
            }
            else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForPropertySource.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            }
            
            
            else { postToNextScreen() }
            
        } else if CategoryDetail2 == "Farm" {
           
            if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForPropertySource.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            } else { postToNextScreen()}
           
            
        } else if CategoryDetail2 == "Store" {
            
            if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            }else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            }else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            } else { postToNextScreen() }
        } else if CategoryDetail2 == "Floor" {
            
            
            if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            } else if valueForbedrooms.isEmpty == true || valueForbedrooms == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg:  "Please Enter bed rooms".localizedStr(), VC: self, cancel_action: false)
                
            } else if valueForbathrooms.isEmpty == true || valueForbathrooms == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bath rooms".localizedStr(), VC: self, cancel_action: false)
                
            }else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
                
            } else { postToNextScreen() }
            
        } else if CategoryDetail2 == "Room" {
            
            if valueFordailyormonthlyoryearly.isEmpty == true || valueFordailyormonthlyoryearly == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Duration".localizedStr(), VC: self, cancel_action: false)
            } else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
            }else if valueForPropertySource.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            } else { postToNextScreen() }
        }
        
        else if CategoryDetail2 == "Office" {
            if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            } else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
            } else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            }
            else { postToNextScreen() }}
        
        else if CategoryDetail2 == "Warehouse" {
            if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            }else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
            } else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            }else { postToNextScreen() }
            
        }
            else if CategoryDetail2 == "Furnished Apartment" {
            if valueForbedrooms.isEmpty == true || valueForbedrooms == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bed rooms".localizedStr(), VC: self, cancel_action: false)
            } else if valueForbathrooms.isEmpty == true || valueForbathrooms == "0" {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter # of bath rooms".localizedStr(), VC: self, cancel_action: false)
                
            } else if valueForstreetdirection.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Direction".localizedStr(), VC: self, cancel_action: false)
                
            }  else if valueForPropertySource.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            }else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
            } else if valueForstreetwidth.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Street Width".localizedStr(), VC: self, cancel_action: false)
                
            } else { postToNextScreen() }
        }
        else if CategoryDetail2 == "Tent"{
            
            if valueForPropertySource.isEmpty == true  {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Property Source".localizedStr(), VC: self, cancel_action: false)
                
            }else if plateNumberText.text!.isEmpty == true {
                TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please Enter Plate Number".localizedStr(), VC: self, cancel_action: false)
            }else{
                postToNextScreen()
            }
          
                }
        }
    }
    
}

//MARK: - extension Pickerview method



extension setFilterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1}
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if  levelCheck == "level"{return arrayLevel.count}
        else if levelCheck == "age"{ return arrayAge.count }
        else if levelCheck == "eetwidth"{return arrayEetwidth.count}
        else if levelCheck == "streetdirection"{return arrayStreetData.count}
        else if levelCheck == "propertySource"{return arrayPropertySource.count}
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if  levelCheck == "level"{            
            let levelArray = arrayLevel[row]
            levelLbl.text = "\(levelArray)"
            return levelArray
        } else if levelCheck == "age"{
            let ageArray = arrayAge[row].localizedStr()
            ageLbl.text = "\(ageArray)"
            return ageArray.localizedStr()
        } else if  levelCheck == "eetwidth"{
            let widthArray = arrayEetwidth[row].localizedStr()
            streeetWidthvalueLbl.text = "\(widthArray)"
            return widthArray.localizedStr()
        }else if  levelCheck == "streetdirection"{
            let streetArray = arrayStreetData[row].localizedStr()
            streetDirectionLbl.text = "\(streetArray)"
            return streetArray.localizedStr()
        }
        else if  levelCheck == "propertySource"{
            let propertyArray = arrayPropertySource[row].localizedStr()
            propertySourceLbl.text = "\(propertyArray)"
            return propertyArray.localizedStr()
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  levelCheck == "level"{
            levelLbl.text = arrayLevel[row]
            valueForlevel = arrayLevel[row]
            
        }else if levelCheck == "age"{
            ageLbl.text = arrayAge[row].localizedStr()
            valueForage = arrayAge[row]
            
        } else if  levelCheck == "eetwidth"{
            streeetWidthvalueLbl.text = arrayEetwidth[row].localizedStr()
            valueForstreetwidth = arrayEetwidth[row]
            
    } else if  levelCheck == "streetdirection"{
        streetDirectionLbl.text = arrayStreetData[row].localizedStr()
            valueForstreetdirection = arrayStreetData[row]
        
    } else if  levelCheck == "propertySource"{
        propertySourceLbl.text = arrayPropertySource[row].localizedStr()
            valueForPropertySource = arrayPropertySource[row]
        
    }
}
}

//extension setFilterVC:UICollectionViewDelegate,UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return arrauStreetData.count
//    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "streetDirectionCollVieCell", for: indexPath) as! streetDirectionCollVieCell
//        cell.contentView.layer.cornerRadius = 18
//        cell.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        cell.contentView.layer.borderWidth = 1
//
//        if updatePropertyData.count != 0 {
//            if updatePropertyData[0].streetdirection == arrauStreetData[indexPath.row] && valueForstreetdirection.isEmpty == true {
//                cell.isSelected = true
//                cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
//                cell.contentView.layer.cornerRadius = 18
//                cell.contentView.layer.borderWidth = 0
//                cell.nameLbl.textColor = .white
//                cell.nameLbl.text = arrauStreetData[indexPath.row].localizedStr()
//                valueForstreetdirection = arrauStreetData[indexPath.item]
//
//            } else if valueForstreetdirection == arrauStreetData[indexPath.row] && valueForstreetdirection.isEmpty == false {
//                cell.isSelected = true
//                cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
//                cell.contentView.layer.cornerRadius = 18
//                cell.contentView.layer.borderWidth = 0
//                cell.nameLbl.textColor = .white
//                cell.nameLbl.text = arrauStreetData[indexPath.row].localizedStr()
//                valueForstreetdirection = arrauStreetData[indexPath.item]
//             } else {
//
//                cell.nameLbl.text = arrauStreetData[indexPath.row].localizedStr()
//
//             }
//          } else {
//            cell.nameLbl.text = arrauStreetData[indexPath.row].localizedStr()
//
//        }
//        return cell
//     }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1.0, left: 6.0, bottom: 1.0, right: 6.0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "streetDirectionCollVieCell", for: indexPath) as! streetDirectionCollVieCell
//        cell.nameLbl = UILabel(frame: CGRect.zero)
//        cell.nameLbl.text = arrauStreetData[indexPath.item]
//        cell.nameLbl.sizeToFit()
//        return CGSize(width:  cell.nameLbl.frame.width + 36, height: 32)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//      let cell = collectionView.cellForItem(at: indexPath) as! streetDirectionCollVieCell
             
//        if updatePropertyData.count != 0 {
//            if updatePropertyData[0].streetdirection == arrauStreetData[indexPath.row] && valueForstreetdirection.isEmpty == true {
//                    cell.isSelected = true
//                    cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
//                    cell.contentView.layer.cornerRadius = 18
//                    cell.contentView.layer.borderWidth = 0
//                    cell.nameLbl.textColor = .white
//                 self.streetDirectionCollectionView.reloadData()
//            } else if valueForstreetdirection == arrauStreetData[indexPath.row] && valueForstreetdirection.isEmpty == false {
//                cell.isSelected = true
//                cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
//                cell.contentView.layer.cornerRadius = 18
//                cell.contentView.layer.borderWidth = 0
//                cell.nameLbl.textColor = .white
//                self.streetDirectionCollectionView.reloadData()
//             } else {
//
//                cell.isSelected = true
//                cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
//                cell.contentView.layer.cornerRadius = 18
//                cell.contentView.layer.borderWidth = 0
//                cell.nameLbl.textColor = .white
//                self.streetDirectionCollectionView.reloadData()
//             }
//          }else {
//
//            cell.isSelected = true
//            cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
//            cell.contentView.layer.cornerRadius = 18
//            cell.contentView.layer.borderWidth = 0
//            cell.nameLbl.textColor = .white
//
//         }
//
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//        print(cell.nameLbl.text!)
//        valueForstreetdirection = arrauStreetData[indexPath.item]
        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! streetDirectionCollVieCell
//
//        if cell.isSelected == false {
//            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            cell.contentView.layer.cornerRadius = 18
//            cell.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            cell.contentView.layer.borderWidth = 1
//            cell.nameLbl.textColor = .black
//        }
//    }
//
//
//}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

extension UILabel {
    @objc
    func input(textField: UITextField) {
        self.text = textField.text
    }
    
    
    func connect(with textField:UITextField){
           textField.addTarget(self, action: #selector(UILabel.input(textField:)), for: .editingChanged)
       }
}

