//
//  CollectionView+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 1/9/21.
//  Copyright © 2021 BaseSwift. All rights reserved.
//

import UIKit
extension UICollectionView {

    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}
