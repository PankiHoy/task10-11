//
//  RSFont.swift
//  rs.ios.stage-task11
//
//  Created by dev on 8.09.21.
//

import Foundation
import UIKit

extension UIFont {
    class func robotoRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size)!
    }
    
    class func robotoBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
}
