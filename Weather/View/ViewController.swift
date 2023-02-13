//
//  ViewController.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 25.01.2023.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate  {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var lblSaat: UILabel!
    @IBOutlet weak var lblDerece: UILabel!
    @IBOutlet weak var mySegmented: UISegmentedControl!
    @IBOutlet weak var circleView: UIView!
    
    var viewModel = WeatherViewModel()
    var resultData = WeatherList()
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircleView()
        lblDerece.text = resultData.day
        print(viewModel.weeather.value?.result?.count)
    }
    
    //MARK:CircleView
    func setupCircleView(){
        //Circle View Screen Width'in 10/8 kadar olsun
        //Circle View Height Width ile aynı olsun
        //Circle View Corner Radiusu Width'inin yarısı kadar olsun
        //Circle View Center Horizontal olacak
        //Circle View in sağ veya sola olan uzaklığının 2 katı üste margin verilecek
        
        //Image View'in width'i Circle view in yarısı olacak
        //Heighti eşit olacak
        //Horizontalına hem Verticalına ortalanacak
        
        circleView.layer.cornerRadius = 170
        circleView.layer.borderWidth = 14
        circleView.layer.borderColor =  UIColor(white: 1.0, alpha: 0.5).cgColor
        circleView.backgroundColor =  UIColor.black.withAlphaComponent(0.5)
        
        
    }

    
    

}


