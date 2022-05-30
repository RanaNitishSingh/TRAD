//
//  ChosseCategoryVC.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit
import FirebaseFirestore

class ChosseCategoryVC: UIViewController {
    
    
    @IBOutlet var ChooseCategoryTableView: UITableView!
    //    var arrMenuItemNames = [String]()
    var arrCategories = ["Villa for sale","Land for sale","Floor for sale","Apartment for sale","Building for sale","Estaraha for sale","Store for sale","Farm for sale","Room for sale","Office for rent","Warehouse for sale","Furnished Apartment for sale","Tent for sale"]
    
    var displayArraycategories = ["Villa","Land","Floor","Apartment","Building","Esteraha","Store","Farm","Room","Office","Warehouse","Furnished Apartment","Tent"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChooseCategoryTableView.delegate = self
        ChooseCategoryTableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ChosseCategoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return arrCategories.count;
        return displayArraycategories.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChooseCategoryTableView.dequeueReusableCell(withIdentifier: "ChooseCategoryTableViewCell", for: indexPath) as! ChooseCategoryTableViewCell
        //          cell.CategotyName.text = arrCategories[indexPath.row]
        cell.CategotyName.text = displayArraycategories[indexPath.row].localizedStr()
        if L102Language.currentAppleLanguage() == "ar" {
            
            cell.forwordImage?.image =  cell.forwordImage?.image?.imageFlippedForRightToLeftLayoutDirection()
            print("yes")
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "uploadImageViewController") as! uploadImageViewController
        vc.CategoryDetail =  displayArraycategories[indexPath.row]
        vc.categoryindex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

class ChooseCategoryTableViewCell: UITableViewCell{
    @IBOutlet var CategotyName: UILabel!
    @IBOutlet var forwordImage: UIImageView!
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            CategotyName.textColor = .white
        } else {
            contentView.backgroundColor = UIColor.white
            CategotyName.textColor = .black
        }
    }
}

var arrCategories1 = ["Apartment for rent","Villa for sale","Land for sale","Villa for rent","Floor for rent","Apartment for sale","Building for sale","Esteraha for rent","Estaraha for sale","Store for rent","Farm for sale","Building for rent","Land for rent","Room for rent","Office for rent","Warehouse for rent"]


