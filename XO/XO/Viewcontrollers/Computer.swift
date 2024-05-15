//
//  Computer.swift
//  SampleTTG
//
//  Created by John Michael on 04/04/24.
//

import Foundation


class Computer {
    
    // Variables
    private var name = "Bot"
    
    private var winningSequences:Set = [[1,2,3],
                                        [4,5,6],
                                        [7,8,9],
                                        [1,4,7],
                                        [2,5,8],
                                        [3,6,9],
                                        [1,5,9],
                                        [3,5,7]]
    
    private var moves:Set = [1,2,3,4,5,6,7,8,9]
    // bot moves
    private var botMoves = [Int]()
    // playerMoves
    private var playerMoves = [Int]()
    
    private var opponentMoveCount = 0
    
    private var myMoveCount = 0
    
    private var isBotMove = false
    
    // Functions
    
    func removeLastMove(move : Int){
        if moves.count != 1{
            moves.remove(move)
            
            if !isBotMove {
                playerMoves.append(move)
                opponentMoveCount += 1
                isBotMove = true
                print("playerMove: " ,move)
            } else {
                botMoves.append(move)
                myMoveCount += 1
                isBotMove = false
                
            }
            
        }
        
    }
    
    private func getAvailableMove() -> Int {
        let randomVal = moves.randomElement()!
        print("getAvailableMove: ", randomVal)
        
        return randomVal
    }
    
    private func isMoveAvailable(move: Int) -> Bool {
        return moves.contains(move)
    }
    
    
    // operational functions
    
    
    private func createSequencesWithCombo(_ array: [Int]) -> [[Int]] {
        var pairs = [[Int]]()
        
        // Iterate over the array
        for i in 0..<array.count {
            let firstNumber = array[i]
            
            // Iterate over subsequent elements
            for j in (i+1)..<array.count {
                let secondNumber = array[j]
                pairs.append([firstNumber, secondNumber])
            }
        }
        
        return pairs
    }
    
    
    private func moveTactics() -> Int{
        
        if opponentMoveCount > 2 {
            // check combo
            
            let defendingPairs = createSequencesWithCombo(playerMoves)
            let attackingPairs = createSequencesWithCombo(botMoves)
            
            for pair in defendingPairs {
                for sequences in winningSequences {
                    if Set(pair).isSubset(of: sequences) {
                        let move = Set(sequences).subtracting(pair)
                        if isMoveAvailable(move: Array(move).first!) {
                            winningSequences.remove(sequences)
                            print("DEF-BOT Move: ",Array(move).first!)
                            return Array(move).first!
                        }
                    } else {
                        for attack in attackingPairs {
                            if Set(attack).isSubset(of: sequences){
                                let move = Set(sequences).subtracting(attack)
                                if isMoveAvailable(move: Array(move).first!) {
                                    winningSequences.remove(sequences)
                                    print("ATK-BOT Move: ",Array(move).first!)
                                    return Array(move).first!
                                }
                            }
                        }
                    }
                }
            }
        }
        else if opponentMoveCount == 2 {
            
            if let move = isOpponentGonnaWin() {
                
                return move
                
            } else if let move = botWinningSenario() {
                
                return move
            }
            else {
                let defendingPairs = createSequencesWithCombo(playerMoves)
                for pair in defendingPairs {
                    if Set(pair).isSubset(of: [1,9]) {
                        if pair[0] == 1 {
                            let move = [4,2].randomElement()!
                            print("crossMove :", move)
                            return move
                        } else {
                            let move = [8,6].randomElement()!
                            print("crossMove :", move)
                            return move
                        }
                        
                    } else if Set(pair).isSubset(of: [3,7]){
                        if pair[0] == 3 {
                            let move = [6,2].randomElement()!
                            print("crossMove :", move)
                            return move
                        } else {
                            let move = [4,8].randomElement()!
                            print("crossMove :", move)
                            return move
                        }
                    }
                }
            }
            
        }
        
        //        else if playerMoves[0] == 1 ||  playerMoves[0] == 3 || playerMoves[0] == 7 ||  playerMoves[0] == 9{
        //            let move = [2,4,5,6,8].randomElement()!
        //
        //            print("cornerMoves :", move)
        //            return move
        //        }
        
        
        return getAvailableMove()
    }
    
    private func isOpponentGonnaWin() -> Int? {
        let defendingPairs = createSequencesWithCombo(playerMoves)
        
        for pair in defendingPairs {
            for sequences in winningSequences {
                if Set(pair).isSubset(of: sequences) {
                    
                    let move = Set(sequences).subtracting(pair)
                    if isMoveAvailable(move: Array(move).first!) {
                        winningSequences.remove(sequences)
                        print("DEF-BOT Move: ",Array(move).first!)
                        return Array(move).first!
                    }
                    
                }
            }
        }
        
        return nil
    }
    
    func botWinningSenario() -> Int?{
        
        for var sequence in winningSequences {
            for move in botMoves {
                if sequence.contains(move) {
                    
                    sequence.removeAll { int in
                        int == move
                    }
                    let num1 = sequence[0]
                    let num2 = sequence[1]
                    
                    if isMoveAvailable(move: num1) {
                        print("Bots 2nd move",num1)
                        return num1
                    } else if isMoveAvailable(move: num2) {
                        print("Bots 2nd move",num2)
                        return num2
                    }
                }
            }
        }
        
        return nil
    }
    
    
    
    
    func botTurn() -> Int{
        let move = moveTactics()
        removeLastMove(move: move)
        return move
    }
    
    func newGame(){
        self.playerMoves = []
        self.moves = [1,2,3,4,5,6,7,8,9]
        self.botMoves = [Int]()
        
        self.opponentMoveCount = 0
        self.myMoveCount = 0
        self.isBotMove = false
        self.winningSequences = [[1,2,3],
                                 [4,5,6],
                                 [7,8,9],
                                 [1,4,7],
                                 [2,5,8],
                                 [3,6,9],
                                 [1,5,9],
                                 [3,5,7]]
    }
    
    
}
