//
//  String+Blank.swift
//  wrapd
//
//  Created by Hassan Sheikha on 2026-01-29.
//

import Foundation

extension String {
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
