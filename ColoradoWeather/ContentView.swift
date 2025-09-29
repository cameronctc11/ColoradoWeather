//
//  ContentView.swift
//  ColoradoWeather
//
//  Created by McKenzie, Cameron - Student on 9/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var buttonPressed = false
    @State private var temp: Int = Int.random(in: -20...103)
    @State private var message: String = ""
    @State private var sheetColor: Color = .white
    @State private var icon: String = ""
    @State private var cities = ["Colorado Springs", "Greeley", "Loveland"]
    @State private var cityIndex = 0
    
    var selectedCity: String {
        cities[cityIndex]
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.rain")
                .font(.system(size: 100))
                .foregroundStyle(.white)
            
            Text("Colorado Weather")
                .font(.largeTitle)
                .foregroundStyle(.white)
            
            Button("Get Weather") {
                showWeather()
            }
            .buttonStyle(CustomWeatherButton())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.white, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
        .sheet(isPresented: $buttonPressed) {
            NavigationStack {
                ZStack {
                    sheetColor.ignoresSafeArea()
                    
                    VStack {
                        Image(systemName: icon)
                            .font(.system(size: 100))
                        Text("\(temp)°")
                            .font(.system(size: 200, design: .rounded))
                        Text(message)
                            .font(.title2)
                            .padding()
                    }
                }
                .navigationTitle(selectedCity)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Dismiss") {
                            buttonPressed.toggle()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Change City") {
                            changeCity()
                        }
                    }
                }
            }
        }
    }
    
    func showWeather() {
        temp = Int.random(in: -20...103)
        weatherMessage()
        buttonPressed = true
    }
    
    func changeCity() {
        cityIndex = (cityIndex + 1) % cities.count
        showWeather()
    }
    
    func weatherMessage() {
        if temp > 90 {
            message = "It is extremely hot out there!"
            sheetColor = .red
            icon = "thermometer.sun.fill"
        } else if temp > 60 {
            message = "It is pleasant!"
            sheetColor = .yellow
            icon = "sun.min.fill"
        } else if temp > 32 {
            message = "It is a bit chilly!"
            sheetColor = .mint.opacity(0.7)
            icon = "cloud.fill"
        } else if temp > 0 {
            message = "Brrr! It is cold!"
            sheetColor = .blue.opacity(0.7)
            icon = "snowflake"
        } else {
            message = "You should consider moving!"
            sheetColor = .purple.opacity(0.7)
            icon = "cloud.drizzle.fill"
        }
    }
}

struct CustomWeatherButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: 220)
            .background(.orange)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.white)
            .fontWeight(.heavy)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

#Preview {
    ContentView()
}

