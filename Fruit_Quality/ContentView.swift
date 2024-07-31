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
    @State private var isDisplayMode = false
    
    var body: some View {
        
        VStack {
            if isDisplayMode, let capturedImage = capturedImage {
                ZStack {
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
                    VStack {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isDisplayMode = false
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .font(.largeTitle)
                                    .padding()
                                    .foregroundColor(.white)
                            }
                            .padding()
                            Spacer()
                        }
                        .background(Color.black)
                        Spacer()
                    }
                }
                ZStack {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "house")
                            .onTapGesture {
                                withAnimation {
                                    isDisplayMode = false
                                }
                            }
                        Spacer()
                        Image(systemName: "camera.fill")
                            .onTapGesture {
                                withAnimation {
                                    isCustomCameraViewPresented.toggle()
                                }
                            }
                        Spacer()
                    }.padding(.top).font(.largeTitle)
                }
            }
            else {
                VStack {
                    ZStack {
                        Color(.black)
                            .ignoresSafeArea()
                        VStack {
                            VStack {
                                Text("Fruity App")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom)
                                Text("We'll get you good fruits")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                            VStack {
                                Spacer()
                                Text("HOW TO USE?")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 25.0)
                                Text("Take a picture")
                                    .foregroundColor(Color.white)
                                    .padding(.bottom)
                                Text("AND...")
                                    .foregroundColor(Color.white)
                                    .padding(.bottom)
                                Text("We'll tell you if the fruit is good")
                                    .foregroundColor(Color.white)
                                    .padding(.bottom)
                                Spacer()
                                Spacer()
                                
                            }
                            Spacer()
                        }
                    }
                    ZStack {
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: "house.fill")
                                .onTapGesture {
                                    withAnimation {
                                        isDisplayMode = false
                                    }
                                }
                            Spacer()
                            Image(systemName: "camera")
                                .onTapGesture {
                                    withAnimation {
                                        isCustomCameraViewPresented.toggle()
                                    }
                                }
                            Spacer()
                        }.padding(.top).font(.title)
                    }
                }
            }
        }
        .sheet(isPresented: $isCustomCameraViewPresented, onDismiss: {
            if capturedImage != nil {
                isDisplayMode = true
            }
        }) {
            CustomCameraView(capturedImage: $capturedImage)
        }
    }
}

#Preview {
    ContentView()
}
