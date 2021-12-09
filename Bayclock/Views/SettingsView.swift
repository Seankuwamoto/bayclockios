//
//  SettingsView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/27/21.
//

import SwiftUI

struct SettingsView: View {
    // Creates temporary variables for all of the settings
    @State public var MMColor = getColor(name: "Morning Meeting")
    @State public var GAColor = getColor(name: "Group Advisory/1-on-1s")
    @State public var AColor = getColor(name: "A")
    @State public var BColor = getColor(name: "B")
    @State public var CColor = getColor(name: "C")
    @State public var DColor = getColor(name: "D")
    @State public var EColor = getColor(name: "E")
    @State public var FColor = getColor(name: "F")
    @State public var LunchColor = getColor(name: "Lunch")
    @State public var TutorialColor = getColor(name: "Tutorial")
    @State public var MMName = getName(name: "Morning Meeting")
    @State public var GAName = getName(name: "Group Advisory/1-on-1s")
    @State public var AName = getName(name: "A")
    @State public var BName = getName(name: "B")
    @State public var CName = getName(name: "C")
    @State public var DName = getName(name: "D")
    @State public var EName = getName(name: "E")
    @State public var FName = getName(name: "F")
    @State public var LunchName = getName(name: "Lunch")
    @State public var TutorialName = getName(name: "Tutorial")
    @AppStorage("compressedMode") var compressedMode = false
    @AppStorage("hideCompleted") var hideCompleted = false
    

    var body: some View {
        VStack {
            HStack {
                Spacer()
                // Save button.
                Button(action: {
                    saveSettings()
                }) {
                    ZStack {
                        Text("Save")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.trailing, 10)

            }
            Text("Settings")
            List {
                // Toggles for compressed mode and hide completed.
                Toggle(isOn: $compressedMode) {
                    Text("Compressed mode")
                }
                Toggle(isOn: $hideCompleted) {
                    Text("Hide completed")
                }
                // Color pickers for each of the class colors.
                Group {
                    ColorPicker(TextField(
                        "\(MMName)",
                        text: $MMName
                    ), selection: $MMColor, supportsOpacity: false)
                    ColorPicker("Group Advisory/1-on-1s", selection: $GAColor, supportsOpacity: false)
                    ColorPicker("A", selection: $AColor, supportsOpacity: false)
                    ColorPicker("B", selection: $BColor, supportsOpacity: false)
                    ColorPicker("C", selection: $CColor, supportsOpacity: false)
                    ColorPicker("D", selection: $DColor, supportsOpacity: false)
                    ColorPicker("E", selection: $EColor, supportsOpacity: false)
                    ColorPicker("F", selection: $FColor, supportsOpacity: false)
                    ColorPicker("Lunch", selection: $LunchColor, supportsOpacity: false)
                    ColorPicker("Tutorial", selection: $TutorialColor, supportsOpacity: false)
                }
            }
            
            // Button to reset all colors to their defaults
            Button(action: {
                MMColor = Color(red: 131/255.0, green: 89/255.0, blue: 149/255.0)
                GAColor = Color(red: 131/255.0, green: 89/255.0, blue: 149/255.0)
                AColor = Color(red: 190/255.0, green: 213/255.0, blue: 101/255.0)
                BColor = Color(red: 0/255.0, green:144/255.0, blue: 166/255.0)
                CColor = Color(red: 247/255.0, green: 183/255.0, blue: 78/255.0)
                DColor = Color(red: 239/225.0, green: 145/255.0, blue: 62/255.0)
                EColor = Color(red: 8/255.0, green: 158/255.0, blue: 180/255.0)
                FColor = Color(red: 218/255.0, green: 82/255.0, blue: 101/255.0)
                LunchColor = Color(red: 82/255.0, green: 167/255.0, blue: 134/255.0)
                TutorialColor = Color(red: 230/255.0, green: 217/255.0, blue: 67/255.0)
                saveSettings()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                    
                    Text("Reset all colors")
                        .foregroundColor(.blue)
                }
            }
        }
        
    }
    
    // saves the settings to UserDefaults
    func saveSettings() {
        let colorDict: [String: Data?] = [
            "Morning Meeting":        try? colorToData(UIColor(MMColor)),
            "Group Advisory/1-on-1s": try? colorToData(UIColor(GAColor)),
            "A":                      try? colorToData(UIColor(AColor)),
            "B":                      try? colorToData(UIColor(BColor)),
            "C":                      try? colorToData(UIColor(CColor)),
            "D":                      try? colorToData(UIColor(DColor)),
            "E":                      try? colorToData(UIColor(EColor)),
            "F":                      try? colorToData(UIColor(FColor)),
            "Lunch":                  try? colorToData(UIColor(LunchColor)),
            "Tutorial":               try? colorToData(UIColor(TutorialColor))
        ]
        UserDefaults.standard.set(colorDict, forKey: "colorDict")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
