//
//  ContentView.swift
//  RockPaperScisors
//
//  Created by Ricardo on 24/07/23.
//

import SwiftUI

struct ContentView: View {
    

    
    @State private var userChoice = ""
    @State private var score = 0
    @State private var numberOfRounds = 0
    @State private var answerAlert = false
    @State private var gameFinishedAlert = false
    @State private var message = ""
    @State private var subtitle = ""

    var choices = ["🪨","📄","✂️"]
    var roundsLimit = 3
    
    @State private var cpuChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
var correctAnswer: String {
        if cpuChoice == 0 && shouldWin == true {
            return "📄"
        } else if cpuChoice == 1 && shouldWin == true {
            return "✂️"
        } else if cpuChoice == 2 && shouldWin == true {
            return "🪨"
        } else if cpuChoice == 0 && shouldWin == false {
            return "✂️"
        } else if cpuChoice == 1 && shouldWin == false {
            return "🪨"
        } else if cpuChoice == 2 && shouldWin == false {
            return "📄"
        } else {
            return ""
        }
    }
    
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                
                if shouldWin {
                    Text("Play to Win").font(.title).bold()
                }else {
                    Text("Play to Lose").font(.title).bold()
                }
                
                Text("\(choices[cpuChoice])")
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .font(.system(size:250))
                
                Spacer()
                
                
                HStack {
                    
                    ForEach(choices, id: \.self){ answer in
                        Button("\(answer)"){
                            userChoice = answer
                            moveMade()
                        }
                        .padding()
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        .font(.system(size:60))
                    }
                    
                }
                
                Spacer()
                
                Text("Round: \(numberOfRounds) / \(roundsLimit)")
                    .font(.title2)
                Text("Score: \(score)")
                    .font(.title3)
                
                Spacer()
                Spacer()
            }
            .alert("\(message)",isPresented: $answerAlert){
                Button("Continue", action: newRound)
            } message: {
                Text("\(subtitle)")
            }
            .alert("Thanks For Playing",isPresented: $gameFinishedAlert){
                Button("Continue", action: resetGame)
            } message: {
                Text("Your Final Score is \(score)")
            }
        }
        
        
    }
    
    func newRound(){
        numberOfRounds += 1
        if numberOfRounds >= roundsLimit {
            gameFinishedAlert = true
        } else {
            cpuChoice = Int.random(in: 0...2)
            shouldWin = Bool.random()
        }
    }
    
    func moveMade(){
        if userChoice == correctAnswer {
            message = "Correct!"
            score += 1
            if shouldWin {
                subtitle = "\(userChoice) Wins over \(choices[cpuChoice])"
            } else {
                subtitle = "\(userChoice) Lose over \(choices[cpuChoice])"
            }
        } else if userChoice == choices[cpuChoice] {
            message = "Tie!"
            subtitle = "You can do this!"
        } else {
            message = "Wrong!"
            if shouldWin {
                subtitle = "\(userChoice) Lose over \(choices[cpuChoice])"
            } else {
                subtitle = "\(userChoice) Wins over \(choices[cpuChoice])"
            }
        }
        answerAlert = true
    }
    
    func resetGame(){
        cpuChoice = Int.random(in: 0...2)
        shouldWin.toggle()
        numberOfRounds = 0
        score = 0
    }
    
    
}




#Preview {
    ContentView()
}
