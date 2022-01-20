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
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get : { self.exhaustPackage },
            set : { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get : { self.tiresPackage },
            set : { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                }
            }
        )
        
        let enginePackageBinding = Binding<Bool> (
            get : { self.enginePackage },
            set : { newValue in
                self.enginePackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 20
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 20
                }
            }
        )
        
        let weightPackageBinding = Binding<Bool> (
            get : { self.weightPackage },
            set : { newValue in
                self.weightPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.5
                } else {
                    starterCars.cars[selectedCar].acceleration += 0.5
                }
            }
        )
        
        Form {
            VStack (alignment: .leading, spacing: 20){
                Text("\(starterCars.cars[selectedCar].displayStats())")
                Button("Next Car", action: {
                    exhaustPackage = false
                    tiresPackage = false
                    enginePackage = false
                    weightPackage = false
                    selectedCar += 1
                    if selectedCar >= starterCars.cars.count {
                        selectedCar = 0
                    }
                })
            }
            Section {
                Toggle("Exhaust Package", isOn: exhaustPackageBinding)
                Toggle("Tires Package", isOn: tiresPackageBinding)
                Toggle("Engine Package", isOn: enginePackageBinding)
                Toggle("Weight Package", isOn: weightPackageBinding)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
