//
//  ContentView.swift
//  Car Customiser
//
//  Created by Ssnehnil Ghosh on 19/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0
    
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var enginePackage = false
    @State private var weightPackage = false
    @State private var remainingFunds = 1000
    @State private var remainingTime = 30
    
    var exhaustPackageOn: Bool {
        return exhaustPackage ? true : remainingFunds >= 500 && remainingTime > 0 ? true : false
    }
    
    var tiresPackageOn: Bool {
        return tiresPackage ? true : remainingFunds >= 750 && remainingTime > 0 ? true : false
    }
    
    var enginePackageOn: Bool {
        return enginePackage ? true : remainingFunds >= 1000 && remainingTime > 0 ? true : false
    }
    
    var weightPackageOn: Bool {
        return weightPackage ? true : remainingFunds >= 500 && remainingTime > 0 ? true : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get : { self.exhaustPackage },
            set : { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get : { self.tiresPackage },
            set : { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 750
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 750
                }
            }
        )
        
        let enginePackageBinding = Binding<Bool> (
            get : { self.enginePackage },
            set : { newValue in
                self.enginePackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 20
                    remainingFunds -= 1000
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 20
                    remainingFunds += 1000
                }
            }
        )
        
        let weightPackageBinding = Binding<Bool> (
            get : { self.weightPackage },
            set : { newValue in
                self.weightPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].acceleration += 0.5
                    remainingFunds += 500
                }
            }
        )
        VStack {
            Text("\(remainingTime)")
                .onReceive(timer) { _ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    }
                }
                .foregroundColor(.red)
            Form {
                VStack (alignment: .leading, spacing: 20){
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                    if remainingTime > 0 {
                        Button("Next Car", action: {
                            exhaustPackage = false
                            tiresPackage = false
                            enginePackage = false
                            weightPackage = false
                            remainingFunds = 1000
                            selectedCar += 1
                            if selectedCar >= starterCars.cars.count {
                                selectedCar = 0
                            }
                        })
                    }
                }
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding).disabled(!exhaustPackageOn)
                    Toggle("Tires Package (Cost: 750)", isOn: tiresPackageBinding).disabled(!tiresPackageOn)
                    Toggle("Engine Package (Cost: 1000)", isOn: enginePackageBinding).disabled(!enginePackageOn)
                    Toggle("Weight Package (Cost: 500)", isOn: weightPackageBinding).disabled(!weightPackageOn)
                }
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.red)
                .baselineOffset(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
