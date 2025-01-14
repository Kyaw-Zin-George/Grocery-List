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
    
    @State private var item : String = ""
    
    @FocusState private var isFocused: Bool
    func addEssentialFood(){
        modelContext.insert(Item(title: "Bakery", isCompleted: false))
        modelContext.insert(Item(title: "Fruits", isCompleted: false))
        modelContext.insert(Item(title: "Meat", isCompleted: false))
        modelContext.insert(Item(title: "Vegetables", isCompleted: false))
    }
    
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
                    //delete action
                        .swipeActions {
                            Button(role: .destructive){
                                withAnimation{
                                    modelContext.delete(item)
                                }
                            }label:{
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    //marking an item done action
                        .swipeActions(edge: .leading) {
                            Button("Done",systemImage: item.isCompleted  == false  ? "checkmark.circle" : "x.circle"){
                                item.isCompleted.toggle()
                            }.tint(item.isCompleted == false ? .green : .accentColor)
                        }
                }
            }
            .navigationTitle("Grocery List")
            //Creating commonest items when doing grocery shopping
            .toolbar{
                if items.isEmpty{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            addEssentialFood()
                        }label:{
                            Label("Essentials", systemImage: "carrot")
                        }
                    }
                }
            }
            //Empty View Creation
            .overlay{
                if items.isEmpty{
                    ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description:Text("Add Some Items on the shopping list"))
                }
            }
            //Add new Grocery to list
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12){
                    //Type new Grocery list
                    TextField("", text: $item)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(.tertiary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .font(.title.weight(.light))
                        .focused($isFocused)
                    
                    //Save Button
                    Button{
                        guard !item.isEmpty else { return }
                        let newItem = Item(title: item, isCompleted: false)
                        modelContext.insert(newItem)
                        item = ""
                        isFocused = false
                    }label: {
                        Text("Save")
                            .font(.title2.weight(.medium))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.extraLarge)
                }
                .padding()
                .background(.bar)
            }
        }
    }
}

#Preview("Sample Data List") {
    let sampleData :[Item] = [
        Item(title: "Bakery", isCompleted: true),
        Item(title: "Fruits", isCompleted: false),
        Item(title: "Meat", isCompleted: .random()),
        Item(title: "Vegetables", isCompleted: .random())
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


