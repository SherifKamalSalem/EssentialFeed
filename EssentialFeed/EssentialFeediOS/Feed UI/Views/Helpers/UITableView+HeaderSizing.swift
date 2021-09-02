//
//  UITableView+HeaderSizing.swift
//  EssentialFeediOS
//
//  Created by sherif kamal on 02/09/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

extension UITableView {
    func sizeTableHeaderToFit() {
        guard let header = tableHeaderView else { return }
        
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        let needsFrameUpdate = header.frame.height != size.height
        if needsFrameUpdate {
            header.frame.size.height = size.height
            tableHeaderView = header
        }
    }
}
