//
//  DestinationListingView.swift
//  iTour
//
//  Created by Kevin Pfefferle on 10/9/23.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var destinations: [Destination]
    
    init(sort: [SortDescriptor<Destination>], searchString: String, hidePastDestinations: Bool = false) {
        let now = Date.now
        _destinations = Query(filter: #Predicate {
            if hidePastDestinations && $0.date < now {
                return false
            } else if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: sort)
    }
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: [SortDescriptor(\Destination.name)], searchString: "")
}
