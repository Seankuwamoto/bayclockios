//
//  MenuView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/27/21.
//

import SwiftUI
import Vision

struct MenuView: View {
//    guard let cgImage = UIImage(named: "menu")?.cgImage else { return }
//
//    let requestHandler = VNImageRequestHandler(cgImage: CGImage)
//
//    let request = VNRecognizeTextRequest(completion: recognizeTextHandler)
//
//    do {
//        try requestHandler.perform([request])
//    } catch {
//        print("Unable to perform the requests: \(error).")
//    }
//
    var body: some View {
        Image("menu")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
