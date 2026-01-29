//
//  ContentView.swift
//  wrapd
//
//  Created by Hassan Sheikha on 2026-01-29.
//

import SwiftUI

struct RowItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isChecked: Bool = false
    var isEditing: Bool = false
}

struct ContentView: View {
    @State private var items: [RowItem] = []
    @State private var counter: Int = 0
    @FocusState private var focusedItemID: RowItem.ID?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 50) {
                    Text("Wrapd")
                        .bold()
                        .font(.largeTitle.italic())

                    List {
                        ForEach($items) { $item in
                            HStack {
                                Button {
                                    item.isChecked.toggle()
                                } label: {
                                    Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(item.isChecked ? .green : .secondary)
                                        .imageScale(.large)
                                }
                                .buttonStyle(.plain)

                                if item.isEditing {
                                    TextField("New item", text: $item.title)
                                        .textFieldStyle(.roundedBorder)
                                        .foregroundStyle(.primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .focused($focusedItemID, equals: item.id)
                                        .onSubmit {
                                            item.isEditing = false
                                        }
                                        .onChange(of: focusedItemID) { _, newValue in
                                            if newValue != item.id {
                                                item.isEditing = false
                                            }
                                        }
                                } else {
                                    Text(item.title)
                                        .foregroundStyle(.primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .onTapGesture(count: 2) {
                                            item.isEditing = true
                                            focusedItemID = item.id
                                        }
                                }

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
                            .onChange(of: focusedItemID) { _, newValue in
                                item.isEditing = (newValue == item.id)
                            }
                        }
                        .onDelete { indexSet in
                            items.remove(atOffsets: indexSet)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                .padding()
                .foregroundStyle(.white)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        let new = RowItem(title: "", isChecked: false, isEditing: true)
                        items.append(new)
                        focusedItemID = new.id
                    } label: {
                        Label("Add Row", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
