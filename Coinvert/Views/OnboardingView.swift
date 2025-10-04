//
//  OnboardingView.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboardingShowing") private var onboardingShowing = true
    @Environment(\.presentationMode) var presentationMode // lets us dismiss the sheet
    
    @State private var currencyList: [Currency] = []
    
    @State private var loadingCurrencies = false
    
    @AppStorage("defaultBaseCurrency") private var defaultBaseCurrency = ""
    @AppStorage("defaultWantedCurrency") private var defaultWantedCurrency = ""
    
    func loadCurrencies() { // fetch list of currencies and give it to a var
        withAnimation { // fancy animation maybe?
            loadingCurrencies = true // show loading banner
        }
        print("loading currencies")
        
        currencyList = [] // clear out any existing currencies
        
        getCurrencyList { list in
            DispatchQueue.main.async {
                self.currencyList = list
                if self.defaultBaseCurrency.isEmpty, let first = list.first {
                    self.defaultBaseCurrency = first.id // pick first
                }
                
                if self.defaultWantedCurrency.isEmpty {
                    if list.count > 1 { // check if more than one currency
                        self.defaultWantedCurrency = list[1].id // pick the second
                    }
                }
                
                // this is here cos the async shit finishes after
                // the loadCurrencies() func does
                withAnimation {
                    loadingCurrencies = false // hide the loading banner
                }
                print("finished loading currencies")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
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
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(maxWidth: 300, maxHeight: 300)
                            .padding()
                        Text("Converting Currencies")
                            .font(.headline)
                        Text("Pick from any of over 200 currencies to use for conversion, including crypto!")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .padding(5)
                    }
                }
                Tab {
                    VStack {
                        Image("OnboardingImage2")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(maxWidth: 300, maxHeight: 300)
                            .padding()
                        Text("Exchange Rates")
                            .font(.headline)
                        Text("Instantly see the value of a selected currency!")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .padding(5)
                    }
                }
                Tab {
                    VStack {
                        Image("OnboardingImage3")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(maxWidth: 300, maxHeight: 300)
                            .padding()
                        Text("Settings")
                            .font(.headline)
                        Text("Configure Coinvert to your liking, including setting default currencies and changing the accent colour!")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .padding(5)
                    }
                }
                Tab {
                    VStack {
                        Image(systemName: "checkmark.circle")
                            .font(.largeTitle)
                            .padding()
                            .symbolEffect(.pulse)
                            .foregroundStyle(.green)
                        Text("All done!")
                            .font(.headline)
                        Text("Before you leave, however, you may want to change your default currencies.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .padding(5)
                        Form {
                            if loadingCurrencies {
                                Section {
                                    Text("Loading currency list...")
                                }
                            }
                            
                            Section {
                                Picker("Base", selection: $defaultBaseCurrency) {
                                    ForEach(currencyList) { currency in
                                        Text(currency.name).tag(currency.id)
                                    }
                                }
                                .pickerStyle(.menu)
                                
                                Picker("Convert To", selection: $defaultWantedCurrency) {
                                    ForEach(currencyList) { currency in
                                        Text(currency.name).tag(currency.id)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                        .formStyle(.columns)
                        .cornerRadius(20)
                        .padding()
                        Button {
                            print("closing onboarding")
                            self.onboardingShowing = false
                        } label: {
                            Label("Finish", systemImage: "checkmark")
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .onAppear {
                loadCurrencies()
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("closing sheet")
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }
            }
        }
    }
    
}

#Preview {
    OnboardingView()
}
