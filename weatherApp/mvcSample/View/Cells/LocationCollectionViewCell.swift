//
//  LocationViewCell.swift
//  mvcSample
//
//  Created by Julia Debecka on 19/03/2020.
//  Copyright © 2020 lpb. All rights reserved.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
     fileprivate lazy var gradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colors = cellRandomBackgroundColors()
        gl.colors = [colors[0].cgColor, colors[1].cgColor]
        gl.startPoint = CGPoint(x: 0.0, y: 0.0)
        gl.endPoint = CGPoint(x: 0.0, y: 1.0)
        gl.frame = self.bounds
        return gl
    }()
     
    var data: LocationViewController.LocationCellData! {
        didSet{
            guard let data = data else { return }
            cityLabel.text = data.city
            currentTemperature.text = "\(data.temperature.0)\(data.temperature.1)"
        }
    }
    
    fileprivate lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = randomWeatherImage()
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Warszawa"
        label.font = .systemFont(ofSize: 24.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let date: UILabel = {
        let dateLabel = UILabel()
        var date = Date()
        let currentDate = Calendar.current
        let day = currentDate.component(.day, from: date)
        let month = currentDate.component(.month, from: date)
        let year = currentDate.component(.year, from: date)
        dateLabel.text = "\(day) \(month), \(year)"
        dateLabel.font = .systemFont(ofSize: 12.0, weight: .thin)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    fileprivate let currentTemperature: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "20°"
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    fileprivate let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3
        self.clipsToBounds = false
    }
    
    func roundCorner() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func randomWeatherImage() -> UIImage {
        let imageTable: [Int: UIImage] = [0: WeatherCellImage.cloudHeavyRain.associatedValue, 1: WeatherCellImage.cloudSun.associatedValue, 2: WeatherCellImage.cloudSunRain.associatedValue, 3: WeatherCellImage.snow.associatedValue, 4: WeatherCellImage.wind.associatedValue, 5: WeatherCellImage.sun.associatedValue]
        
        let randomImage = imageTable.values.randomElement()
        return randomImage!
    }
    
    func cellRandomBackgroundColors() -> [UIColor] {
        //Colors
        let blue = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.1803921569, green: 0.4588235294, blue: 1, alpha: 1)]
        let grey = [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let yellow = [#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1),#colorLiteral(red: 0.8931249976, green: 0.5340107679, blue: 0.08877573162, alpha: 1)]
        
        let colorsTable: [Int: [UIColor]] = [0: blue, 1: grey, 2: yellow, 3: yellow]
        
        let randomColors = colorsTable.values.randomElement()
        return randomColors!
    }
    func gradientBackgroundColor() {
        let colors = cellRandomBackgroundColors()
        contentView.backgroundColor = colors[0]
    }

    
    fileprivate func setUp(){
        //stack
        setCellShadow()
        roundCorner()
        
        //stackView
        contentView.addSubview(cityLabel)
        contentView.addSubview(date)
        contentView.addSubview(stackView)
        
        contentView.addSubview(currentTemperature)
        contentView.addSubview(weatherImage)
        
        contentView.layer.insertSublayer(self.gradientLayer, at: 0)
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(date)

        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        currentTemperature.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        currentTemperature.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        weatherImage.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 0.2).isActive = true
        weatherImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        weatherImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    
    }
}
