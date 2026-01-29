//
//  RowItem.swift
//  wrapd
//
//  Created by Hassan Sheikha on 2026-01-29.
//

import Foundation

struct RowItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isChecked: Bool = false
    var isEditing: Bool = false
}
