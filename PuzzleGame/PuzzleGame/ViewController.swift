//
//  ViewController.swift
//  PuzzleGame
//
//  Created by tarena on 15/7/6.
//  Copyright (c) 2015年 shady. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    var size: Int!
    var difficulty: Int!
    var allowHint: Bool!
    var enableAnimation: Bool!
    
    let fieldSize: CGFloat = 300
    var blockSize: CGFloat!
    
    var width: CGFloat!
    var height: CGFloat!
    
    var settingViewController = SettingViewController()
    
    var playField: UIView!
    var blankBlock: UIButton!
    var list = [Int]()
    var solution = [Int]()
    var hintButton: UIButton!
    var gameLabel: UILabel!
    let level = ["Easy", "Hard", "Hell"]
    
    override func viewWillAppear(animated: Bool) {
        redraw()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = self.view.frame.size.width
        height = self.view.frame.size.height
        
        size = 4
        difficulty = 3
        allowHint = true
        enableAnimation = true
        blockSize = fieldSize / CGFloat(size)
        
        self.view.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1)
        
        // set title
        let title = UILabel(frame: CGRectMake(0, 70, width, 30))
        title.textAlignment = NSTextAlignment.Center
        title.font = UIFont.boldSystemFontOfSize(30)
        title.text = "Puzzle Game"
        self.view.addSubview(title)
        
        gameLabel = UILabel(frame: CGRectMake(0, 130, width, 30))
        gameLabel.textAlignment = NSTextAlignment.Center
        gameLabel.font = UIFont.boldSystemFontOfSize(18)
        gameLabel.text = "\(size)x\(size)  \(level[difficulty - 2])"
        self.view.addSubview(gameLabel)
        
        // settings button
        let settingsButton = UIButton(frame: CGRectMake(width / 2 - 145, 130, 70, 30))
        settingsButton.setTitle("settings", forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "settingsAction", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButton.backgroundColor = UIColor.brownColor()
        self.view.addSubview(settingsButton)
        
        // hint button
        hintButton = UIButton(frame: CGRectMake(width / 2 + 75, 130, 70, 30))
        hintButton.setTitle("hint", forState: UIControlState.Normal)
        hintButton.addTarget(self, action: "hint", forControlEvents: UIControlEvents.TouchUpInside)
        hintButton.backgroundColor = UIColor.brownColor()
        hintButton.enabled = allowHint
        self.view.addSubview(hintButton)
        
        // draw playField
        playField = UIView(frame: CGRectMake((width - fieldSize) / 2, (height - fieldSize) / 2, fieldSize, fieldSize))
        playField.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(playField)
        
        for i in 0..<(size * size)
        {
            let block = UIButton()
            block.addTarget(self, action: "blockClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            playField.addSubview(block)

        }
        
        start()
        
        var startButton = UIButton(frame: CGRectMake((width - 150) / 2, height - 150, 150, 50))
        startButton.setTitle("重新开始", forState: UIControlState.Normal)
        startButton.backgroundColor = UIColor.brownColor()
        startButton.addTarget(self, action: "start", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startButton)
        
        // signatural
        var sign = UILabel(frame: CGRectMake(0, height - 70, width, 70))
        sign.text = "Puzzle Game by Shady.\nSource Code: https://github.com/shadyzoz/tarena2015"
        sign.font = UIFont.systemFontOfSize(14)
        sign.textAlignment = NSTextAlignment.Center
        sign.numberOfLines = 2
        self.view.addSubview(sign)
        
    }
    
    func blockClicked(block: UIButton)
    {
        if canSwap(block)
        {
            swap(block)
            
        }
    }
    
    func getBlock(frame: CGRect) -> Int
    {
        let x = Int((frame.minX - 1) / blockSize)
        let y = Int((frame.minY - 1) / blockSize)
        let pos = x + size * y
        return pos
    }
    
    func getFrame(i: Int) -> CGRect
    {
        let x: CGFloat = blockSize * CGFloat(i % size) + 1
        let y: CGFloat = blockSize * CGFloat(i / size) + 1
        return CGRectMake(x, y, blockSize - 2, blockSize - 2)
    }
    
    func canSwap(block: UIButton) -> Bool
    {
        var blankPosotion = getBlock(blankBlock.frame)
        var blockPosition = getBlock(block.frame)
        if abs(blankPosotion - blockPosition) == 1 || abs(blankPosotion - blockPosition) == size
        {
            if blankBlock.frame.midX == block.frame.midX || blankBlock.frame.midY == block.frame.midY
            {
                return true
            }
        }
        return false
    }
    
    func swap(block: UIButton)
    {
        solve(block.tag)
        var newBlankFrame: CGRect = block.frame
        var newBlockFrame: CGRect = blankBlock.frame
        if enableAnimation!
        {
            UIView.animateWithDuration(0.3, animations: {
                block.frame = newBlockFrame
                self.blankBlock.frame = newBlankFrame
                }, completion: nil)
        }
        else
        {
            block.frame = newBlockFrame
            self.blankBlock.frame = newBlankFrame
        }
        didWin()
        println(solution)
    }
    
    func didWin()
    {
        var flag = 0
        for button in playField.subviews
        {
            let pos = getBlock(button.frame)
            if pos == button.tag
            {
                flag++
            }
        }
        if flag == (size * size)
        {
            let alertView = UIAlertView(title: "You Won!", message: "", delegate: self, cancelButtonTitle: "重新开始")
            alertView.show()
        }
    }
    
    func randomBlocks()
    {
        list = []
        solution = []
        for i in 0..<(size * size)
        {
            list.append(i)
        }
        var pos = (size * size - 1)
        let randomTimes = pow(Double(size), Double(difficulty))
        for n in 0..<Int(randomTimes)
        {
            let step = Int(arc4random() % 2) == 0 ? 1 : size
            let pm = Int(arc4random() % 2) == 0 ? 1 : -1
            var replaceNum = pos + (step * pm)
            if replaceNum >= 0 && replaceNum < (size * size)
            {
                if getFrame(pos).midX != getFrame((pos + (step * pm))).midX && getFrame(pos).midY != getFrame((pos + (step * pm))).midY
                {
                    replaceNum = (pos - (step * pm))
                }
            }
            else
            {
                replaceNum = (pos - (step * pm))
            }
            list[pos] = list[replaceNum]
            solve(list[replaceNum])
            list[replaceNum] = (size * size - 1)
            pos = replaceNum
        }
    }
    
    func start()
    {
        randomBlocks()
        // draw blocks
        var i = 0
        for button in playField.subviews
        {
            let block = button as! UIButton
            block.setTitle("\(list[i])", forState: .Normal)
            block.tag = list[i]
            block.frame = getFrame(i)
            block.backgroundColor = list[i] == (size * size - 1) ? UIColor.whiteColor():UIColor.grayColor()
            if list[i] == (size * size - 1)
            {
                blankBlock = block
            }
            i++
        }
        println(solution)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        start()
    }
    
    func solve(elem: Int)
    {
        
        if solution.first == elem
        {
            solution.removeAtIndex(0)
        }
        else
        {
            solution.insert(elem, atIndex: 0)
        }
    }
    
    func hint()
    {
//        let hintAlert = UIAlertView(title: "提示", message: "\(solution.first!)", delegate: nil, cancelButtonTitle: "确定")
//        hintAlert.show()
        for buttons in playField.subviews
        {
            if buttons.tag == solution.first
            {
                swap(buttons as! UIButton)
                return
            }
        }
    }
    
    func settingsAction()
    {
        self.presentViewController(settingViewController, animated: true, completion: {})
    }
    
    func redraw()
    {
        size = settingViewController.size
        difficulty = settingViewController.difficulty
        allowHint = settingViewController.allowHint
        enableAnimation = settingViewController.allowAnimation
        hintButton.enabled = allowHint
        hintButton.backgroundColor = allowHint == true ? UIColor.brownColor():UIColor.grayColor()
        blockSize = fieldSize / CGFloat(size)
        gameLabel.text = "\(size)x\(size)  \(level[difficulty - 2])"
        
        for view in playField.subviews
        {
            (view as! UIButton).removeFromSuperview()
        }
        
        for i in 0..<(size * size)
        {
            let block = UIButton()
            block.addTarget(self, action: "blockClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            playField.addSubview(block)
        }
        
        start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

