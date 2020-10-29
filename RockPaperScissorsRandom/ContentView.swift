//
//  ContentView.swift
//  RockPaperScissorsRandom
//
//  Created by Ahmed Ramy on 10/24/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State var shouldWin : Bool = true
    
    @State var appChoice : String = "Scissors"
    
    @State var score : Int = 0
    
    @State var round : Int = 1
    
    @State var showingScore : Bool = false
    
    @State var title : String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("I Choose \(appChoice)")
                    .fontWeight(.bold)
                    .font(.system(size: 45))
                    .foregroundColor(.white)
                Text(shouldWin ? "You should win" : "You should lose")
                    .padding(.bottom, 120)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                HStack {
                    Button(action: {
                        self.didWin(opponentChoice: self.appChoice, YourChoice: "Paper")
                    }) {
                        pictureForm(name: "paper")
                    }
                    Button(action: {
                        self.didWin(opponentChoice: self.appChoice, YourChoice: "Scissors")
                    }) {
                       pictureForm(name: "scissor")
                    }
                    Button(action: {
                        self.didWin(opponentChoice: self.appChoice, YourChoice: "Rock")
                        }) {
                        pictureForm(name: "rock")
                    }
                }.padding(.bottom, 70)
                
                VStack {
                    Text("Current Score: \(score)")
                        .foregroundColor(.black)
                    Text("Round \(round) of 10")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(title), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                if self.round == 10 {
                    self.round = 1
                    self.score = 0
                } else{
                    self.resetVars()
                    if self.round < 10 {
                        self.round += 1
                    }
                }
                })
        }
    }
    
    func didWin(opponentChoice app : String,YourChoice play: String)  {
        if self.shouldWin {
            if ((app == "Scissors" && play == "Rock") || (app == "Paper" && play == "Scissors") || (app == "Rock" && play == "Paper"))  {
                title = "You Win"
                self.score += 10
            } else {
                title = "You Lose"
            }
        }else {
            if ((app == "Scissors" && play == "Paper") || (app == "Paper" && play == "Rock") || (app == "Rock" && play == "Scissors"))  {
                title = "You Win"
                self.score += 10
            } else {
                title = "You Lose"
            }
        }
        
        showingScore = true
    }
    
    func resetVars() {
        appChoice = moves[Int.random(in: 0...2)]
        shouldWin = Bool.random()
    }
}

struct pictureForm : View {
    let name : String
    var body : some View {
        Image(name)
            .resizable()
            .renderingMode(.original)
            .frame(width: 120, height: 120)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
