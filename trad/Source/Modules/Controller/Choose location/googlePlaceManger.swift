//
//  googlePlaceManger.swift
//  trad
//
//  Created by ZIT-12 on 09/06/22.
//

import Foundation
import GooglePlaces


struct Places {
    
    let name: String
    let identifire: String
    
}

final class googlePlaceManger {
    
    static let shared = googlePlaceManger()
    private let client = GMSPlacesClient.shared()
    
    private init () {}
    
    enum PlacesError: Error {
        case failedToFind
    }
    
    public func setup() {
        GMSPlacesClient.provideAPIKey("AIzaSyDrpoJE-FXgMvHJx3Bw0rNNIXez2IGYyN8")
    }
    
    public func findPlaces(query: String , completion: @escaping(Result<[Places],Error>) -> Void ) {
        let filter = GMSAutocompleteFilter()
        filter.type  = .geocode
        
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { result, error in
            guard let result = result , error == nil else {
                completion(.failure(PlacesError.failedToFind))
                return  
            }
            
            let places: [Places] = result.compactMap({ Places(name: $0.attributedFullText.string, identifire: $0.placeID)
            })
            
            completion(.success(places))
            
        }
        
    }
    
    
}
