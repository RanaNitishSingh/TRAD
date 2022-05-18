//  BurbleMe

//  Created by osx on 19/02/18.
//  Copyright © 2018 AppsMaven. All rights reserved.
//  Given by Archie Mittal

import Foundation

var bundleKey: UInt8 = 0
var bundle: Bundle! // from localization system class

func LocalizationBurble(_ string:String) -> String{
    
    return Localisator.sharedInstance.localizedStringForKey(string)
    
}

class Localisator {
    //    MARK: - Singleton method
    class var sharedInstance :Localisator {
        struct Singleton {
            static let instance = Localisator()
        }
        return Singleton.instance
    }
    
    // MARK: - Init method
    init() {
        if let langSet = UserDefaults.standard.string(forKey: "AppLang") {
            print(langSet)
            //            let locale = NSLocale.current.languageCode
            self.loadDictionaryForLanguage(langSet)
        }
        else {
            
            let locale = Locale.preferredLanguages[0]
            self.loadDictionaryForLanguage(locale)
        }
    }
    
    private func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    private func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }

    
    private var dicoLocalisation:NSDictionary!
    
    var languageLocales = ["es","de","fr","en", "zh-Hans"]
    
    //    fileprivate func loadDictionaryForLanguage(_ newLanguage:String) {
    //        if let path = Bundle(for:object_getClass(self)).url(forResource: "Localization", withExtension: "strings", subdirectory: nil, localization: newLanguage)?.path {
    //            if FileManager.default.fileExists(atPath: path) {
    //                UserDefaults.standard.set(newLanguage, forKey: "AppLang")
    //                dicoLocalisation = NSDictionary(contentsOfFile: path)
    //            }
    //        }
    //    }
    
    
    fileprivate func loadDictionaryForLanguage(_ newLanguage:String) {
        if let path = Bundle(for:object_getClass(self)!).url(forResource: "Localization", withExtension: "strings", subdirectory: nil, localization: newLanguage)?.path {
            if FileManager.default.fileExists(atPath: path) {
                UserDefaults.standard.set(newLanguage, forKey: "AppLang")
                dicoLocalisation = NSDictionary(contentsOfFile: path)
            }
        }
    }
    

    
//    func localizedStringForKey(key:String, comment:String) -> String {
//        return bundle.localizedString(forKey: key, value: comment, table: nil)
//    }
//
//    func localizedImagePathForImg(imagename:String, type:String) -> String {
//        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
//            return ""
//        }
//        return imagePath
//    }

    
    fileprivate func localizedStringForKey(_ key:String) -> String {
        
        if let dico = dicoLocalisation {
            if let localizedString = dico[key] as? String {
                return localizedString
            } else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }
    
    
    
    
    
}


class AnyLanguageBundle: Bundle {
    private var dicoLocalisation:NSDictionary!
    
    
    
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
            let bundle = Bundle(path: path) else {
                
                return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
    
}

extension Bundle {
    
    class func setLanguage(_ language: String) {
        defer {
            
            object_setClass(Bundle.main, AnyLanguageBundle.self)
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }
    
    
    
}


extension String {
    func localizedStr(bundle: Bundle = .main, tableName: String = "localizationStr") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "", comment: "")
    }
}
