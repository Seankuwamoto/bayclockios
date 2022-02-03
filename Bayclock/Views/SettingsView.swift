//
//  SettingsView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/27/21.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

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
                Text("Settings")
                    .padding(.leading, 40)
                Spacer()
                // Save button.
                Button(action: {
                    saveSettings()
                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 10)

            }
            .padding(.top, 10)
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
                    HStack {
                        TextField("Morning Meeting",text: $MMName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $MMColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("Group Advisory/1-on-1s",text: $GAName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $GAColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("A",text: $AName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $AColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("B",text: $BName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $BColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("C",text: $CName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $CColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("D",text: $DName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $DColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("E",text: $EName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $EColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("F",text: $FName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $FColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("Lunch",text: $LunchName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $LunchColor, supportsOpacity: false)
                            .labelsHidden()
                    }
                    HStack {
                        TextField("Tutorial",text: $TutorialName)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                        ColorPicker("", selection: $TutorialColor, supportsOpacity: false)
                            .labelsHidden()     
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
        let blockNames: [String: String] = [
            "Morning Meeting":          MMName,
            "Group Advisory/1-on-1s":   GAName,
            "A":                        AName,
            "B":                        BName,
            "C":                        CName,
            "D":                        DName,
            "E":                        EName,
            "F":                        FName,
        "Lunch":                        LunchName,
        "Tutorial":                     TutorialName
        ]
        UserDefaults.standard.set(colorDict, forKey: "colorDict")
        UserDefaults.standard.set(blockNames, forKey: "blockNames")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
