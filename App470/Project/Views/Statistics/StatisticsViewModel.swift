//
//  StatisticsViewModel.swift
//  App470
//
//  Created by IGOR on 13/04/2024.
//

import SwiftUI
import CoreData

final class StatisticsViewModel: ObservableObject {
    
    @AppStorage("car") var car: String = ""
    @Published var addCar = ""
    @Published var isAddCar: Bool = false
    
    @AppStorage("Repair") var Repair: Int = 0
    @AppStorage("Insurance") var Insurance: Int = 0
    @AppStorage("Fuel") var Fuel: Int = 0
    @AppStorage("Other") var Other: Int = 0

    @Published var currencies: [String] = ["EUR/USD", "GBP/USD", "AUD/USD", "USD/CAD", "USD/CHF", "NZD/USD"]
    @Published var currentCurr = "EUR/USD"
    @AppStorage("currentCurrency") var currentCurrency = ""
    
    @Published var categories: [String] = ["Repair", "Insurance", "Fuel", "Other"]
    @Published var currentCat = ""
    @Published var currentCatForShow = "Repair"

    @Published var carName: String = ""
    @Published var hisCategory: String = ""
    @Published var hisName: String = ""
    @Published var hisBudget: String = ""
    
    @Published var isAdd: Bool = false
    @Published var isCurr: Bool = false
    @Published var isDetail: Bool = false
    @Published var isChart: Bool = false
    @Published var isDelete: Bool = false
    @Published var isEdit: Bool = false

    @Published var histories: [HistoryModel] = []
    @Published var selectedHistory: HistoryModel?
    
    func addHistory() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "HistoryModel", into: context) as! HistoryModel
        
        loan.carName = carName
        loan.hisCategory = hisCategory
        loan.hisName = hisName
        loan.hisBudget = hisBudget

        CoreDataStack.shared.saveContext()
    }
    
    func fetchHistories() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<HistoryModel>(entityName: "HistoryModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.histories = result.filter{($0.hisCategory ?? "") == currentCatForShow && ($0.carName ?? "") == car}
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.histories = []
        }
    }

}

