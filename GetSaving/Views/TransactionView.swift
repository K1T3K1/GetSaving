//
//  TransactionView.swift
//  GetSaving
//
//  Created by Kajetan Patryk Zarzycki on 21/08/2023.
//

import CoreData
import SwiftUI

struct TransactionView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
    predicate: NSPredicate(format: "entity == %@ OR entity == %@", "Income", "Expense")
  )
  private var transactions: FetchedResults<Transaction>
  @State private var plusColor: Color = .blue
  @State private var rowBackgroundColor: Color = .red
  @State private var selectedTransaction: Transaction? = nil
  @Binding var isSideMenuShowing: Bool
  @State var isAdding: Bool = false

  var body: some View {
    NavigationView {
      HStack {
        if isAdding {
          AddTransactionView(isAdding: $isAdding)
            .transition(.move(edge: .trailing))
        } else {
          DisplayTransactionView(isAdding: $isAdding)
            .transition(.move(edge: .leading))
        }
      }.toolbar {
        if !isAdding {
          ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
          }
          ToolbarItem {
            Button(action: { isAdding.toggle() }) {
              Label("Add transaction", systemImage: "plus")
            }.tint(plusColor)
          }
        }
        ToolbarItem(placement: .navigation) {
          Button(action: showSideMenu) {
            Label("Main Tab", systemImage: "line.3.horizontal")
          }
        }
      }
    }
    Text("Select an Item")
  }
  private func showSideMenu() {
    isSideMenuShowing = !isSideMenuShowing
  }

  private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
  }()

  struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
      TransactionView(isSideMenuShowing: .constant(false)).environment(
        \.managedObjectContext, PersistenceController.transactionPreview.container.viewContext)
    }
  }
}

struct DisplayTransactionView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
    predicate: NSPredicate(format: "entity == %@ OR entity == %@", "Income", "Expense")
  )
  private var transactions: FetchedResults<Transaction>
  @State private var plusColor: Color = .blue
  @State private var rowBackgroundColor: Color = .red
  @State private var selectedTransaction: Transaction? = nil
  @Binding var isAdding: Bool

  var body: some View {
    NavigationView {
      List {
        ForEach(transactions) {
          item in
          VStack {
            HStack {
              if item is Expense {
                Text("\(String(describing: type(of: item))) \(item.name!)")
              }
              if item is Income {
                Text("\(String(describing: type(of: item))) \(item.name!)")
              }
            }
          }
          .listRowBackground(
            LinearGradient(
              colors: [(item is Expense ? .red : .green), .white], startPoint: .leading,
              endPoint: .trailing
            )
            .opacity(1)
          )
          .onTapGesture {
            if selectedTransaction == item {
              selectedTransaction = nil
            } else {
              selectedTransaction = item
            }
          }

          if selectedTransaction == item {
            TransactionDetailView(transaction: selectedTransaction!).transition(.slide)
          }
        }
      }
    }
  }
}

struct TransactionDetailView: View {
  let transaction: Transaction

  var body: some View {
    VStack {
      Text(
        "Name: \(transaction.name!)\n"
          + "Value: \(transaction.value!.doubleValue)\n"
          + "Account: \(transaction.account!.name!)")
    }
  }
}
