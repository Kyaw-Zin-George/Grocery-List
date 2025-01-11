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
                        .font(.title.weight(.light))
                        .padding(.vertical,2)
                        .foregroundStyle(item.isCompleted == false ? Color.primary: Color.red)
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
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

#Preview("Sample Data List") {
    let sampleData :[Item] = [
        Item(title: "Bakery", isCompleted: true),
        Item(title: "Fruits", isCompleted: false),
        Item(title: "Meat", isCompleted: .random())
    ]
    let container = try! ModelContainer(for:Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    for item in sampleData{
        container.mainContext.insert(item)
    }
    return ContentView()
        .modelContainer(container)
}
#Preview("Empty List") {
    ContentView()
    //in memory is the modifier that stores grocery items list temporarily
        .modelContainer(for:Item.self,inMemory:true)
}


