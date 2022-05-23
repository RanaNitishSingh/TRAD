//
//  salepriceViewController.swift
//  trad
//  Created by Imac on 10/05/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import SDWebImage
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth





class salepriceViewController: UIViewController, UISearchBarDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var saleBtn: UIButton!
    @IBOutlet var rentBtn: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet var btnStack: UIStackView!
    
    //MARK:- Variables
    var properties: [Propertiesdata] = []
    var mainArrayProperties : [Propertiesdata] = []
    let vc = detailViewController()
    var listFilterData = [String()]
    var searching = false
    var filtered: [Propertiesdata] = []
    var displayArraycategories = ["All", "Villa","Land","Floor","Apartment","Building","Esteraha","Store","Farm","Room","Office","Warehouse","Furnished Apartment","Tent"]
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var selectedRentOrSale = ""
    var selectedCategory = ""
    var position = Int()
    var arrayDate = [String]()

    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource =  self
        SearchBar.delegate = self
        saleBtn.layer.borderWidth = 1
        saleBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        rentBtn.layer.borderWidth = 1
        rentBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
        saleBtn.layer.cornerRadius = 4
        rentBtn.layer.cornerRadius = 4
        saleBtn.isSelected = true
        fetchDatafromFirebase()
        hideKeyboardWhenTappedAround()
        selectedRentOrSale = "sale"
        self.hidesBottomBarWhenPushed = false
        
        let userID = Auth.auth().currentUser?.uid
        print(userID!)
        UserDefaults.standard.set(userID, forKey: "MyUID")
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
          self.fetchDatafromFirebase()
            
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
        if saleBtn.isSelected == true {
        self.properties = self.mainArrayProperties.filter { data in
            return data.Category.contains("\(selectedCategory) for sale")
        }
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy h:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        self.properties.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
        tableView.reloadData()
        }
      
        
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
        self.properties = self.mainArrayProperties.filter { data in
            return data.Category.contains("\(selectedCategory) for rent")
        }
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy h:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
       self.properties.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
       tableView.reloadData()
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            filtered = self.properties.filter {
                ($0.plateNo).lowercased().contains(searchText.lowercased())
            }
            print(filtered)
            searching = !filtered.isEmpty
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
    
    func fetchDatafromFirebase(){
        Helper().showUniversalLoadingView(true)
        
        let db = Firestore.firestore()
        db.collection("Properties").order(by: "createdDate").getDocuments() { [self] (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
               self.mainArrayProperties = querySnapshot?.documents.compactMap { document in
                  // 6
                  try? document.data(as: Propertiesdata.self)
                } ?? []
                
                let df = DateFormatter()
                df.dateFormat = "dd-MM-yyyy h:mm:ss a"
                df.amSymbol = "AM"
                df.pmSymbol = "PM"
                
                
                if selectedRentOrSale == "sale"{
                self.properties = self.mainArrayProperties.filter { data in
                    return data.Category.contains("\(selectedCategory) for sale")
            }
                }else if selectedRentOrSale == "rent" {
                    self.properties = self.mainArrayProperties.filter { data in
                        return data.Category.contains("\(selectedCategory) for rent")
             }
                     
                } else {
                    self.properties = self.mainArrayProperties.filter { data in
                        return data.Category.contains("for sale")
                     
                    }
                  
                }
                self.properties.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
                tableView.reloadData()
                Helper().showUniversalLoadingView(false)
            }
        }
    }
  
}


extension salepriceViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filtered.count
        }
        return self.properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vcCell", for: indexPath) as! vcCell
        cell.selectionStyle = .none
       
        if properties[indexPath.row].forSoldAndRented == true
            {
                cell.isHidden = true
        
            }
            else{
            // show cell values
                cell.isHidden = false
                
                if searching {                     
                    
                    let DateandTime = self.filtered[indexPath.row].createdDate.components(separatedBy: " ")
                    cell.lblDays.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
                    cell.lblBuildingType.text = self.filtered[indexPath.row].Category.localizedStr()
                    let largeNumber = Int(self.filtered[indexPath.row].valueOftotalPrice.localizedStr())
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
                    
                    cell.LblSAR.text = formattedNumber! + " " + "SAR".localizedStr()
                    let meter = " m² ";
                    cell.LblMeter.text = "📍" + self.filtered[indexPath.row].valueOfsizeTextView + meter.localizedStr()
                    
                    
                    if filtered[indexPath.row].bathrooms == "" || filtered[indexPath.row].bathrooms == "0" {
                        cell.bathroomTubLbl.isHidden = true
                        cell.bathTubIMG.isHidden = true
                   
                    }else{
                        cell.bathroomTubLbl.isHidden = false
                        cell.bathTubIMG.isHidden = false
                        cell.bathroomTubLbl.text = self.filtered[indexPath.row].bathrooms.localizedStr()
                   }
                    
                    if filtered[indexPath.row].bedrooms == "" || filtered[indexPath.row].bedrooms == "0" {
                        cell.BedLbl.isHidden = true
                        cell.bedIMG.isHidden = true
                   
                    }else{
                        cell.BedLbl.isHidden = false
                        cell.bedIMG.isHidden = false
                        cell.BedLbl.text = self.filtered[indexPath.row].bedrooms.localizedStr()
                   }
                    
                    
                    if filtered[indexPath.row].eetwidth == "" {
                        cell.streetWidthLbl.isHidden = true
                        cell.streetWidthImg.isHidden = true
                   
                    }else{
                        cell.streetWidthLbl.isHidden = false
                        cell.streetWidthImg.isHidden = false
                        let meterwidth = " m ";
                        cell.streetWidthLbl.text = self.filtered[indexPath.row].eetwidth +  meterwidth.localizedStr()
                   }
                
                    if filtered[indexPath.row].streetdirection == "" {
                        cell.streetImg.isHidden = true
                        cell.streetLbl.isHidden = true
                        cell.streetView.isHidden = true
                       
                    }else{
                        cell.streetView.isHidden = false
                        cell.streetImg.isHidden = false
                        cell.streetLbl.isHidden = false
                        cell.streetLbl.text = self.filtered[indexPath.row].streetdirection.localizedStr()
                    }
                    if self.filtered[indexPath.row].purpose == "Commercial&Residential" .localizedStr() {
                    cell.purposeLbl.text = "Res. & Comm.".localizedStr()
                    } else{
                        cell.purposeLbl.text = self.filtered[indexPath.row].purpose.localizedStr()
                      
                    }
                    
                    cell.LblDescription.text = self.filtered[indexPath.row].valueofExtraDetail.localizedStr()
                    cell.houseImages.sd_setImage(with: URL(string:self.filtered[indexPath.row].ImageUrl.first ?? ""), placeholderImage: #imageLiteral(resourceName: "simple_home"))
                }else{
                    
                  
                  
                    
                print(self.properties[0].ImageUrl.count)
                let DateandTime = self.properties[indexPath.row].createdDate.components(separatedBy: " ")
                 cell.lblDays.text = String(DateandTime[0]).replacedArabicDigitsWithEnglish
                 cell.lblBuildingType.text = self.properties[indexPath.row].Category.localizedStr()
                    let largeNumber = Int(self.properties[indexPath.row].valueOftotalPrice.localizedStr()) ?? 0
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal

                    let formattedNumber = numberFormatter.string(from: NSNumber(value: largeNumber))
                cell.LblSAR.text = formattedNumber! + " " + "SAR".localizedStr()
                    let meter = " m² ";
                cell.LblMeter.text = "📍" + self.properties[indexPath.row].valueOfsizeTextView + meter.localizedStr()
                cell.LblDescription.text = self.properties[indexPath.row].valueofExtraDetail.localizedStr()
                cell.houseImages.sd_setImage(with: URL(string:self.properties[indexPath.row].ImageUrl.first ?? ""), placeholderImage: #imageLiteral(resourceName: "simple_home"))
                cell.houseImages.layoutIfNeeded()
                cell.houseImages.layer.masksToBounds = true
                    
                    
                    if properties[indexPath.row].bathrooms == "" || properties[indexPath.row].bathrooms == "0" {
                        cell.bathroomTubLbl.isHidden = true
                        cell.bathTubIMG.isHidden = true
                   
                    }else{
                        cell.bathroomTubLbl.isHidden = false
                        cell.bathTubIMG.isHidden = false
                        cell.bathroomTubLbl.text = self.properties[indexPath.row].bathrooms.localizedStr()
                   }
                    
                    if properties[indexPath.row].bedrooms == "" || properties[indexPath.row].bedrooms == "0" {
                        cell.BedLbl.isHidden = true
                        cell.bedIMG.isHidden = true
                   
                    }else{
                        cell.BedLbl.isHidden = false
                        cell.bedIMG.isHidden = false
                        cell.BedLbl.text = self.properties[indexPath.row].bedrooms.localizedStr()
                   }
                    
                    
                    if properties[indexPath.row].eetwidth == "" {
                        cell.streetWidthLbl.isHidden = true
                        cell.streetWidthImg.isHidden = true
                   
                    }else{
                        cell.streetWidthLbl.isHidden = false
                        cell.streetWidthImg.isHidden = false
                        let meterwidth = " m ";
                        cell.streetWidthLbl.text = self.properties[indexPath.row].eetwidth +  meterwidth.localizedStr()
                   }
                
                    if properties[indexPath.row].streetdirection == "" {
                        cell.streetImg.isHidden = true
                        cell.streetLbl.isHidden = true
                        cell.streetView.isHidden = true
                       
                    }else{
                        cell.streetView.isHidden = false
                        cell.streetImg.isHidden = false
                        cell.streetLbl.isHidden = false
                        cell.streetLbl.text = self.properties[indexPath.row].streetdirection.localizedStr()
                    }
                    
                    if self.properties[indexPath.row].purpose == "Commercial&Residential" .localizedStr() {
                    cell.purposeLbl.text = "Res. & Comm.".localizedStr()
                    } else{
                        cell.purposeLbl.text = self.properties[indexPath.row].purpose.localizedStr()
                      
                    }
                }
           
            }

        tableView.keyboardDismissMode = .onDrag
        cell.isUserInteractionEnabled = true
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var rowHeight:CGFloat = 0.0
       
        if let getStatus = self.properties[indexPath.row].forSoldAndRented as? Bool
                     {
                        if getStatus == false
                        {
                            rowHeight = 150
                        }
                        else
                        {
                             rowHeight = 0.0
                        }
        } else {
            
            rowHeight = 0.0
        }

   return rowHeight
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let viewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController

        if searching {
            viewController.Aproperties = [(filtered[indexPath.row])]
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
        viewController.Aproperties = [(properties[indexPath.row])]
        self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        
    }
    

 
}



extension salepriceViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayArraycategories.count
    }
    
    
    
    
//    //MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: displayArraycategories[indexPath.item].localizedStr().size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]).width + 52, height: 40)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return -10
       }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forSaleCollectionViewCell", for: indexPath) as! forSaleCollectionViewCell
        cell.cellView.layer.cornerRadius = 14
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
        self.properties = self.mainArrayProperties.filter { data in
            return data.Category.contains("\(selectedCategory) for \(selectedRentOrSale)")
        }
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy h:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        self.properties.sort {df.date(from: $0.createdDate)! > df.date(from: $1.createdDate)!}
        tableView.reloadData()
        categoriesCollectionView.reloadData()
    }

}



class vcCell: UITableViewCell {
 
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
    @IBOutlet var streetWidthLbl: UILabel!
    @IBOutlet var streetWidthImg: UIImageView!
    @IBOutlet var purposeLbl: UILabel!
    @IBOutlet var streetImg: UIImageView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var streetView: UIView!
    @IBOutlet var streetLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
    }
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}



func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
       guard let url = URL(string: urlString) else {
return closure(nil)
       }
       let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
           guard error == nil else {
               print("error: \(String(describing: error))")
               return closure(nil)
           }
           guard response != nil else {
               print("no response")
               return closure(nil)
           }
           guard data != nil else {
               print("no data")
               return closure(nil)
           }
           DispatchQueue.main.async {
               closure(UIImage(data: data!))
           }
       }; task.resume()
   }



public extension String {

public var replacedEnglishtoArabicDigitsWith: String {
    var str = self
    let map = ["0" : "٠",
               "1" : "١",
               "2" : "٢",
               "3" : "٣",
               "4" : "٤" ,
               "5" : "٥",
               "6" : "٦" ,
               "7" : "٧" ,
               "8" : "٨" ,
               "9" : "٩"]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str
}
}

extension Date {
   func getFormatdDate() -> String {
        let dateformat = DateFormatter()
        //dateformat.dateFormat = format
        dateformat.dateFormat = "dd-MM-yyyy h:mm:ss a "
        dateformat.amSymbol = "AM"
        dateformat.pmSymbol = "PM"
        return dateformat.string(from: self)
    }
}


extension  UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}




