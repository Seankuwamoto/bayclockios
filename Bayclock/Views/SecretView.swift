//
//  SecretView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 2/3/22.
//

import SwiftUI

struct SecretView: View {
    @State private var input: String = ""
    
    var body: some View {
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
                
        }
    }
}

struct SecretView_Previews: PreviewProvider {
    static var previews: some View {
        SecretView()
    }
}
