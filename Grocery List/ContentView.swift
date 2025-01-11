//
//  ContentView.swift
//  Grocery List
//
//  Created by Kyaw Thant Zin(George) on 1/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items : [Item]
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
            }
            .navigationTitle("Grocery List")
            .overlay{
                if items.isEmpty{
                    ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description:Text("Add Some Items on the shopping list"))
                }
            }
        }
    }
}

#Preview {
    ContentView()
    //in memory is the modifier that stores grocery items list temporarily
        .modelContainer(for:Item.self,inMemory:true)
}
