//
//  RowItemView.swift
//  wrapd
//
//  Created by Hassan Sheikha on 2026-01-29.
//

import SwiftUI

struct RowItemView: View {
    @Binding var item: RowItem
    @Binding var items: [RowItem]
    @FocusState.Binding var focusedItemID: RowItem.ID?

    var body: some View {
        HStack {
            checkButton

            if item.isEditing {
                editingField
            } else {
                titleText
            }

            deleteButton
        }
        .onChange(of: focusedItemID) { _, newValue in
            item.isEditing = (newValue == item.id)
        }
    }
}

// MARK: - Subviews
private extension RowItemView {

    var checkButton: some View {
        Button {
            item.isChecked.toggle()
        } label: {
            Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isChecked ? .green : .secondary)
                .imageScale(.large)
        }
        .buttonStyle(.plain)
    }

    var editingField: some View {
        TextField("New item", text: $item.title)
            .textFieldStyle(.roundedBorder)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .focused($focusedItemID, equals: item.id)
            .onSubmit {
                item.isEditing = false
            }
    }

    var titleText: some View {
        Text(item.title)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture(count: 2) {
                item.isEditing = true
                focusedItemID = item.id
            }
    }

    var deleteButton: some View {
        Button {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items.remove(at: index)
            }
        } label: {
            Image(systemName: "trash")
                .foregroundStyle(.red)
        }
        .buttonStyle(.borderless)
    }
}
