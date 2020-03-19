//
//  CellImage.swift
//  mvcSample
//
//  Created by Julia Debecka on 19/03/2020.
//  Copyright © 2020 lpb. All rights reserved.
//

import UIKit

enum CellImage {
    case paperplane, clock
    
    var associatedValue: UIImage {
        switch self{
        case .paperplane:
            return UIImage(systemName: "paperplane.fill")!
        case .clock:
            return UIImage(named: "clock")!
        }
    }
}
