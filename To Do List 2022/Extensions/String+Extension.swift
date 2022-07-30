//
//  String+Extension.swift
//  To Do List 2022
//
//  Created by Vitally Ochnev on 29.07.2022.
//

extension String {
    var capitalizedWithSpaces: String {
        let withSpaces = reduce("") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
        }
        
        return withSpaces.capitalized
    }
}
