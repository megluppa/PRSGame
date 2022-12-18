//
//  ContentView.swift
//  PRSGame
//
//  Created by Magdalena Kulawik-Luppa on 18/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["paper","rock","scissors"]
    @State private var appMoveChoice = Int.random(in: 0...2)
    @State private var appResultChoice = Bool.random()
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var showingFinal = false
    @State private var currentRound = 1
    private let maxRound = 8
    
    
    var body: some View {
        VStack {
            HStack{
                Text("App's move:")
                    .foregroundColor(.black)
                Text(moves[appMoveChoice])
                    .foregroundColor(.blue)
            }.font(.title.bold())
            HStack{
                Text("You should:")
                Text(appResultChoice ? "win" : "loose")
                    .foregroundColor(.blue)
            }.font(.title.bold())
            ForEach(0..<3){ number in
                Button{
                    choiceTrapped(number)
                } label: {
                    PRSImage(choice: number)
                }
            }
            //Spacer()
            //Spacer()

            Text("Score: \(score) ")
                .foregroundColor(.black)
                .font(.title.bold())
            Text("Round: \(currentRound) ")
                .foregroundColor(.black)
                .font(.title.bold())

            Spacer()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Congratulations", isPresented: $showingFinal){
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(score)")
        }
        .padding()
    }
    
    func choiceTrapped(_ number: Int){
        if moves[number] == getAnswear() {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong!"
        }
        showingScore = true
        
        
    }
    
    func getAnswear() -> String {
        switch (moves[appMoveChoice], appResultChoice) {
            case ("rock", true):
                return "paper"
            case ("rock", false):
                return "scissors"
            case ("paper", true):
                return "scissors"
            case ("paper", false):
                return "rock"
            case ("scissors", true):
                return "paper"
            case ("scissors", false):
                return "rock"
            default:
                return ""
        }
    }
    
    func askQuestion(){
        if currentRound == maxRound {
            showingFinal = true
        } else {
            appMoveChoice =  Int.random(in: 0...2)
            appResultChoice.toggle()
            currentRound += 1
        }
        
    }
    
    func restartGame(){
        appMoveChoice =  Int.random(in: 0...2)
        appResultChoice.toggle()
        score = 0
        currentRound = 1
    }
}

struct PRSImage: View {
    var choice: Int
    let imgIcons = ["applescript.fill","oval.fill","scissors"]
    
    var body: some View {
        Image(systemName: imgIcons[choice])
            .font(.system(size: 80))
            .shadow(color: .gray, radius: 10, x: 0, y: 10)
            .padding(30)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
