//
//  addUsersVC.swift
//  trad
//
//  Created by zeroit01 on 13/09/21.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore


@available(iOS 13.0, *)
class addUsersVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lanuageLbl: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var logoutBTN: UIButton!
    @IBOutlet weak var lblUserName: UITextField!
    @IBOutlet weak var lblUserEmail: UITextField!
    @IBOutlet weak var lblUserPassword: UITextField!
    @IBOutlet weak var radioBtnAdmin: UIButton!
    @IBOutlet weak var AdminTableView: UITableView!
    @IBOutlet weak var radioBtnUsers: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var lblUserType: UILabel!
    @IBOutlet weak var lblAdmin: UILabel!
    @IBOutlet weak var lblUsers: UILabel!
    var validation = Validation()
    var arrayuserName = [String]()
    var arrayUseremail = [String]()
    var arrayUserPassword = [String]()
    var db: Firestore!
    var selectedAdmin: String = ""
    var AdminList = ["Admin 1","Admin 2","Admin 3","Admin 4"]
    var UserType = String()
    var arrayUser = [String]()
    var arrayUserId = [String]()
    var arrayUserType = [String]()
    var arrayAdminName = [String]()
    var arrayPropertCount = [Int]()
    var user_Type: String? = ""
    var userName: String? = ""
    var email: String? = ""
    var uId: String?   = ""
    var SubUid: String? = ""
    var AdminUid: String? = ""
    var UserData: [userData] = []
    var mainArrayData : [userData] = []
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var userIdProperties : String? = ""
    var userNameProperties : String? = ""
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var userTypeLbl: UILabel!
    @IBOutlet var userAdminNameLbl: UILabel!
    var usersProperties: [Propertiesdata] = []
    var usersMainArrayProperties : [Propertiesdata] = []
    var show = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.placeholder = "UserName".localizedStr()
        lblUserEmail.placeholder = "Email".localizedStr()
        lblUserPassword.placeholder = "Password".localizedStr()
        btnLogin.setTitle("Add User".localizedStr(), for: .normal)
        lblUserType.text = "User Type".localizedStr()
        lblAdmin.text = "Admin".localizedStr()
        lblUsers.text = "Users".localizedStr()
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        self.AdminTableView.delegate = self
        self.AdminTableView.dataSource = self
        self.lblUserName.delegate = self
        self.lblUserEmail.delegate = self
        self.lblUserPassword.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.userTableView.reloadData()
        self.AdminTableView.reloadData()
        self.AdminTableView.isHidden =  true
        btnLogin.layer.cornerRadius = 24
        ReadFireBaseUsersCollection()
        getData()
        fetchDatafromFirebase()
        userNameLbl.layer.cornerRadius = 5
        userNameLbl.layer.masksToBounds = true
        userTypeLbl.layer.cornerRadius = 5
        userTypeLbl.layer.masksToBounds = true
        userAdminNameLbl.layer.cornerRadius = 5
        userAdminNameLbl.layer.masksToBounds = true
        logoutBTN.layer.cornerRadius = 12
        switchBtn.isHidden = true
        lanuageLbl.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tabBarController?.tabBar.isHidden = false
        fetchDatafromFirebase()
        getData()
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        self.AdminTableView.delegate = self
        self.AdminTableView.dataSource = self
        self.lblUserName.delegate = self
        self.lblUserEmail.delegate = self
        self.lblUserPassword.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.userTableView.reloadData()
        self.AdminTableView.reloadData()
        self.AdminTableView.isHidden =  true
        userNameLbl.layer.cornerRadius = 5
        userNameLbl.layer.masksToBounds = true
        userTypeLbl.layer.cornerRadius = 5
        userTypeLbl.layer.masksToBounds = true
        userAdminNameLbl.layer.cornerRadius = 5
        userAdminNameLbl.layer.masksToBounds = true
        logoutBTN.layer.cornerRadius = 12
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
      
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    //MARK:-  Read User's data on Firebase
    func ReadFireBaseUsersCollection(){
        
        db = Firestore.firestore()
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let datta = document.get("UserName") as! String ?? ""
                    let userType = document.get("UserType") as! String ?? ""
                    let adminName = document.get("AdminName") as! String ?? ""
                    let userid  =  document.get ("uid") as! String ?? ""
                    let countProperty = document.get ("propertyCount") as!  Int ?? 0
                    self.arrayUser.append(datta)
                    self.arrayUserType.append(userType)
                    self.arrayAdminName.append(adminName)
                    self.arrayUserId.append(userid)
                    self.arrayPropertCount.append(countProperty)
                    self.userTableView.reloadData()
                    
                }
            }
        }
    }
    
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)}
    
    

    @IBAction func actionSwitchBtn(_ sender: UISwitch) {
        
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            
            
            UserDefaults.standard.set(true, forKey: "switch")
            UserDefaults.standard.set("ar", forKey: "CurrentLanguage")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Bundle.setLanguage("ar");
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            print("english")
            show = false
   
            switchBtn.isOn = true
            switchBtn.setOn(true, animated: true)
            sender.isOn = true
            
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let search = mainStory.instantiateViewController(withIdentifier: "addUsersVC") as! addUsersVC
            UIView.beginAnimations("animation", context: nil)
            UIView.setAnimationDuration(1.0)
            self.navigationController!.pushViewController(search, animated: false)
            UIView.setAnimationTransition(UIView.AnimationTransition.flipFromLeft, for: self.navigationController!.view, cache: false)
            UIView.commitAnimations()
            
            
        } else {
            
            var transition: UIView.AnimationOptions = .transitionFlipFromLeft
            print("Ar")
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UserDefaults.standard.set(false, forKey: "switch")
            UserDefaults.standard.set("en", forKey: "CurrentLanguage")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Bundle.setLanguage("en")
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            switchBtn.isOn = true
            switchBtn.setOn(true, animated: true)
            sender.isOn = true
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let search = mainStory.instantiateViewController(withIdentifier: "addUsersVC") as! addUsersVC
            UIView.beginAnimations("animation", context: nil)
            UIView.setAnimationDuration(1.0)
            self.navigationController!.pushViewController(search, animated: false)
            UIView.setAnimationTransition(UIView.AnimationTransition.flipFromRight, for: self.navigationController!.view, cache: false)
            UIView.commitAnimations()
        
        }
    }
    
    
    
    @IBAction func actionLogoutBtn(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user_Email")
        defaults.removeObject(forKey: "user_Password")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"ViewController") as! ViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
 
    @IBAction func radioActionAdmin(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            radioBtnUsers.isSelected = false
            UserType.removeAll()
            // selectedAdmin.removeAll()
        } else {
            self.UserType = "Admin"
            print(UserType)
            self.AdminTableView.isHidden =  true
            sender.isSelected = true
            radioBtnUsers.isSelected = false
        }}
    
    @IBAction func radioActionUsers(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            radioBtnAdmin.isSelected = false
            // UserType.removeAll()
            selectedAdmin.removeAll()
        } else {
            self.UserType = "User"
            self.AdminTableView.isHidden =  false
            print(UserType)
            sender.isSelected = true
            radioBtnAdmin.isSelected = false
        }}
    
    
    
    func getData() {
        //Get specific document from current user
        let userDB = Firestore.firestore()
            .collection("Users")
            .document(UserDefaults.standard.value(forKey: "loginUID") as! String)
        
        // Get data
        userDB.getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            let user1 = document.data()
            self.user_Type = user1?["UserType"] as? String
            self.userName = user1?["UserName"] as? String
            self.email = user1?["Email"] as? String
            self.uId  = user1?["uid"] as? String
            self.SubUid = user1?["subUid"] as? String
            self.AdminUid = user1?["adminUid"] as? String
        }
    }
    
    
    //MARK:- Add New User's to FireBaseAuth and Firestore
    
    func AddNewUser(AdminName: String) {
        Auth.auth().createUser(withEmail: (lblUserEmail.text ?? ""), password: (lblUserPassword.text ?? "")) { (result, error) in
            if let _eror = error {
                self.showAlert(message: _eror.localizedDescription )
            } else {
                self.showAlert(message: "user registered successfully" )
                print(result?.user.uid)
                //  var ref: DocumentReference? = nil
                let userID = result?.user.uid
                self.db.collection("Users").document(userID!).setData ([
                    "UserName":  self.lblUserName.text!,
                    "Email": self.lblUserEmail.text!,
                    "Password": self.lblUserPassword.text!,
                    "UserType":  self.UserType,
                    "adminUid" : self.uId!,
                    "masterUid" : self.AdminUid!,
                    "propertyCount" : 0 as Int,
                    "appLanguage" : "en",
                    "deviceToken" : "",
                    "uid" : userID!,
                    "AdminName" : AdminName] , merge : true)
                { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        self.userTableView.reloadData()
                        print("Document added with ID: \(userID!)")
                    }
                }
                
                self.lblUserName.text?.removeAll()
                self.lblUserEmail.text?.removeAll()
                self.lblUserPassword.text?.removeAll()
                self.UserType.removeAll()
                self.radioBtnAdmin.isSelected = false
                self.radioBtnUsers.isSelected = false
                self.AdminTableView.isHidden =  true
                self.selectedAdmin.removeAll()
            }
        }
    }
    
    //MARK:- Validation and post Api
    @IBAction func BtnActionAddUser(_ sender: Any) {
        guard let name = lblUserName.text,
              let email = lblUserEmail.text,
              let password = lblUserPassword.text
        else  {return}
        let isValidateName = self.validation.validateName(name: name)
        if (isValidateName == false) {
            showAlert(message: "Enter Valid UserName".localizedStr())
            print("Incorrect Name")
            return
        }
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if (isValidateEmail == false) {
            showAlert(message: "Enter Valid Email".localizedStr())
            print("Incorrect Email")
            return
        }
        let isValidatePass = self.validation.validatePassword(password: password)
        if (isValidatePass == false) {
            showAlert(message: "Password minimum 8 characters at least 1 Alphabet and 1 Number".localizedStr())
            print("Incorrect Pass")
            return
        }
        
        if UserType.isEmpty ==  true {
            showAlert(message: "Please Select valid UserType ")
        } else if UserType == "Admin"  {
            selectedAdmin.removeAll()
            AddNewUser(AdminName: "")
        } else if UserType == "User" && selectedAdmin.isEmpty == true {
            showAlert(message: "Please select one of the admin")
            
        } else {
            AddNewUser(AdminName: self.selectedAdmin)
            
        }
        
    }
    
    
    func fetchDatafromFirebase(){
        
        Helper().showUniversalLoadingView(true)
        
        let db = Firestore.firestore()
        db.collection("Users").getDocuments() { [self] (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.mainArrayData = querySnapshot?.documents.reversed().compactMap { document in
                    // 6
                    try? document.data(as: userData.self)
                } ?? []
                
                self.UserData = self.mainArrayData
            }
            
            AdminTableView.reloadData()
            Helper().showUniversalLoadingView(false)
        }
    }
}



//MARK:- TableView

@available(iOS 13.0, *)
extension addUsersVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == userTableView {
            return arrayUser.count
        } else if tableView == AdminTableView {
            return self.UserData.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == userTableView {
            
            let cell = userTableView.dequeueReusableCell(withIdentifier: "addUsersTableViewCell", for: indexPath) as! addUsersTableViewCell
            cell.userNameCellLBL.text = arrayUser[indexPath.row].localizedStr()
            
            cell.userTypeLbl.text = arrayUserType[indexPath.row].localizedStr()
            cell.userAdminLbl.text = arrayAdminName[indexPath.row].localizedStr()
            print(self.arrayUser[indexPath.row])
            return cell
            
        }else{
            
            let Admincell = AdminTableView.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell
            if self.UserData[indexPath.row].uid == uId || self.UserData[indexPath.row].adminUid == uId  {
                Admincell.AdminNameTableCellLBL.text = self.UserData[indexPath.row].UserName.localizedStr()
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
                Admincell.selectedBackgroundView = backgroundView
                Admincell.AdminNameTableCellLBL.textColor = indexPath == selectedIndexPath ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.01752752591, green: 0.01752752591, blue: 0.01752752591, alpha: 1)
            }else {
                Admincell.isHidden = true
            }
            return Admincell
            
        }}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == AdminTableView {
            selectedAdmin = self.UserData[indexPath.row].UserName
            print(selectedAdmin)
        }
        
        else if tableView == userTableView {
            
            // userDataFetchfromFirebase()
            
            
            for item in UserData {
                if item.UserName == arrayUser[indexPath.row]{
                    print(item.UserName)
                    print(arrayPropertCount[indexPath.row])
                    
                    let message = "Number of properties Added By"
                    
                    TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "\(message.localizedStr()) \(arrayUser[indexPath.row])  \(arrayPropertCount[indexPath.row]) ", VC: self, cancel_action: false)
                    
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
        
    }
    
}


//MARK:- Name, email and Password Validation

class Validation {
    public func validateName(name: String) ->Bool {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "^\\w{3,18}$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    public func validatePassword(password: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    
}


struct userData: Codable {
    
    let UserType : String
    let UserName : String
    let Email : String
    let AdminName : String
    let uid: String
    let masterUid: String
    let adminUid: String
    let propertyCount : Int
    let appLanguage : String
}


struct Constants {
    struct StoryboardID {
        static let signInViewController = "ViewController"
        static let mainTabBarController = "MainTabBarController"
    }
    
    struct kUserDefaults {
        static let isSignIn = "isSignIn"
    }
}


