//
//  AddTransactionView.swift
//  GetSaving
//
//  Created by Kajetan Patryk Zarzycki on 21/08/2023.
//

import CoreData
import SwiftUI

struct AddTransactionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var transactionType: String = "Income"
    @State var transactionValue: Optional<Decimal> = nil
    @State var selectedAccount: String = ""
    @State var dateChosen = Date()
    @Binding var isAdding: Bool
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name, order: .reverse)],
        animation: .default)
    private var accounts: FetchedResults<Account>
    
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("New Transaction")){
                    Picker("Type", selection: $transactionType) {
                        Text("Income").tag("Income")
                        Text("Expense").tag("Expense")
                    }
                    TextField("Value", value: $transactionValue, format: .number)
                    Picker("Account", selection: $selectedAccount) {
                        ForEach(accounts){
                            a in
                            Text(a.name!).tag(a.name!)
                        }
                    }
                    DatePicker(selection: $dateChosen, in: ...Date(), displayedComponents: .date){
                        Text("Date")
                    }
                    
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: toTransactionView){
                        Label("back to transaction view", systemImage: "arrow.left")
                    }
                }
            }
        }
    }
    
    private func toTransactionView(){
      isAdding = !isAdding
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(isAdding: .constant(true)).environment(\.managedObjectContext, PersistenceController.transactionPreview.container.viewContext)
    }
}
