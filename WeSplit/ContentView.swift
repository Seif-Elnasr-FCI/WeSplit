//
//  ContentView.swift
//  WeSplit
//
//  Created by seif elshahet on 28/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipsPercentage = [10, 15, 20, 25, 0]
    
    var totalPerPeron: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        
                        ForEach(2..<16) {
                            Text("\($0) People")
                        }
                    }
                    
                }
                
                Section("How much you want to tip?") {
                    Picker("Tips Percentges", selection: $tipPercentage) {
                        ForEach(tipsPercentage, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount per person") {
                    Text(totalPerPeron, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
