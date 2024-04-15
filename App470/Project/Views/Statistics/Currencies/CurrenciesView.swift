//
//  CurrenciesView.swift
//  App470
//
//  Created by IGOR on 13/04/2024.
//

import SwiftUI

struct CurrenciesView: View {

    @StateObject var viewModel: StatisticsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Currency change")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 16, weight: .medium))

                            }
                        })
                        
                        Spacer()
                    }
                }
                .padding()

                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                        
                        ForEach(viewModel.currencies, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCurr = index
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isChart = true
                                }
                                
                            }, label: {
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("$\(String(format: "%.f", Double(.random(in: 0...9))))\(String(format: "%.f", Double(.random(in: 0...2)))).\(String(format: "%.f", Double(.random(in: 0...9))))\(String(format: "%.f", Double(.random(in: 0...9))))")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .semibold))
                                    
                                    Text("+$\(String(format: "%.f", Double(.random(in: 0...2)))).\(String(format: "%.f", Double(.random(in: 0...9))))\(String(format: "%.f", Double(.random(in: 0...9))))")
                                        .foregroundColor(.green)
                                        .font(.system(size: 13, weight: .semibold))
                                    
                                    Spacer()
                                    
                                    Text(index)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .semibold))
                                }
                            })
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 130)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color.white))
                        }
                    })
                }
                .padding()
            }
        }
                .sheet(isPresented: $viewModel.isChart, content: {
        
                    ChartView(viewModel: viewModel)
                })
    }
}

#Preview {
    CurrenciesView(viewModel: StatisticsViewModel())
}
