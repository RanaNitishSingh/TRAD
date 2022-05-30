//
//  showHideDataViewController.swift
//  trad
//
//  Created by Imac on 14/02/22.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import SDWebImage
import FirebaseDatabase
import FirebaseFirestore

class showHideDataViewController: UIViewController , UISearchBarDelegate{
    
    //MARK:- IBOutlets
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var saleBtn: UIButton!
    @IBOutlet var rentBtn: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet var btnStack: UIStackView!
     var numberOfCell = 0
    //MARK:- Variables
    var propertiesdata: [Propertiesdata] = []
    var mainArrayPropertiesdata : [Propertiesdata] = []
    let vc = detailViewController()
    var searching = false
    var filtereddata: [Propertiesdata] = []
    var displayArraycategories = ["All", "Villa","Land","Floor","Apartment","Building","Esteraha","Store","Farm","Room","Office","Warehouse","Furnished Apartment","Tent"]
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var selectedRentOrSale = ""
    var selectedCategory = ""
    var  adminUid: String? = ""
    var  userUid: String? = ""
    var ForSoldAndRented : Bool = false
    var viewIsVisibleConstraint: NSLayoutConstraint!
    var viewIsHiddenConstraint: NSLayoutConstraint!
    @IBOutlet weak var userLogoutView: UIView!
    @IBOutlet weak var userLable: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    var User = ""
    var Email = ""
    var loginUserName = ""
    
    var propertySort = [String]()
    
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource =  self
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.dataSource = self
        SearchBar.delegate = self
        saleBtn.layer.borderWidth = 1
        saleBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        rentBtn.layer.borderWidth = 1
        rentBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        saleBtn.layer.cornerRadius = 4
        rentBtn.layer.cornerRadius = 4
        saleBtn.isSelected = true
        self.dataFetchfromFirebase()
        hideKeyboardWhenTappedAround()
        selectedRentOrSale = "sale"
       // selectedCategory = "All"
        self.tabBarController?.tabBar.isHidden = false
        self.userLogoutView.isHidden = true
        self.getUserTab()
        self.logoutBtn.layer.cornerRadius = 16
       
    }
    
    
    func getUserTab() {
          //Get specific document from current user
          let dataBase = Firestore.firestore()
              .collection("Users")
              .document(Auth.auth().currentUser?.uid ?? "")

          // Get data
        dataBase.getDocument { (document, error) in
              guard let document = document, document.exists else {
                  print("Document does not exist")
                  return
              }
              let tabUserData = document.data()
            self.User = tabUserData?["UserType"] as! String
            self.Email = tabUserData?["Email"] as! String
            self.loginUserName =  tabUserData?["UserName"] as! String
            
            if self.User != "Admin" {
                self.userLogoutView.isHidden = false
                self.userLable.text = self.loginUserName
            }
            
            
            
            
        }
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        //self.getDocument()
        self.dataFetchfromFirebase()
    }
    
   
    @IBAction func saleBtnAction(_ sender: Any) {
        if saleBtn.isSelected == true {
            return
        }
        saleBtn.isSelected = true
        rentBtn.isSelected = false
        saleBtn.setTitleColor(.white, for: .normal)
        saleBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        rentBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        rentBtn.backgroundColor = .white
        selectedRentOrSale = "sale"
        self.propertiesdata = self.mainArrayPropertiesdata.filter { data in
            return data.Category.contains("\(selectedCategory) for sale")
        }
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy h:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        self.propertiesdata.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
        self.propertiesdata.sort { !$0.forSoldAndRented && $1.forSoldAndRented }
        tableView.reloadData()
    }
    
    @IBAction func rentBtnAction(_ sender: Any) {
        if rentBtn.isSelected == true {
            return
        }
        selectedRentOrSale = "rent"
        saleBtn.isSelected = false
        rentBtn.isSelected = true
        saleBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1), for: .normal)
        saleBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rentBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        rentBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        self.propertiesdata = self.mainArrayPropertiesdata.filter { data in
            return data.Category.contains("\(selectedCategory) for rent")
        }
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy h:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
       self.propertiesdata.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
        self.propertiesdata.sort { !$0.forSoldAndRented && $1.forSoldAndRented }
        tableView.reloadData()
    }
    
    
    @IBAction func userLogoutAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "loginUID")
        defaults.removeObject(forKey: "user_Email")
        defaults.removeObject(forKey: "user_Password")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"ViewController") as! ViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            filtereddata = self.propertiesdata.filter {
                ($0.plateNo).lowercased().contains(searchText.lowercased())
            }
            print(filtereddata)
            searching = !filtereddata.isEmpty
            searching = true
        }
        else{
            searching = false
        }
        self.tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
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
    
    func dataFetchfromFirebase(){
        Helper().showUniversalLoadingView(true)
        let db = Firestore.firestore()
        db.collection("Properties")
          .getDocuments() { [self] (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.mainArrayPropertiesdata = querySnapshot?.documents.reversed().compactMap { document in
                        // 6
                        try? document.data(as: Propertiesdata.self)
                    } ?? []
                    
                    let df = DateFormatter()
                    df.dateFormat = "dd-MM-yyyy h:mm:ss a"
                    df.amSymbol = "AM"
                    df.pmSymbol = "PM"
                    
                    if selectedRentOrSale == "sale" {
                        
                        self.propertiesdata = self.mainArrayPropertiesdata.filter { data in
                            return data.Category.contains("\(selectedCategory) for sale")
                        }
                    
                    }else if selectedRentOrSale == "rent"{
                        self.propertiesdata = self.mainArrayPropertiesdata.filter { data in
                            return data.Category.contains("\(selectedCategory) for rent")
                        }
                       
                    }else {
                        self.propertiesdata = self.mainArrayPropertiesdata.filter { data in
                            return data.Category.contains("for sale")
                        }
                                            
                    }
                    self.propertiesdata.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
                    self.propertiesdata.sort { !$0.forSoldAndRented && $1.forSoldAndRented }
                  
                    tableView.reloadData()
                    Helper().showUniversalLoadingView(false)
                }
            }
    }

    
    @objc func btnAction(_ sender: UIButton) {
        
        var superview = sender.superview
        while let view = superview, !(view is showCell) {
            superview = view.superview
        }
        guard let cell = superview as? showCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        // We've got the index path for the cell that contains the button, now do something with it.
        print("button is in row \(indexPath.row)")
        
        let post = self.propertiesdata[indexPath.row]
        print(post.documentID)
        Helper().showUniversalLoadingView(true)
        if post.forSoldAndRented == false && self.propertiesdata[indexPath.row].documentID == post.documentID  {
            
            ForSoldAndRented = true
            let db = Firestore.firestore()
            let someData = ["forSoldAndRented" :  ForSoldAndRented
            ] as [String : Any]
            
            let UpdateRef = db.collection("Properties").document(post.documentID)
            UpdateRef.updateData(someData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please try again".localizedStr(), VC: self, cancel_action: false)
                    Helper().showUniversalLoadingView(false)
                } else {
                    print("Document Updated: \(post.documentID)")
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List Updated".localizedStr(), VC: self, cancel_action: false)
                    cell.forRentAndSoldImg.image = UIImage(named:"icons8-checked-checkbox-50.png")
                    self.propertiesdata.remove(at: indexPath.row)
                    
                    //self.tableView.deleteRows(at: [indexPath], with: .fade)
                 
                    
                    self.dataFetchfromFirebase()
                    Helper().showUniversalLoadingView(false)
                }
                
            }
            
        } else {
            
            ForSoldAndRented = false
            let db = Firestore.firestore()
            let someData = [
                "forSoldAndRented" :  ForSoldAndRented
            ] as [String : Any]
            
            let UpdateRef = db.collection("Properties").document(post.documentID)
            UpdateRef.updateData(someData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please try again".localizedStr(), VC: self, cancel_action: false)
                    Helper().showUniversalLoadingView(false)
                } else {
                    print("Document Updated: \(post.documentID)")
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "List Updated".localizedStr(), VC: self, cancel_action: false)
                    cell.forRentAndSoldImg.image = UIImage(named:"icons8-unchecked-checkbox-50.png")
                    self.dataFetchfromFirebase()
                    Helper().showUniversalLoadingView(false)
                }
            }
            
        }
        
    }
    
}

extension showHideDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filtereddata.count
        }
        return self.propertiesdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as! showCell
        cell.selectionStyle = .none
        
        
//         let userID = Auth.auth().currentUser?.uid
//        print(userID)
//
        if propertiesdata[indexPath.row].userUid ==  UserDefaults.standard.value(forKey: "loginUID") as! String {
            if searching {
                
                let DateandTime = self.filtereddata[indexPath.item].createdDate.components(separatedBy: " ")
                    cell.lblDays.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
                cell.lblBuildingType.text = self.filtereddata[indexPath.item].Category.localizedStr()
                let largeNumber = Int(self.filtereddata[indexPath.item].valueOftotalPrice.localizedStr())
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
                
                cell.LblSAR.text = formattedNumber! + " " + "SAR".localizedStr()
                cell.bathroomTubLbl.text = self.filtereddata[indexPath.item].bathrooms.localizedStr()
                let meter = " m² ";
                cell.LblMeter.text = "📍" + self.filtereddata[indexPath.item].valueOfsizeTextView + meter.localizedStr()
                cell.BedLbl.text = self.filtereddata[indexPath.item].bedrooms.localizedStr()
                cell.LblDescription.text = self.filtereddata[indexPath.item].valueofExtraDetail.localizedStr()
                cell.houseImages.sd_setImage(with: URL(string:self.filtereddata[indexPath.item].ImageUrl.first ?? ""), placeholderImage: #imageLiteral(resourceName: "simple_home"))
                
                
                if filtereddata[indexPath.row].bathrooms == "" {
                    cell.bathroomTubLbl.isHidden = true
                    cell.bathTubIMG.isHidden = true
               
                }else{
                    cell.bathroomTubLbl.isHidden = false
                    cell.bathTubIMG.isHidden = false
                    cell.bathroomTubLbl.text = self.filtereddata[indexPath.item].bathrooms.localizedStr()
               }
                
                if filtereddata[indexPath.row].bedrooms == "" {
                    cell.BedLbl.isHidden = true
                    cell.bedIMG.isHidden = true
               
                }else{
                    cell.BedLbl.isHidden = false
                    cell.bedIMG.isHidden = false
                    cell.BedLbl.text = self.filtereddata[indexPath.item].bedrooms.localizedStr()
               }
                
                
                if filtereddata[indexPath.row].eetwidth == "" {
                    cell.streetWidthLbl.isHidden = true
                    cell.streetWidthImg.isHidden = true
               
                }else{
                    cell.streetWidthLbl.isHidden = false
                    cell.streetWidthImg.isHidden = false
                    let meterwidth = " m ";
                    cell.streetWidthLbl.text = self.filtereddata[indexPath.item].eetwidth +  meterwidth.localizedStr()
               }
            
                if filtereddata[indexPath.row].streetdirection == "" {
                    cell.streetImg.isHidden = true
                    cell.streetLbl.isHidden = true
                    cell.streetView.isHidden = true
                   
                }else{
                    cell.streetView.isHidden = false
                    cell.streetImg.isHidden = false
                    cell.streetLbl.isHidden = false
                    cell.streetLbl.text = self.filtereddata[indexPath.item].streetdirection.localizedStr()
                }
                
                
                if self.filtereddata[indexPath.item].purpose == "Commercial&Residential" .localizedStr() {
                cell.purposeLbl.text = "Res. & Comm.".localizedStr()
                } else{
                    cell.purposeLbl.text = self.filtereddata[indexPath.item].purpose.localizedStr()
                  
                }
                
                
                if filtereddata[indexPath.row].forSoldAndRented == true {
                    cell.forRentAndSoldImg.image = UIImage(named:"icons8-checked-checkbox-50.png")
                }
                else
                {
                    cell.forRentAndSoldImg.image = UIImage(named:"icons8-unchecked-checkbox-50.png")
                }
                
                cell.forRentAndSoldBtn?.addTarget(self, action: #selector(showHideDataViewController.btnAction(_:)), for: .touchUpInside)
                
                
            }else{
                
                print(self.propertiesdata[0].ImageUrl.count)
                let DateandTime = self.propertiesdata[indexPath.item].createdDate.components(separatedBy: " ")
                    cell.lblDays.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
                cell.lblBuildingType.text = self.propertiesdata[indexPath.item].Category.localizedStr()
                let largeNumber = Int(self.propertiesdata[indexPath.item].valueOftotalPrice.localizedStr()) ?? 0
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let formattedNumber = numberFormatter.string(from: NSNumber(value: largeNumber))
                cell.LblSAR.text = formattedNumber! + " " + "SAR".localizedStr()
                
                let meter = " m² ";
                cell.LblMeter.text = "📍" + self.propertiesdata[indexPath.item].valueOfsizeTextView + meter.localizedStr()
                
                cell.LblDescription.text = self.propertiesdata[indexPath.item].valueofExtraDetail.localizedStr()
                cell.houseImages.sd_setImage(with: URL(string:self.propertiesdata[indexPath.item].ImageUrl.first ?? ""), placeholderImage: #imageLiteral(resourceName: "simple_home"))
                
                
                
                if propertiesdata[indexPath.row].bathrooms == "" || propertiesdata[indexPath.row].bathrooms == "0"{
                    cell.bathroomTubLbl.isHidden = true
                    cell.bathTubIMG.isHidden = true
               
                }else{
                    cell.bathroomTubLbl.isHidden = false
                    cell.bathTubIMG.isHidden = false
                    cell.bathroomTubLbl.text = self.propertiesdata[indexPath.item].bathrooms.localizedStr()
               }
                
                if propertiesdata[indexPath.row].bedrooms == "" || propertiesdata[indexPath.row].bedrooms == "0" {
                    cell.BedLbl.isHidden = true
                    cell.bedIMG.isHidden = true
               
                }else{
                    cell.BedLbl.isHidden = false
                    cell.bedIMG.isHidden = false
                    cell.BedLbl.text = self.propertiesdata[indexPath.item].bedrooms.localizedStr()
               }
                
                
                if propertiesdata[indexPath.row].eetwidth == "" {
                    cell.streetWidthLbl.isHidden = true
                    cell.streetWidthImg.isHidden = true
               
                }else{
                    cell.streetWidthLbl.isHidden = false
                    cell.streetWidthImg.isHidden = false
                    let meterwidth = " m ";
                    cell.streetWidthLbl.text = self.propertiesdata[indexPath.item].eetwidth +  meterwidth.localizedStr()
               }
            
                if propertiesdata[indexPath.row].streetdirection == "" {
                    cell.streetImg.isHidden = true
                    cell.streetLbl.isHidden = true
                    cell.streetView.isHidden = true
                   
                }else{
                    cell.streetView.isHidden = false
                    cell.streetImg.isHidden = false
                    cell.streetLbl.isHidden = false
                    cell.streetLbl.text = self.propertiesdata[indexPath.item].streetdirection.localizedStr()
                }
                
              
               
                if self.propertiesdata[indexPath.item].purpose == "Commercial&Residential" .localizedStr() {
                cell.purposeLbl.text = "Res. & Comm.".localizedStr()
                } else{
                    cell.purposeLbl.text = self.propertiesdata[indexPath.item].purpose.localizedStr()
                  
                }
                
                if propertiesdata[indexPath.row].forSoldAndRented == true {
                    cell.forRentAndSoldImg.image = UIImage(named:"icons8-checked-checkbox-50.png")
                }
                else
                {
                    cell.forRentAndSoldImg.image = UIImage(named:"icons8-unchecked-checkbox-50.png")
                    
                }
                
                cell.forRentAndSoldBtn.addTarget(self, action: #selector(showHideDataViewController.btnAction(_:)), for: .touchUpInside)
                
            }
            
            
        }else{
            
            cell.isHidden = true
            
        }
        tableView.keyboardDismissMode = .onDrag
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight:CGFloat = 0.0
        if propertiesdata[indexPath.row].userUid == UserDefaults.standard.value(forKey: "loginUID") as! String  {
            
            rowHeight = 200
        }
        else
        {
            rowHeight = 0.0
        }
        
        return rowHeight
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let viewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        
        if searching {
            viewController.Aproperties = [(filtereddata[indexPath.row])]
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            viewController.Aproperties = [(propertiesdata[indexPath.row])]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
       
    }
    
    
    
}

extension showHideDataViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayArraycategories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forSaleCollectionViewCell", for: indexPath) as! forSaleCollectionViewCell
        cell.cellView.layer.cornerRadius = 13
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = #colorLiteral(red: 0.01752752591, green: 0.01752752591, blue: 0.01752752591, alpha: 1)
        cell.ForSaleItemsLbl.text = displayArraycategories[indexPath.row].localizedStr()
        cell.cellView.layer.borderColor = indexPath == selectedIndexPath ? #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1) : #colorLiteral(red: 0.01752752591, green: 0.01752752591, blue: 0.01752752591, alpha: 1)
        cell.ForSaleItemsLbl.textColor = indexPath == selectedIndexPath ? #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1) : #colorLiteral(red: 0.01752752591, green: 0.01752752591, blue: 0.01752752591, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        selectedIndexPath = indexPath
        selectedCategory = displayArraycategories[indexPath.item] == "All" ? "" : displayArraycategories[indexPath.item]
        self.propertiesdata = self.mainArrayPropertiesdata.filter { data in
            return data.Category.contains("\(selectedCategory) for \(selectedRentOrSale)")
        }
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy h:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        self.propertiesdata.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
        self.propertiesdata.sort { !$0.forSoldAndRented && $1.forSoldAndRented }
        tableView.reloadData()
        categoriesCollectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: displayArraycategories[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]).width + 52, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return -10
       }
   
}

class showCell: UITableViewCell {
    
    @IBOutlet weak var houseImages: UIImageView!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblBuildingType: UILabel!
    @IBOutlet weak var bathTubIMG: UIImageView!
    @IBOutlet weak var LblSAR: UILabel!
    @IBOutlet weak var bookmarkIMG: UIImageView!
    @IBOutlet weak var bathroomTubLbl: UILabel!
    @IBOutlet weak var LblMeter: UILabel!
    @IBOutlet weak var BedLbl: UILabel!
    @IBOutlet weak var bedIMG: UIImageView!
    @IBOutlet weak var LblDescription: UILabel!
    @IBOutlet var more: UIButton!
    @IBOutlet var streetWidthLbl: UILabel!
    @IBOutlet var purposeLbl: UILabel!
    @IBOutlet var forRentAndSoldBtn: UIButton!
    
    @IBOutlet var streetWidthImg: UIImageView!
    @IBOutlet var forRentAndSoldImg: UIImageView!
    
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var streetView: UIView!
    @IBOutlet var streetLbl: UILabel!
    @IBOutlet var streetImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}


