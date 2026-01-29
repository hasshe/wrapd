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
                        if !hasEmptyRow {
                            Button {
                                let newItem = RowItem(title: "", isEditing: true)
                                items.append(newItem)
                                focusedItemID = newItem.id
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Row")
                                        .bold()
                                }
                                .foregroundStyle(.green)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                .padding()
            }
        }
    }
    
    private var hasEmptyRow: Bool {
        items.contains { $0.title.isBlank }
    }
}

// MARK: - Subviews
private extension ContentView {

    /* Custom image, comment out for now
    var header: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
     */
    var header: some View {
        VStack(spacing: 8) { // Adjust spacing between icon and text
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 90))
                .foregroundStyle(.green)
            
            Text("Forza Milano")
                .font(.headline)
                .foregroundStyle(.white) // Or .secondary for a more subtle look
        }
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
