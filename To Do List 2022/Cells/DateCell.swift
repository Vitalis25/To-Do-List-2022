//
//  DateCell.swift
//  To Do List 2022
//
//  Created by Vitally Ochnev on 30.07.2022.
//

import UIKit

class DateCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    func setDate(_ date: Date) {
        label.text = date.formattedDate
    }
}
