//
//  ContentView.swift
//  FruitApp
//
//  Created by Kevin Sun on 7/22/24.
//

import SwiftUI

struct ContentView: View {
    
    // State variables to manage the captured image and the presentation of the custom camera view
    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    
    var body: some View {
        ZStack {
            // If there is a captured image, display it, otherwise show the system background color
            if let capturedImage = capturedImage {
                Image(uiImage: capturedImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Text("Good Fruit")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                )
                .padding()
                .transition(.opacity)
            } else {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                Text("Click the Camera Button to Begin")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                    .padding()
                    .transition(.opacity)
            }
            
            VStack {
                Spacer()
                // Button to present the custom camera view
                Button(action: {
                    withAnimation {
                        isCustomCameraViewPresented.toggle()
                    }
                }, label: {
                    Image(systemName: "camera.fill")
                        .font(.largeTitle)
                        .padding()
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                        )
                        .foregroundColor(.white)
                })
                .padding(.bottom)
                // Present the custom camera view as a sheet when the button is tapped
                .sheet(isPresented: $isCustomCameraViewPresented, content: {
                    CustomCameraView(capturedImage: $capturedImage)
                })
            }
        }
    }

}

#Preview {
    ContentView()
}
