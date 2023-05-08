//
//  FirstVC.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 26.01.2023.
//

import UIKit
import MapKit


class FirstVC: UIViewController,CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTarih: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectView: UICollectionView!
    
    
    
    var locationManager = CLLocationManager()
    var viewModel = WeatherViewModel()
    var resultData = WeatherList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupViewModelObserver()
        setupCircleView()
        setupCollecitonview()
        viewModel.getWeather(lang: "tr", city: "ankara") //emulatöre kapalıyken yorumsatırına al
        
    }
    func assignbackground(status:String){
        let background = UIImage(named: status)
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setupCircleView(){
        blurView.layer.cornerRadius = 16
    }
    
    
    
    //MARK: LocationManager Kurulum işlemleri
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: locValue.latitude, longitude:  locValue.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            
            placemarks?.forEach { (placemark) in
                
                if let city = placemark.administrativeArea {
                    self.viewModel.getWeather(lang: "tr", city: city.forSorting)
                }
            }
        })
    }
    
    
    //MARK: ViewModel ve Data Binding işlemleri
    fileprivate func setupViewModelObserver() {
        viewModel.weeather.bind { [weak self] (result) in
            DispatchQueue.main.async {
                self?.lblTarih.text = result?.result?[0].date
               // self?.lblDegree.text = String(round(Double(((result?.result?[0].degree)!))!)) + "°"
               self?.lblDegree.text = String(Int(Double(((result?.result?[0].degree)!))!)) + "°"
              
                self?.lblHumidity.text =  (result?.result?[0].humidity ?? "0") + "%"
                self?.lblStatus.text = (result!.result?[0].description)?.firstUppercased
                self?.lblCity.text = result?.city?.firstUppercased
                self?.collectView.reloadData()
                if  result!.result?[0].status == "Rain"{
                    self?.imgView.image = UIImage(named: "raining")
                    self!.assignbackground(status: "rainy")
                }else if result!.result?[0].status == "Clouds"{
                    self?.imgView.image = UIImage(named: "clouds")
                    self!.assignbackground(status: "kapali")
                }else if result!.result?[0].status == "Snow"{
                    self?.imgView.image = UIImage(named: "snowing")
                    self!.assignbackground(status: "snowy")
                }else if result!.result?[0].status == "Sunny"{
                    self?.imgView.image = UIImage(named: "suninnig")
                    self!.assignbackground(status: "sunny")
                }else if result!.result?[0].status == "Clear" {
                    self?.imgView.image = UIImage(named: "suninnig")
                    self!.assignbackground(status: "sunny")
                }
            }
        }
        viewModel.isLoading.bind { [weak self] (isLoading) in
            guard let isLoading = isLoading else { return }
            DispatchQueue.main.async { [self] in
                isLoading ? self?.indicatorView.startAnimating() : self?.indicatorView.stopAnimating()
                self?.indicatorView.isHidden = !isLoading
            }
        }
        
        viewModel.alertItem.bind{ [weak self] (alert) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: self?.viewModel.alertItem.value?.title ?? "Uyarı",
                                              message: self?.viewModel.alertItem.value?.message ?? "Bir Hata Oluştu",
                                              preferredStyle: .alert)
                let okButton = UIAlertAction(title: self?.viewModel.alertItem.value?.dismissButton ?? "Tamam", style: .default)
                alert.addAction(okButton)
                self?.present(alert, animated: true)
            }
        }
    }
    
    //MARK:  Collecitonview Delegate ve Datasource İşlemleri
    
    func setupCollecitonview(){
        collectView.dataSource = self
        collectView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weeather.value?.result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item:WeatherList = (viewModel.weeather.value?.result?[indexPath.row])!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! FirstCell
        cell.lblCollectionDay.text = item.day
        
        if  item.day == "Pazartesi"{
            cell.lblCollectionDay.text = "Pzt."
        }else if item.day == "Salı"{
            cell.lblCollectionDay.text = "Sal."
        }else if item.day == "Çarşamba"{
            cell.lblCollectionDay.text = "Çar."
        }else if item.day == "Perşembe"{
            cell.lblCollectionDay.text = "Per."
        }else if item.day == "Cuma"{
            cell.lblCollectionDay.text = "Cum."
        }else if item.day == "Cumartesi"{
            cell.lblCollectionDay.text = "Cts."
        }else{
            cell.lblCollectionDay.text = "Paz."
        }
        cell.lblCollectionDegree.text = String(Int(Double(((item.degree)!))!)) + "°"
        
        if  item.status == "Rain"{
            cell.imgMiniIcon.image = UIImage(named: "rainyicon")
        }else if item.status == "Clouds"{
            cell.imgMiniIcon.image = UIImage(named: "partlycloudyicon")
        }else if item.status == "Snow"{
            cell.imgMiniIcon.image = UIImage(named: "snowyicon")
            //cell.imgMiniIcon.kf.setImage(with: URL(string: item.icon!))
        }else if item.status == "Sunny"{
            cell.imgMiniIcon.image = UIImage(named: "sunicon")
        }else if item.status == "Clear"{
            cell.imgMiniIcon.image = UIImage(named: "sunicon")
        }
        
        cell.layer.borderColor =  UIColor(white: 1.0, alpha: 0.5).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.5)

        
//        cell.frame.size.width = 85
//        cell.frame.size.height = 72
        
        return cell
    }
    
    
}


