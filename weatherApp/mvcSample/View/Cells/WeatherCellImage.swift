//
//  WeatherCellImage.swift
//  mvcSample
//
//  Created by Julia Debecka on 22/03/2020.
//  Copyright © 2020 lpb. All rights reserved.
//

import UIKit

enum WeatherCellImage {
    case sun, cloudHeavyRain, cloudSun, cloudSunRain, wind, snow
    
    var associatedValue: UIImage {
        switch self{
            case .sun:
                return UIImage(systemName: "sun.max.fill")!
            case .cloudHeavyRain:
                return UIImage(systemName: "cloud.heavyrain.fill")!
            case .cloudSun:
                return UIImage(systemName: "cloud.sun.fill")!
            case .cloudSunRain:
                return UIImage(systemName: "cloud.sun.rain.fill")!
            case .wind:
                return UIImage(systemName: "wind")!
            case .snow:
                return UIImage(systemName: "snow")!
        }
    }
}
