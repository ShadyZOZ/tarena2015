//
//  WeatherViewController.swift
//  Weather
//
//  Created by tony on 7/7/15.
//  Copyright (c) 2015 shadyzoz. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if(ios8())
        {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    func ios8() -> Bool
    {
        return UIDevice.currentDevice().systemVersion >= "8.0"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location: CLLocation = locations[locations.count - 1] as! CLLocation
        if location.horizontalAccuracy > 0
        {
            updateWeather("\(location.coordinate.longitude),\(location.coordinate.latitude)")
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    func updateWeather(coordinates: String)
    {
        let key = "pomjoL2Gl1b3PfEyjC6SwGZL"
        let url: NSURL = NSURL(string: "http://api.map.baidu.com/telematics/v3/weather?location=\(coordinates)&output=json&ak=\(key)")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let session: NSURLSession = NSURLSession.sharedSession()
        let dataTask : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error != nil
            {
                let alertView = UIAlertView(title: "出现错误", message: nil, delegate: nil, cancelButtonTitle: "确定")
                alertView.show()
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), {
                    let weatherModel: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil) as! NSDictionary
                    println(weatherModel["error"]!)
                    if (weatherModel["error"] as! Int) == 0
                    {
                        let results: NSArray = weatherModel["results"] as! NSArray
                        self.currentCityLabel.text = (results[0]["currentCity"] as! String)
                        let weatherData: NSArray = results[0]["weather_data"] as! NSArray
                        let weather = weatherData[0]["weather"] as! String
                        let temperature = weatherData[0]["temperature"] as! String
                        let wind = weatherData[0]["wind"] as! String
                        self.weatherImageView.image = UIImage(named: weather) == nil ? UIImage(named: "duono"):UIImage(named: weather)
                        self.weatherLabel.text = "天气： \(weather)"
                        self.temperatureLabel.text = "温度： \(temperature)"
                        self.windLabel.text = "风力： \(wind)"
                    }
                    else
                    {
                        let alertView = UIAlertView(title: "出现错误", message: (weatherModel["status"] as! String), delegate: nil, cancelButtonTitle: "确定")
                        alertView.show()
                    }
                })
            }
        });
        dataTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
