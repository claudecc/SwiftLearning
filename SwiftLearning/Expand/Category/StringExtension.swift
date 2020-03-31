//
//  StringExtension.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/3/31.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

extension String {
    
    func getWidth(font:UIFont) -> CGFloat {
        let maxSize = CGSize(width: 0, height: font.lineHeight)
        let attributes = [NSAttributedStringKey.font: font]
        let width = self.boundingRect(with: maxSize, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes, context: nil).width
        return width
    }
    
    
    
}

extension NSAttributedString {
    
    func getSize(maxW:CGFloat) -> CGSize {
        let maxSize = CGSize(width: maxW, height: CGFloat(MAXFLOAT))
        let size = self.boundingRect(with: maxSize, options:NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
        return size
    }
    
}
