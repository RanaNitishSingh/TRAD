//
//  Extensions.swift
//  scanquo
//  Created by zeroit01 on 29/03/22.


import UIKit

extension UIViewController {
    func addBackBtn(textColor:UIColor, title:String = "Back", isModelSheet: Bool = false) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let origImage = UIImage(named: "iconfinder_left_arrow_back_previous_navigation_3994376")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = textColor
        button.semanticContentAttribute = .forceLeftToRight
       // if title != "Activity".getLocalized(comment: ""){
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //}
        let title = NSLocalizedString(title, comment: "")
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        let padding: CGFloat = isModelSheet ? 14 : 0
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func addDoneBtn(textColor:UIColor, title: String = "Done") {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.tintColor = textColor
        button.semanticContentAttribute = .forceLeftToRight
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        let title = NSLocalizedString(title, comment: "")
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 14).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    @objc func backBtnPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func doneAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addBackBtnCmr(textColor:UIColor, title:String = "Back", isModelSheet: Bool = false) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let origImage = UIImage(named: "iconfinder_left_arrow_back_previous_navigation_3994376")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = textColor
        button.semanticContentAttribute = .forceLeftToRight
       // if title != "Activity".getLocalized(comment: ""){
      //  button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //}
        let title = NSLocalizedString(title, comment: "")
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        let padding: CGFloat = isModelSheet ? 14 : 0
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        //  button.heightAnchor.constraint(equalToConstant: 35).isActive = true
       // button.widthAnchor.constraint(equalToConstant: 35).isActive = true
    
    }
    
    
    
    
}
