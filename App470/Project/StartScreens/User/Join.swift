//
//  Join.swift
//  App470
//
//  Created by IGOR on 11/04/2024.
//

import SwiftUI

struct Join: View {
    
    let telegram: URL

    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("Join")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    UIApplication.shared.open(telegram)
                    
                }, label: {
                    
                    Text("Join")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("join")))
                })
                .padding()
            }
            
            VStack {
                
                HStack {
                    
                    Spacer()
                
                NavigationLink(destination: {
                    
                    Not()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .medium))
                        .padding(5)
                        .background(Circle().fill(Color("prim")))
                })
                .padding()
                    
                }

                
                Spacer()
            }
        }
    }
}

#Preview {
    Join(telegram: URL(string: "h")!)
}
