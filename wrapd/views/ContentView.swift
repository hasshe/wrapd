//
//  ContentView.swift
//  wrapd
//
//  Created by Hassan Sheikha on 2026-01-29.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [RowItem] = []
    @FocusState private var focusedItemID: RowItem.ID?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()

                VStack(spacing: 50) {
                    header

                    List {
                        ForEach($items) { $item in
                            RowItemView(
                                item: $item,
                                items: $items,
                                focusedItemID: $focusedItemID
                            )
                        }
                        .onDelete { indexSet in
                            items.remove(atOffsets: indexSet)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                .padding()
            }
            .toolbar {
                addButton
            }
        }
    }
    
    private var hasEmptyRow: Bool {
        items.contains { $0.title.isBlank }
    }
}

// MARK: - Subviews
private extension ContentView {

    var header: some View {
        Text("Wrapd")
            .bold()
            .font(.largeTitle.italic())
            .foregroundStyle(.white)
    }

    var addButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                let newItem = RowItem(title: "", isEditing: true)
                items.append(newItem)
                focusedItemID = newItem.id
            } label: {
                Label("Add Row", systemImage: "plus")
            }
            .disabled(hasEmptyRow)
            .opacity(hasEmptyRow ? 0.5 : 1)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
