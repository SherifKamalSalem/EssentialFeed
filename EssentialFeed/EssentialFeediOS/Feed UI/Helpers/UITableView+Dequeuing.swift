//
//  UITableView+Dequeuing.swift
//  EssentialFeediOS
//
//  Created by sherif kamal on 15/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
