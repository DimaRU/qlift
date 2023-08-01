//
//  CQString.swift
//  
//
//  Created by Dmitriy Borovikov on 27.07.2023.
//

import CQlift

extension CQString {
    var string: String {
        String(utf16CodeUnits: self.utf16, count: Int(self.size))
    }
}
