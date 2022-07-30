//
//  Date+Extension.swift
//  To Do List 2022
//
//  Created by Vitally Ochnev on 29.07.2022.
//

import Foundation

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
