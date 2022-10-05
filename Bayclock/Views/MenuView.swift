//
//  MenuView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/27/21.
//

import SwiftUI
import Vision


func readMenu() {
    // Get the CGImage on which to perform requests.
    guard let uiImage = UIImage(named: "menu") else { return }
    // The shortest side
    let sideLength = min(
        uiImage.size.width,
        uiImage.size.height
    )

    // Determines the x,y coordinate of a centered
    // sideLength by sideLength square
    let sourceSize = uiImage.size
    let xOffset = (sourceSize.width - sideLength) / 2.0
    let yOffset = (sourceSize.height - sideLength) / 2.0

    // The cropRect is the rect of the image to keep,
    // in this case centered
    let cropRect = CGRect(
        x: xOffset,
        y: yOffset,
        width: sideLength,
        height: sideLength
    ).integral

    // Center crop the image
    let sourceCGImage = uiImage.cgImage!
    let croppedCGImage = sourceCGImage.cropping(
        to: cropRect
    )!
    let cgImage = croppedCGImage
    // Create a new image-request handler.
    let requestHandler = VNImageRequestHandler(cgImage: cgImage)

    // Create a new request to recognize text.
    let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
    request.recognitionLevel = .accurate

    do {
        // Perform the text-recognition request.
        try requestHandler.perform([request])
    } catch {
        print("Unable to perform the requests: \(error).")
    }
}
// Just a picture of the menu.
struct MenuView: View {
//
    var body: some View {
        ZoomableScrollView {
            Image("menu")
                .resizable()
                .scaledToFit()
        }
//        .onAppear {
//            readMenu()
//        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

func recognizeTextHandler(request: VNRequest, error: Error?) {
//    guard let observations =
//            request.results as? [VNRecognizedTextObservation] else {
//        return
//    }
//    let recognizedStrings = observations.compactMap { observation in
//        // Return the string of the top VNRecognizedText instance.
//        return observation.topCandidates(1).first?.string
//    }
    
    // Process the recognized strings.
    // processResults(recognizedStrings)
}
