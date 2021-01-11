//
//  MainView.swift
//  Slots_swiftUi
//
//  Created by Sergey on 26.12.2020.
//

import SwiftUI

struct MainView: View {
    //MARK:- Properties
    var items = ["gfx-strawberry", "gfx-seven", "gfx-grape", "gfx-coin", "gfx-cherry", "gfx-bell"]
    @State private var slots = [0, 1, 2]
    @State private var bet = 10
    @State private var score: Int = UserDefaults.standard.integer(forKey: "score")
    @State private var coins = 100
    @State private var isBet10Active = true
    @State private var isBet20Active = false
    @State private var isShowingModal = false
    @State private var isSlotsAnimated = false
    
    //MARK:- Fucntions
    func spinSlots() {
        slots = slots.map({_ in
            Int.random(in: 0...items.count - 1)
        })
        playSound(name: "spin", format: "mp3")
    }
    
    func bet10Activate() {
        bet = 10
        isBet10Active = true
        isBet20Active = false
        playSound(name: "casino-chips", format: "mp3")
    }
    
    func bet20Activate() {
        bet = 20
        isBet10Active = false
        isBet20Active = true
        playSound(name: "casino-chips", format: "mp3")
    }
    
    func winnersChecking() {
        // isSlotsAnimated = false
        if slots[0] == slots[1] && slots[0] == slots[2] && slots[1] == slots[2] {
            newCoinsBalance()
            newScoresBalance()
            
        } else {
            
        }
    }
    
    func newCoinsBalance() {
        coins += bet * 10
        playSound(name: "win", format: "mp3")
    }
    
    func newScoresBalance() {
        if coins > score {
            playSound(name: "high-score", format: "mp3")
            score = coins
            UserDefaults.standard.set(score, forKey: "score")
        }
    }
    
    func resetGame() {
        coins = 100
        UserDefaults.standard.set(0, forKey: "score")
        bet10Activate()
        playSound(name: "chimeup", format: "mp3")
    }
    
    //MARK:-Body
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                //MARK:- HEADER
                Image("gfx-slot-machine")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 260, maxHeight: 140, alignment: .center)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 2, x: 0.0, y: 6)
                //MARK: - Scores
                HStack {
                    HStack {
                        Text("YOUR\nCOINS")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                            .multilineTextAlignment(.trailing)
                        
                        
                        Text("\(coins)")
                            .textExtension()
                            .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                    }//HStack
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                    .frame(width: 150)
                    
                    .background(
                        Capsule()
                            .fill(Color("ColorPurple"))
                            .opacity(0.4)
                    )
                    Spacer()
                    HStack {
                        
                        Text("\(score)")
                            .textExtension()
                            .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                        
                        Text("HIGHT\nSCORE")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                            .multilineTextAlignment(.leading)
                    }//HStack
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                    .frame(width: 150)
                    
                    .background(
                        Capsule()
                            .fill(Color("ColorPurple"))
                            .opacity(0.4)
                    )
                }//HStack
                
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                Spacer()
                //MARK:- SLOTS
                VStack(spacing: 30) {
                    //MARK:- Slot 1
                    ZStack {
                        SlotView()
                        Image(items[slots[0]])
                            .resizable()
                            .scaledToFit()
                            .opacity(isSlotsAnimated ? 1 : 0)
                            .offset(x: 0, y: isSlotsAnimated ? 0 : -70)
                            .animation(.easeOut(duration: Double.random(in: 0.8...1.0)))
                            .onAppear(perform: {
                                isSlotsAnimated = true
                                playSound(name: "riseup", format: "mp3")
                            })
                        
                    }
                    HStack(spacing: 30) {
                        //MARK:- Slot 2
                        ZStack {
                            SlotView()
                            Image(items[slots[1]])
                                .resizable()
                                .scaledToFit().opacity(isSlotsAnimated ? 1 : 0)
                                .offset(x: 0, y: isSlotsAnimated ? 0 : -70)
                                .animation(.easeOut(duration: Double.random(in: 0.4...0.6)))
                                .onAppear(perform: {
                                    isSlotsAnimated = true
                                })
                        }
                        Spacer()
                        //MARK:- Slot 3
                        ZStack {
                            SlotView()
                            Image(items[slots[2]])
                                .resizable()
                                .scaledToFit()
                                .opacity(isSlotsAnimated ? 1 : 0)
                                .offset(x: 0, y: isSlotsAnimated ? 0 : -70)
                                .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                                .onAppear(perform: {
                                    isSlotsAnimated = true
                                })
                        }
                    }//HStack
                    .padding(.horizontal, 30)
                    
                    
                    
                    //MARK:- Spin Button
                    Button(action: {
                        //Step 1
                        withAnimation() {
                            isSlotsAnimated = false
                        }
                        
                        //Step 2
                        spinSlots()
                        
                        //Step 3
                        coins -= bet
                        if coins <= 0 {
                            isShowingModal = true
                            playSound(name: "game-over", format: "mp3")
                        }
                        //Step 4
                        winnersChecking()
                        
                        //Step 5
                        withAnimation() {
                            isSlotsAnimated = true
                        }
                        
                        
                        
                        
                    }, label: {
                        Image("gfx-spin")
                            .resizable()
                            .modifier(ImageModifier())
                    })
                }//VStack
                .frame(maxWidth: 600, maxHeight: 700)
                .padding(.vertical, 30)
                Spacer()
                
                //MARK:- FOOTER
                HStack {
                    Button(action: {
                        bet10Activate()
                    }, label: {
                        BetCardView(betNumber: "10")
                            .foregroundColor(isBet10Active ? Color("ColorYellow") : .white)
                    })
                    
                    ChipsView()
                        .opacity(isBet10Active ? 1 : 0)
                    Spacer()
                    ChipsView()
                        .opacity(isBet20Active ? 1 : 0)
                    Button(action: {
                        bet20Activate()
                    }, label: {
                        BetCardView(betNumber: "20")
                            .foregroundColor(isBet20Active ? Color("ColorYellow") : .white)
                    })
                }//HStack
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                Spacer()
            }//Vstack
            .frame(maxWidth: 720, maxHeight: 960)
            .blur(radius: isShowingModal ? 5 : 0)
            
            //MARK: - Refresh and info buttons
            .overlay(
                HStack {
                    Button(action: {
                        resetGame()
                        withAnimation(.easeIn(duration: 1)) {
                            isSlotsAnimated = false
                        }
                        withAnimation() {
                            isSlotsAnimated = true
                        }
                        
                    }, label: {
                        Image(systemName: "repeat.circle")
                            .font(.title)
                            .foregroundColor(.white)
                    })
                    Spacer()
                    Button(action: {
                        print("Refresh")
                    }, label: {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(.white)
                    })
                }
                .padding(.horizontal, 30)
                , alignment: .topTrailing
            )
            
            //MARK:- Modal window
            if $isShowingModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        Text("game over".uppercased())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)            .background(
                                Color("ColorPink"))
                        
                        Spacer()
                        
                        VStack {
                            
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 72)
                                .padding()
                            
                            VStack(spacing: 16) {
                                Text("Bad luck! You lost all of the coins. \n Let'stry again")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                    .padding()
                                
                                Button(action: {
                                    isShowingModal = false
                                    coins = 100
                                    bet10Activate()
                                    withAnimation(.easeIn(duration: 1)) {
                                        isSlotsAnimated = false
                                    }
                                    withAnimation() {
                                        isSlotsAnimated = true
                                    }
                                }, label: {
                                    Text("new game".uppercased())
                                        .font(.system(.title2, design: .rounded))
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color("ColorPink"))
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .frame(minWidth: 128)
                                        .background(
                                            Capsule()
                                                .strokeBorder(lineWidth: 1.75)
                                                .foregroundColor(Color("ColorPink"))
                                        )
                                })
                            }
                            Spacer()
                        }//Vstack
                    }//VStack
                    .frame(minWidth: 280, idealWidth: 320, maxWidth: 345, minHeight: 320, idealHeight: 320, maxHeight: 380, alignment: .center)
                    .background(
                        Color(.white))
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 2, x: 0, y: 8)
                }
            }
        }//ZStack
    }
}
//MARK:- Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
