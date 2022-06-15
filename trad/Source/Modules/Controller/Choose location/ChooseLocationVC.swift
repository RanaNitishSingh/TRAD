//
//  ChooseLocationVC.swift
//  trad
//  Created by Imac on 11/05/21.

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacesSearchController


class ChooseLocationVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet var continueBtn: UIButton!
    @IBOutlet var currentLocationBtn: UIButton!
    @IBOutlet var mapChangeBtn: UIButton!
    @IBOutlet var propertyType: UILabel!
    var Aproperties1 : [Propertiesdata] = []
    var CategoryDetail1 =  String()
    var categoryindex =  Int()
    var ImagesArray = [String]()
    var videosArray = [String]()
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.Aproperties1.count == 0 {
            propertyType.text = CategoryDetail1.localizedStr()
            currentLocationBtn.layer.cornerRadius = 26
            currentLocationBtn.alpha = 0.8
            mapView.delegate = self
            locationManager.delegate = self
            if CLLocationManager.locationServicesEnabled(){
                locationManager.requestLocation()
                mapView.isMyLocationEnabled = true
            }else {
                locationManager.requestWhenInUseAuthorization()
            }
            continueBtn.layer.cornerRadius = 24
            locationSearchBar.delegate = self
            self.locationManager.startUpdatingLocation()
            currentLocationBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            currentLocationBtn.imageView?.alpha = 0.70
            // Do any additional setup after loading the view.
            self.getMyCurrentLoction()
            mapChangeBtn.isSelected = true
            mapChangeBtn.layer.borderWidth = 2
            mapChangeBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            continueBtn.setTitle("continueBtn".localizedStr(), for: .normal)
           
        }else{
            propertyType.text = Aproperties1[0].selectCategory.localizedStr()
            mapView.delegate = self
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            let lat = Aproperties1[0].latitude
            let lng = Aproperties1[0].longitude
            let lati = Double(lat) ?? 0.0
            let longi = Double(lng) ?? 0.0
            mapView.camera = GMSCameraPosition(
                latitude: lati , longitude: longi  ,
                zoom: 15,
                bearing: 0,
                viewingAngle: 0)
            //Finally stop updating location otherwise it will come again and again in this delegate
            self.locationManager.stopUpdatingLocation()
            currentLocationBtn.layer.cornerRadius = 26
            currentLocationBtn.alpha = 0.8
            continueBtn.layer.cornerRadius = 24
            locationSearchBar.delegate = self
            currentLocationBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            currentLocationBtn.imageView?.alpha = 0.70
            // Do any additional setup after loading the view.
            mapChangeBtn.isSelected = true
            mapChangeBtn.layer.borderWidth = 2
            mapChangeBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            continueBtn.setTitle("continueBtn".localizedStr(), for: .normal)
          
        }
    }
    
    @IBAction func mapChangeAction(_ sender: UIButton) {
        if mapChangeBtn.isSelected == true{
            mapChangeBtn.isSelected = false
            mapChangeBtn.layer.borderWidth = 2
            mapChangeBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.5008728504, blue: 0.6056929231, alpha: 1)
            mapView.mapType = .hybrid
        }else{
            mapChangeBtn.isSelected = true
            mapChangeBtn.layer.borderWidth = 2
            mapChangeBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mapView.mapType = .normal
        }
    }
    
    @IBAction func onLaunchClicked(sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func getMyCurrentLoction()  {
        mapView.isMyLocationEnabled = true
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
              let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng, zoom: 14.0)
        self.mapView.animate(to: camera)
    }
    
    
    @IBAction func currentLocationAction(_ sender: Any) {
        self.getMyCurrentLoction()
    }
    
    
    func NextScreen(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "setFilterVC") as! setFilterVC
        vc.CategoryDetail2 = CategoryDetail1
        vc.ArrayImages  =  ImagesArray
        vc.arrayVideos = videosArray
        vc.latitude = latitude
        vc.longitude = longitude
        vc.categoryindex = categoryindex
        if Aproperties1.count != 0 {
            vc.updatePropertyData = self.Aproperties1
            print(vc.updatePropertyData)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func ContinueAction(_ sender: Any) {
        self.NextScreen()
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.addressLabel.text = lines.joined(separator: "\n")
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,bottom: labelHeight, right: 0)
            self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,bottom: labelHeight, right: 0)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }}}
}


//// MARK: - GMSMapViewDelegate

extension ChooseLocationVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        latitude = mapView.camera.target.latitude
        longitude = mapView.camera.target.longitude
        reverseGeocodeCoordinate(position.target)
    }
}


extension ChooseLocationVC: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.requestLocation()
        mapView.isMyLocationEnabled = true
    }
    
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            if self.Aproperties1.count == 0 {
                guard let location = locations.first else {
                    return
                }
                mapView.camera = GMSCameraPosition(
                    target: location.coordinate,
                    zoom: 15,
                    bearing: 0,
                    viewingAngle: 0)
                //Finally stop updating location otherwise it will come again and again in this delegate
                self.locationManager.stopUpdatingLocation()
            }
        }
    
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error)
    }
}

extension ChooseLocationVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
        self.mapView.clear()
        let cord2D = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        self.mapView.camera = GMSCameraPosition.camera(withTarget: cord2D, zoom: 15)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
