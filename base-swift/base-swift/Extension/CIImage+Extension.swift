//
//  CIImage+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 16/04/2021.
//  Copyright © 2021 BaseSwift. All rights reserved.
//

import UIKit

extension CIImage {
    func combined(with image: CIImage) -> CIImage? {
        guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
        let centerTransform = CGAffineTransform(translationX: extent.midX - (image.extent.size.width / 2), y: extent.midY - (image.extent.size.height / 2))
        combinedFilter.setValue(image.transformed(by: centerTransform), forKey: "inputImage")
        combinedFilter.setValue(self, forKey: "inputBackgroundImage")
        return combinedFilter.outputImage!
    }
}
