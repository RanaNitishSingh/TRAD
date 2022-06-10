//
//  googlePlacesManagers.swift
//  trad
//
//  Created by ZIT-12 on 09/06/22.
//

import Foundation
import GooglePlaces

final class googlePlacesManagers {
    
    static let shared = googlePlacesManagers()
    
    private let client = GMSPlacesClient.shared()
    
    private init(){}
    
    public func setUp() {
        
        GMSPlacesClient.provideAPIKey("AIzaSyDrpoJE-FXgMvHJx3Bw0rNNIXez2IGYyN8")
        
    }
    
    
    
}
