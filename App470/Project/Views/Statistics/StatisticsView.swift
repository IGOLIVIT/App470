//
//  StatisticsView.swift
//  App470
//
//  Created by IGOR on 13/04/2024.
//

import SwiftUI

struct StatisticsView: View {
    
    @StateObject var viewModel = StatisticsViewModel()
        
    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAddCar = true
                    }
                    
                }, label: {
                    
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                
                VStack(spacing: 6) {
                    
                    Text(viewModel.car)
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))
                        .padding(.bottom, 8)
                    
                    Text("$\(viewModel.Repair + viewModel.Fuel + viewModel.Insurance + viewModel.Other)")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                    
                    Text("Your expenses")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .medium))
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isCurr = true
                            }
                            
                        }, label: {
                            
                            Text(viewModel.currentCurr)
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                                .padding(12)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                            
                        })

                        ForEach(viewModel.categories, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCatForShow = index
                                
                                viewModel.fetchHistories()
                                
                            }, label: {
                                
                                    Text(index)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(12)
                                        .padding(.horizontal)
                                        .background(RoundedRectangle(cornerRadius: 20).fill(viewModel.currentCatForShow == index ? Color("prim") : .white))
                                
                            })
                        }
                    }
                }
                .frame(height: 60)
                .padding(.vertical)
                
                HStack {
                    
                    Text("History")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                    })
                }
                .padding(.bottom)
                
                if viewModel.histories.isEmpty {
                    
                    VStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Text("There are no records. Add a car")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                        })
                        
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(spacing: 15) {
                        
                        ForEach(viewModel.histories, id: \.self) { index in
                            
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    Text(index.hisName ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .semibold))
                                    
                                    Text(index.hisCategory ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 13, weight: .regular))
                                }
                                
                                Spacer()
                                
                                Text("$\(index.hisBudget ?? "")")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .regular))
                                
                                Image(systemName: "arrow.up.right")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 18, weight: .semibold))
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                }
            }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isCurr, content: {
            
            CurrenciesView(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchHistories()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAdd ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd  = false
                        }
                    }
                
                VStack {
                    
                    ZStack {
                        
                        HStack {
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAdd  = false
                                }
                                
                            }, label: {
                                
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 11, weight: .regular))
                                    .padding(5)
                                    .background(Circle().fill(.white.opacity(0.2)))
                            })
                            
                            Spacer()
                            
                        }
                        
                        Text("Create an entry")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                            .padding()
                        
                    }
                    
                    Menu(content: {
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCat = index
                                
                            }, label: {
                                
                                Text(index)
                            })
                        }

                    }, label: {
                        
                        HStack {
                            
                            viewModel.currentCat.isEmpty ? Text("Category").foregroundColor(.gray).font(.system(size: 14, weight: .regular))
                            : Text(viewModel.currentCat).foregroundColor(.black).font(.system(size: 14, weight: .regular))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.gray)
                                .font(.system(size: 18, weight: .medium))
                        }
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))

                    ZStack(alignment: .leading, content: {
                        
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.hisName.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.hisName)
                            .foregroundColor(Color.black)
                            .font(.system(size: 14, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Budget")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.hisBudget.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.hisBudget)
                            .foregroundColor(Color.black)
                            .font(.system(size: 14, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))

                    Button(action: {
                        
                        if viewModel.currentCat == "Repair" {
                            
                            viewModel.Repair += Int(viewModel.hisBudget) ?? 0
                        }
                        
                        if viewModel.currentCat == "Insurance" {
                            
                            viewModel.Insurance += Int(viewModel.hisBudget) ?? 0
                        }
                        
                        if viewModel.currentCat == "Fuel" {
                            
                            viewModel.Fuel += Int(viewModel.hisBudget) ?? 0
                        }
                        
                        if viewModel.currentCat == "Other" {
                            
                            viewModel.Other += Int(viewModel.hisBudget) ?? 0
                        }
                                          
                        viewModel.carName = viewModel.car
                        viewModel.hisCategory = viewModel.currentCat
                        
                        viewModel.addHistory()
                        
                        viewModel.hisName = ""
                        viewModel.hisBudget = ""
                        viewModel.currentCat = ""
                        
                        viewModel.fetchHistories()
    
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd  = false
                        }
                        
                    }, label: {
                        
                        Text("Create")
                            .foregroundColor(Color.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color("prim")))
                        
                    })
                    .disabled(viewModel.currentCat.isEmpty || viewModel.hisName.isEmpty || viewModel.hisBudget.isEmpty ? true : false)
                    .opacity(viewModel.currentCat.isEmpty || viewModel.hisName.isEmpty || viewModel.hisBudget.isEmpty ? 0.5 : 1)
                    .padding(.top, 120)
                    .padding(.bottom, 30)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).ignoresSafeArea())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.isAdd  ? 0 : UIScreen.main.bounds.height)
            }
        )
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddCar ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCar = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCar = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("To create")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Car brand and Model")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .regular))
                            .opacity(viewModel.addCar.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.addCar)
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                    
                    Button(action: {
        
                        viewModel.car = viewModel.addCar
                        
                        viewModel.Fuel = 0
                        viewModel.Insurance = 0
                        viewModel.Other = 0
                        viewModel.Repair = 0
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCar = false

                        }
                        
                        viewModel.addCar = ""
                                
                    }, label: {
                        
                        Text("Create")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color("prim")))
                            .disabled(viewModel.addCar.isEmpty ? true : false)
                            .opacity(viewModel.addCar.isEmpty ? 0.5 : 1)
                        
                    })
                    .padding(.vertical, 25)

                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.isAddCar ? 0 : UIScreen.main.bounds.height)
                .ignoresSafeArea()
            }
        )
    }
}

#Preview {
    StatisticsView()
}
