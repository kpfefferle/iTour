//
//  ContentView.swift
//  iTour
//
//  Created by Kevin Pfefferle on 10/9/23.
//

import SwiftUI
import SwiftData

let DEFAULT_SORT_ORDER = SortDescriptor(\Destination.name)

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
        
    @State private var path = [Destination]()
    @State private var hidePast = false
    @State private var searchText = ""
    @State private var sortOrder = DEFAULT_SORT_ORDER
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: [sortOrder, DEFAULT_SORT_ORDER], searchString: searchText, hidePastDestinations: hidePast)
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .navigationTitle("iTour")
                .searchable(text: $searchText)
                .toolbar {
                    Menu("Visibility", systemImage: "eye") {
                        Picker("Visibility", selection: $hidePast) {
                            Text("Show Past Arrivals")
                                .tag(false)
                            Text("Hide Past Arrivals")
                                .tag(true)
                        }
                        .pickerStyle(.inline)
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                }
        }
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
