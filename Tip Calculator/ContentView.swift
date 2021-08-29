//
//  ContentView.swift
//  Tip Calculator
//
//  Created by John Kouris on 8/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @FocusState var isInputActive: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var subTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        return orderAmount
    }
    
    var totalAmountWithTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        return orderAmount / 100 * tipSelection
    }
    
    var tipValuePerPerson: Double {
        tipValue / Double(numberOfPeople)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let amountPerPerson = totalAmountWithTip / peopleCount
        
        return amountPerPerson
    }
    
    var subTotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let orderAmount = Double(checkAmount) ?? 0
        
        return Double(orderAmount / peopleCount)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                CardView(cardLabelText: "PER PERSON", totalAmount: totalPerPerson, subtotalAmount: subTotalPerPerson, tipAmount: tipValuePerPerson)
                    .frame(width: geometry.size.width * 0.9, height: 100)
                CardView(cardLabelText: "TOTAL", totalAmount: totalAmountWithTip, subtotalAmount: subTotal, tipAmount: tipValue)
                    .frame(width: geometry.size.width * 0.9, height: 100)
                
                Picker("Tip Percentage", selection: $tipPercentage) {
                    ForEach(0..<tipPercentages.count) {
                        Text("\(self.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    Text("BILL AMOUNT")
                        .foregroundColor(.indigo)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                
                HStack {
                    Text("$")
                        .foregroundColor(.primary)
                        .font(.system(size: 60, weight: .black, design: .rounded))
                    
                    Spacer()
                    
                    TextField("Amount", text: $checkAmount)
                        .foregroundColor(.primary)
                        .font(.system(size: 60, weight: .black, design: .rounded))
                        .keyboardType(.decimalPad)
                        .focused($isInputActive)
                    
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isInputActive = false
                                }
                            }
                        }
                }
                
                HStack {
                    Text("SPLIT")
                        .foregroundColor(.indigo)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                
                GuestCountView(guestCount: $numberOfPeople)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
