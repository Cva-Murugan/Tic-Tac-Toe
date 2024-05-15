//
//  ViewController.swift
//  SampleTTG
//
//  Created by John Michael on 02/04/24.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var playerTurnIndicatorLabel: UILabel!
    
    @IBOutlet weak var columnView: UIView!
    @IBOutlet weak var gameBoard: UIStackView!
    
    //1st row
    @IBOutlet weak var one: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var three: UIView!
    
    //2nd row
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var five: UIView!
    @IBOutlet weak var six: UIView!
    
    //3rd row
    @IBOutlet weak var seven: UIView!
    @IBOutlet weak var eight: UIView!
    @IBOutlet weak var nine: UIView!
    
    
    
    @IBOutlet weak var scoreBoardView: UIView!
    
    @IBOutlet weak var scoreBoardTittle: UIStackView!
    
    @IBOutlet weak var tittleLabel1: UILabel!
    
    @IBOutlet weak var tittleLabel2: UILabel!
    
    
    @IBOutlet weak var scoreView: UIStackView!
    
    @IBOutlet weak var scoreLabel1: UILabel!
    
    @IBOutlet weak var scoreLabel2: UILabel!
    
    
    
    weak var shapeLayer: CAShapeLayer?
    var shapeLayerArray = [CAShapeLayer]()
    
    var tapCount = 0
    
    var viewArray: [UIView]  {
        return [one,two,three, four,five,six,seven,eight,nine]
    }
    
    let winnings  = [[1,2,3],
                    [4,5,6],
                    [7,8,9],
                    [1,4,7],
                    [2,5,8],
                    [3,6,9],
                    [1,5,9],
                    [3,5,7]]
    
    var playerOne  = [Int]()
    var playerTwo = [Int]()
    
    var playmode = ""
    var isBot = false
    
    var choosenSide = ""
    var firstPlayer = ""
    var secondPlayer = ""
    
    let bot = Computer()
    var isGameConclued = false
    
    var playerWinCount = 0
    var BotWinCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor]
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
                
        navigationItem.hidesBackButton = true
        
        if choosenSide == "X" {
            firstPlayer = "X"
            secondPlayer = "O"
        } else {
            firstPlayer = "O"
            secondPlayer = "X"
        }
        
        if playmode == "bot" {
            isBot = true
            tittleLabel1.text = "Player"
            tittleLabel2.text = "Bot"
        } else {
            tittleLabel1.text = firstPlayer
            tittleLabel2.text = secondPlayer
        }
        
        scoreLabel1.text = playerWinCount.description
        scoreLabel2.text = BotWinCount.description
        
        
        
        
        playerTurnIndicatorLabel.text = "\(choosenSide) turn"
        
        setupTapGesturesForView()
        columnView.addDashedBorders()
        columnView.layer.cornerRadius = 25
        
    }
    
    
    func setupTapGesturesForView(){
        
        let oneGesture = UITapGestureRecognizer(target: self, action: #selector(oneViewTapped))
        let twoGesture = UITapGestureRecognizer(target: self, action: #selector(twoViewTapped))
        let threeGesture = UITapGestureRecognizer(target: self, action: #selector(threeViewTapped))
        let fourGesture = UITapGestureRecognizer(target: self, action: #selector(fourViewTapped))
        let fiveGesture = UITapGestureRecognizer(target: self, action: #selector(fiveViewTapped))
        let sixGesture = UITapGestureRecognizer(target: self, action: #selector(sixViewTapped))
        let sevenGesture = UITapGestureRecognizer(target: self, action: #selector(sevenViewTapped))
        let eightGesture = UITapGestureRecognizer(target: self, action: #selector(eightViewTapped))
        let nineGesture = UITapGestureRecognizer(target: self, action: #selector(nineViewTapped))
        
        one.addGestureRecognizer(oneGesture)
        two.addGestureRecognizer(twoGesture)
        three.addGestureRecognizer(threeGesture)
        four.addGestureRecognizer(fourGesture)
        five.addGestureRecognizer(fiveGesture)
        six.addGestureRecognizer(sixGesture)
        seven.addGestureRecognizer(sevenGesture)
        eight.addGestureRecognizer(eightGesture)
        nine.addGestureRecognizer(nineGesture)
        
    }
    
    
    func playerOneWins(result: Set<Int>){
        print("player one Wins with:" , result.sorted())
        restartGame(winnner: "\"\(firstPlayer)\"")
    }
    
    func playerTwoWins(result: Set<Int>){
        print("player two Wins with:" , result.sorted())
        restartGame(winnner: "\"\(secondPlayer)\"")
    }
    
    func botWins(result: Set<Int>){
        print("Bot Wins with:" , result.sorted())
        restartGame(winnner: "Bot")
    }
    
    func restartGame( winnner: String?){
        print("Game Restarts....")
        
        let color = UIColor(named:"viewsColor")
        
        if let winnner = winnner {
            self.playerTurnIndicatorLabel.text = "\(winnner) Won"
        } else {
            self.playerTurnIndicatorLabel.text = "Draw"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.view.isUserInteractionEnabled = true
            self.playerTurnIndicatorLabel.text = "\(self.firstPlayer) turn"
            
            for view in self.viewArray {
                view.backgroundColor = color
                view.isUserInteractionEnabled = true
                //self.shapeLayer?.removeFromSuperlayer()
            }
            
            for shapeLayer in self.shapeLayerArray {
                shapeLayer.removeFromSuperlayer()
                
            }
            
            self.shapeLayerArray = []
            self.tapCount = 0
            self.playerOne.removeAll()
            self.playerTwo.removeAll()
            self.isGameConclued = false
            if self.isBot{
                self.bot.newGame()
            }
        })
      
    }
    
    
    
    func checkWinnings(){
        
        if tapCount >= 5 {
            for winning in winnings {
                
                if Set(winning).isSubset(of: Set(playerOne)) {
                    // player one wins
                    let result = Set(winning).intersection(Set(playerOne))
                    view.isUserInteractionEnabled = false
                    isGameConclued = true
                    playerOneWins(result: result)
                    drawWinningLine(winningLine: findLineType(line: winning))
                    playerWinCount += 1
                    scoreLabel1.text = playerWinCount.description
                    break
                }
                else if Set(winning).isSubset(of: Set(playerTwo)) {
                    // player Two wins
                    let result = Set(winning).intersection(Set(playerTwo))
                    view.isUserInteractionEnabled = false
                    
                    isGameConclued = true
                    if isBot {
                        botWins(result: result)
                    } else {
                        playerTwoWins(result: result)
                    }
                    BotWinCount += 1
                    scoreLabel2.text = BotWinCount.description
                    drawWinningLine(winningLine: findLineType(line: winning))
                    break
                }
                else if (tapCount == 9) {
                    // Draw
                    restartGame(winnner: nil)
                    break
                }
            }
        }
        
    }
    
   
    
    func drawXO(on view :UIView ,place: Int){
        if isBot {
            playerToBot(on: view, place: place)
        } else {
            playerToPlayer(on: view, place: place)
        }
    }
    
    func draw(player: String,view:UIView){
        if player == "X" {
            drawX(view: view)
        } else {
            drawO(view: view)
        }
    }
    
    func playerToPlayer(on view :UIView ,place: Int){
        if tapCount%2 == 0 {
            
            tapCount = tapCount + 1
            playerOne.append(place)
            playerTurnIndicatorLabel.text = "\(secondPlayer) turn"
            draw(player: firstPlayer, view: view)
            
        } else {
            
            playerTurnIndicatorLabel.text = "\(firstPlayer) turn"
            tapCount = tapCount + 1
            playerTwo.append(place)
            draw(player: secondPlayer, view: view)
            
        }
        
        view.isUserInteractionEnabled = false
        
        checkWinnings()
    }
    
    func playerToBot(on view :UIView ,place: Int){
        
        
        if tapCount%2 == 0 {
            if !isGameConclued {
                
                tapCount = tapCount + 1
                playerOne.append(place)
                playerTurnIndicatorLabel.text = "\(secondPlayer) turn"
                draw(player: firstPlayer, view: view)
                
                checkWinnings()
                
                // check winning
                if tapCount < 9 && !isGameConclued {
                    if isBot {
                      
                        bot.removeLastMove(move: place)
                        // when bot plays
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.botPlays()
                        })
                    }
                }
            }
            
        } else {
            
            
            playerTurnIndicatorLabel.text = "\(firstPlayer) turn"
            tapCount = tapCount + 1
            playerTwo.append(place)
            // prevent from overtapping
            draw(player: secondPlayer, view: view)
            checkWinnings()
        }
        
        view.isUserInteractionEnabled = false

    }
    
    
    func botPlays(){
        let move = bot.botTurn()
        switch move {
        case 1:
            oneViewTapped()
        case 2:
            twoViewTapped()
        case 3:
            threeViewTapped()
        case 4:
            fourViewTapped()
        case 5:
            fiveViewTapped()
        case 6:
            sixViewTapped()
        case 7:
            sevenViewTapped()
        case 8:
            eightViewTapped()
        case 9:
            nineViewTapped()
        default:
            break
        }
    }
    
    // view tap gesture functions
    
    @objc func oneViewTapped(){
        drawXO(on: one, place: 1)
    }
    
    @objc func twoViewTapped(){
        drawXO(on: two, place: 2)
    }
    
    @objc func threeViewTapped(){
        drawXO(on: three, place: 3)
    }
    
    @objc func fourViewTapped(){
        drawXO(on: four, place: 4)
    }
    
    @objc func fiveViewTapped(){
        drawXO(on: five, place: 5)
    }
    
    @objc func sixViewTapped(){
        drawXO(on: six, place: 6)
    }
    
    @objc func sevenViewTapped(){
        drawXO(on: seven, place: 7)
    }
    
    @objc func eightViewTapped(){
        drawXO(on: eight, place: 8)
    }
    
    @objc func nineViewTapped(){
        drawXO(on: nine, place: 9)
    }
    
    func drawX(view: UIView) {
        view.backgroundColor = .red
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 19.4, y: 20.4))
        path.addLine(to: CGPoint(x: 78, y: 81.6))
        path.move(to: CGPoint(x: 78, y: 20.4))
        path.addLine(to: CGPoint(x: 19.4, y: 81.6))
         
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  UIColor.systemYellow.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.path = path.cgPath
        shapeLayer.cornerRadius = 10
        
        // Add shadow
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 5, height: 2)
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowRadius = 2
        

        // animate it
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1
        shapeLayer.add(animation, forKey: "MyAnimation")

        
        // save shape layer
        //self.shapeLayer = shapeLayer
        shapeLayerArray.append(shapeLayer)
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.view.isUserInteractionEnabled = true
        })
    }
    

    
    func drawO(view: UIView) {
        view.backgroundColor = .systemYellow
        
        let centerX = view.bounds.width / 2
        let centerY = view.bounds.height / 2
        let radius = min(view.bounds.width, view.bounds.height) / 3
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY),
                                       radius: radius,
                                       startAngle: 0,
                                       endAngle: CGFloat.pi * 2,
                                       clockwise: true)
        
        // Create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.path = path.cgPath
        shapeLayer.cornerRadius = 10
        
        // Add shadow properties
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowOffset = CGSize(width: 5, height: 2)
        shapeLayer.shadowRadius = 2
        
        // Animate it
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // Save shape layer
        shapeLayerArray.append(shapeLayer)
    }

    
    
    func drawWinningLine(winningLine: WinningLine){
        
        let points = getLinePoints(with: winningLine)
        
        let path = UIBezierPath()
        
        let x = points.x
        let y = points.y
        let maxX = points.maxX
        let maxY = points.maxY
        
        path.move(to: CGPoint(x: x , y: y ))
        path.addLine(to: CGPoint(x: maxX, y: maxY))
        
        // Add shadow to button's layer
        gameBoard.layer.shadowColor = UIColor(named: "shadowColor")?.cgColor ?? UIColor.black.cgColor
        gameBoard.layer.shadowOpacity = 1
        gameBoard.layer.shadowOffset = CGSize(width: 0, height: 0)
        gameBoard.layer.shadowRadius = 0
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.path = path.cgPath
        shapeLayer.cornerRadius = 10

        
        // animate it

        gameBoard.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1
        shapeLayer.add(animation, forKey: "MyAnimation")

        // save shape layer

        shapeLayerArray.append(shapeLayer)
        
    }
    
    
    enum WinningLine{
        case verticalLine(line :[Int])
        case horizontalLine(line :[Int])
        case crossLine(line :[Int])
    }
    
    func findLineType(line: [Int]) -> WinningLine {
        
        let index = winnings.firstIndex(of: line)
        if (1...3).contains(index! + 1) {
            return WinningLine.horizontalLine(line: line)
        } else if (4...6).contains(index! + 1) {
            return WinningLine.verticalLine(line: line)
        }else {
            return WinningLine.crossLine(line: line)
        }
        
    }
    
    func getLinePoints(with WinningLine: WinningLine) -> (x:CGFloat, y:CGFloat, maxX:CGFloat, maxY: CGFloat){
        
        let x = gameBoard.frame.origin.x
        let y = gameBoard.frame.origin.y
        let maxX = gameBoard.frame.maxX
        let maxY = gameBoard.frame.maxY
        
        switch WinningLine{
            
        case .horizontalLine(line: let line) where line == [1,2,3]:
            let yPoint = (maxY/3) - 50
            return (x + 10, yPoint, maxX - 10, yPoint)
            
        case .horizontalLine(line: let line) where line == [4,5,6]:
            let yPoint = (maxY/2)
            return (x + 10, yPoint, maxX - 10, yPoint)
            
        case .horizontalLine(line: let line) where line == [7,8,9]:
            let yPoint = maxY - 50
            return (x + 10, yPoint, maxX - 10, yPoint)
            
        case .verticalLine(line: let line) where line == [1,4,7]:
            let xPoint = (maxX/3) - 50
            return (xPoint, y + 10 , xPoint , maxY - 10)
            
        case .verticalLine(line: let line) where line == [2,5,8]:
            let xPoint = (maxX/2)
            return (xPoint, y + 10 , xPoint , maxY - 10)
            
        case .verticalLine(line: let line) where line == [3,6,9]:
            let xPoint = (maxX) - 50
            return (xPoint, y + 10 , xPoint , maxY - 10)
            
        case .crossLine(line: let line) where line == [1,5,9]:
            return (x + 10 , y + 10, maxX - 10, maxY - 10)
            
        case .crossLine(line: let line) where line == [3,5,7]:
            return (maxX - 10 ,y + 10 ,x + 10 , maxY - 10 )
            
        default:
            return(0,0,0,0)
            
        }
        
        
    }
    
    
    
}

