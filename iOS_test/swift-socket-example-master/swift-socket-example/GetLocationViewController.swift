import UIKit
import CoreLocation

class GetLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // locationManageの設定
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startSearchLocation(sender: UIButton) {
        
        // 位置情報のアクセス許可の状況に応じて、アクセス許可の取得、位置情報取得の開始を行う
        let status = CLLocationManager.authorizationStatus()
        switch status{
        case .Restricted, .Denied:
            break
        case .NotDetermined:
            // iOS8ではアクセス許可のリクエストをする。iOS7では位置情報取得処理を開始することでアクセス許可のリクエストをする
            if locationManager.respondsToSelector("requestWhenInUseAuthorization"){
                locationManager.requestWhenInUseAuthorization()
            }else{
                locationManager.startUpdatingLocation()
            }
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    // 位置情報のアクセス許可の状況が変わったときの処理
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status{
        case .Restricted, .Denied:
            manager.stopUpdatingLocation()
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    // 位置情報が取得できたときの処理
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if locations.count > 0{
            currentLocation = locations.last as? CLLocation
            NSLog("緯度:\(currentLocation?.coordinate.latitude) 経度:\(currentLocation?.coordinate.longitude)")
        }
        
    }
}