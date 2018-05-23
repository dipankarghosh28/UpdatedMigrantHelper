//
//  HousingViewController.swift
//  NeedHelp
//
//  Created by Dipankar Ghosh on 5/23/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore
class HousingViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var housingtextview: UITextView!
    @IBOutlet weak var housingmap: MKMapView!
    
    var ref: DatabaseReference?
    var refdb: DatabaseReference?
    let db1 = Firestore.firestore()
    var databaseHandle: DatabaseHandle?
    var postData = [String]()
    // var ref: DatabaseReference! = Database.database("https://needhelp-ed995.firebaseio.com/").reference()
    
    
    //MAP
    
    struct globalvariable
    {
        static var myStruct = String()
    }
    
    let manager = CLLocationManager()
    var lat  = ""
    var long = ""
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let location:CLLocationCoordinate2D = manager.location!.coordinate
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01,0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        housingmap.setRegion(region, animated: true)
        self.housingmap.showsUserLocation = true
        //The above code is for location pinpointing on map
        
        //print("The location Altitude is:",location.altitude)
        //print("The location Speed is:",location.speed)
        //print("The coordinate is:", location.coordinate);
        lat = String(location.coordinate.latitude)
        long = String(location.coordinate.longitude)
        
        //print("The latitude is:",lat)
        //print("The longitude is:",long)
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lati: Double = Double("\(lat)")!
        //print(lati)
        //21.228124
        let longi: Double = Double("\(long)")!
        //72.833770
        //print(longi)
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lati
        center.longitude = longi
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    /* print(pm.country)
                     print(pm.locality)
                     print(pm.subLocality)
                     print(pm.thoroughfare)
                     print(pm.postalCode)
                     print(pm.subThoroughfare)
                     */
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    print("This is the address", addressString)
                    //self.label2.text = addressString
                    globalvariable.myStruct = addressString
                    //  print("This is the global variable->",globalvariable.myStruct)
                }
        })
        
    }
    
    
    @IBAction func HousingNeedHelp(_ sender: Any) {
        //post data to firebase
        var refdb: DocumentReference? = nil
        refdb = db1.collection("housingaddress").addDocument(data: [
            "housingddress": globalvariable.myStruct
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(refdb!.documentID)")
            }
        }
        
        print("Need Help Clicked GlobalVariable stores->",globalvariable.myStruct)
        ref?.child("housingaddress").childByAutoId().setValue(globalvariable.myStruct)
    }
    @IBAction func GetLocation(_ sender: Any) {
        /* db1.collection("address").getDocuments() { (querySnapshot, err) in
         if let err = err {
         print("Error getting documents: \(err)")
         } else {
         for document in querySnapshot!.documents {
         print("DocumentID is ->")
         print("\(document.documentID) => \(document.data())")
         //self.textview.text=document.data()
         
         }
         }
         }
         */
        
        NSLog("Housing needed here")
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("housingaddress").observe(.childAdded, with: {(snapshot) in
            
            let post = snapshot.value as? String
            if let actualPost = post{
                self.postData.append(actualPost)
                self.housingtextview.text = actualPost
                
            }
        })
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        //print("reaching here")
        print("here is the delay")
        manager.distanceFilter = 250.0;
        
        //manager.allowsBackgroundLocationUpdates = true
        //manager.pausesLocationUpdatesAutomatically = true
        //  manager.activityType = .fitness
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
