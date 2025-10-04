//
//  OnboardingView.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            Tab {
                VStack {
                    Image(systemName: "party.popper")
                        .font(.largeTitle)
                        .padding()
                    Text("Welcome to Coinvert!")
                        .font(.headline)
                    Text("The simple currency conversion app for all your currency converting needs.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .padding(5)
                    Text("Swipe left to continue!")
                        .font(.caption)
                }
            }
            Tab {
                VStack {
                    Image("OnboardingImage1")
                        .frame(width: 300)
                        .scaledToFit()
                        .padding()
                    Text("Welcome to Coinvert!")
                        .font(.headline)
                    Text("The simple currency conversion app for all your currency converting needs.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .padding(5)
                    Text("Swipe left to continue!")
                        .font(.caption)
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    OnboardingView()
}
