//
//  CGFloat+.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/01.
//

import Foundation
import UIKit

extension Int {
    func sizeToFit() -> CGFloat {
        let multiplaValue = UIScreen.main.bounds.width / 375
        return CGFloat(self)*multiplaValue
    }
}
