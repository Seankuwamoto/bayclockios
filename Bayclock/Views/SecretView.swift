//
//  SecretView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 2/3/22.
//

import SwiftUI
import CryptoKit

// No explanation comments on this file, it's secret!
struct SecretView: View {
    @State private var input: String = ""
    @State private var displayMessage: String = "enterPassword"
    @AppStorage("secretSettingsActive") var secretSettingsActive = false
    var body: some View {
        
        if (displayMessage == "enterPassword") {
            HStack {
                Text("Enter Password:")
                    .padding(.leading, 50)
                TextField(
                    "",
                    text: $input
                )
                    .textFieldStyle(.roundedBorder)
                    .border(.secondary)
                    .padding(.trailing, 50)
                    .onSubmit {
                        let hashed = SHA256.hash(data: Data(input.utf8))
                        let hashedString = hashed.compactMap { String(format: "%02x", $0) }.joined()
                        if (hashedString == "615e82366bd43f0b946d175d40c1890c56f6064bf980c9fa4ce7be673aab4da8") {
                            if (UserDefaults.standard.bool(forKey: "secretSettingsActive") == true) {
                                UserDefaults.standard.set(false, forKey: "secretSettingsActive")
                            }
                            else {
                                UserDefaults.standard.set(true, forKey: "secretSettingsActive")
                            }
                            
                            displayMessage = "s"
                        }
                        // Hint: try putting in Baybrave as the password
                        else if (hashedString == "657febde97a870951eaca9fdb5fb405dc29243e97f55535f09bb9c3a13bf4b90") {
                            if let url = URL(string: decrypt(message: "kwwsv=22|rxwx1eh2gTz7z<Zj[fT")) {
                                   UIApplication.shared.open(url)
                            }
                        }
                        else {
                            displayMessage = "fail"
                        }
                    }
            }
        }
        else if (displayMessage == "s") {
            if (secretSettingsActive) {
                Text(decrypt(message: "Vhfuhw#vhwwlqjv#qrz#ylvdeoh"))
                    .onDisappear {
                        input = ""
                        displayMessage = "enterPassword"
                    }
            }
            else {
                Text(decrypt(message: "Vhfuhw#vhwwlqjv#qr#orqjhu#ylvdeoh"))
                    .onDisappear {
                        input = ""
                        displayMessage = "enterPassword"
                    }
            }
        }
        else if (displayMessage == "fail") {
            Text("Incorrect password")
                .onDisappear {
                    input = ""
                    displayMessage = "enterPassword"
                }
        }
        
        
    }
}

func decrypt(message: String) -> String {
    let unicodeScalars = message.unicodeScalars.map { UnicodeScalar(Int($0.value) - 3)! }
    return String(String.UnicodeScalarView(unicodeScalars))
}

struct SecretView_Previews: PreviewProvider {
    static var previews: some View {
        SecretView()
    }
}
