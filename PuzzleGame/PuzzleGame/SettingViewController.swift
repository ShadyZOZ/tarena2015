//
//  SettingViewController.swift
//  PuzzleGame
//
//  Created by tony on 7/9/15.
//  Copyright (c) 2015 shady. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var size = 4
    var difficulty = 3
    var allowHint = true
    var allowAnimation = true
    
    var oldSize: Int!
    var oldDifficulty: Int!
    var oldAllowHint: Bool!
    var oldAllowAnimation: Bool!
    
    var sizeLabel: UILabel!
    var enableHintLabel: UILabel!
    var enableAnimationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = CGRectGetWidth(self.view.bounds)
        let height = CGRectGetHeight(self.view.bounds)
        
        oldSize = size
        oldDifficulty = difficulty
        oldAllowHint = allowHint
        oldAllowAnimation = allowAnimation
        
        self.view.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1)
        
        let topView = UIView(frame: CGRectMake(0, 0, width, 64))
        topView.backgroundColor = UIColor.brownColor()
        self.view.addSubview(topView)
        
        let title = UILabel(frame: CGRectMake(0, 20, width, 44))
        title.text = "Settings"
        title.textAlignment = NSTextAlignment.Center
        title.textColor = UIColor.whiteColor()
        title.font = UIFont.boldSystemFontOfSize(20)
        topView.addSubview(title)
        
        let cancelButton = UIButton(frame: CGRectMake(5, 20, 60, 44))
        cancelButton.setTitle("返回", forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: "cancelAction", forControlEvents: UIControlEvents.TouchUpInside)
        topView.addSubview(cancelButton)
        
        sizeLabel = UILabel(frame: CGRectMake(0, 170, width, 40))
        sizeLabel.text = "游戏尺寸: \(size)x\(size)"
        sizeLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(sizeLabel)
        
        var sizeSlider = UISlider(frame: CGRectMake(50, 210, width - 100, 50))
        sizeSlider.minimumValue = 3
        sizeSlider.maximumValue = 6
        sizeSlider.value = 4
        sizeSlider.continuous = false
        sizeSlider.addTarget(self, action: "setNewSize:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(sizeSlider)
        
        let difficultyLabel = UILabel(frame: CGRectMake(0, 260, width, 40))
        difficultyLabel.text = "游戏难度"
        difficultyLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(difficultyLabel)
        
        var levels = ["Easy", "Hard", "Hell"]
        var level = UISegmentedControl(items: levels)
        level.frame = CGRectMake(50, 300, width - 100, 40)
        level.selectedSegmentIndex = 1
        level.addTarget(self, action: "setNewDifficulty:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(level)
        
        enableHintLabel = UILabel(frame: CGRectMake(0, 340, width, 40))
        let hintStatus: String = allowHint == true ? "开":"关"
        enableHintLabel.text = "游戏提示: \(hintStatus)"
        enableHintLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(enableHintLabel)
        
        let hintSwitch = UISwitch()
        hintSwitch.center = CGPointMake(width / 2, 400)
        hintSwitch.on = allowHint
        hintSwitch.addTarget(self, action: "allowHintSwitch:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(hintSwitch)
        
        enableAnimationLabel = UILabel(frame: CGRectMake(0, 420, width, 40))
        let animationStatus: String = allowAnimation == true ? "开":"关"
        enableAnimationLabel.text = "动画效果: \(hintStatus)"
        enableAnimationLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(enableAnimationLabel)
        
        let animationSwitch = UISwitch()
        animationSwitch.center = CGPointMake(width / 2, 480)
        animationSwitch.on = allowHint
        animationSwitch.addTarget(self, action: "allowAnimationSwitch:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(animationSwitch)
        
        let confirmButton = UIButton(frame: CGRectMake((width - 150) / 2, 510, 150, 50))
        confirmButton.setTitle("确定", forState: UIControlState.Normal)
        confirmButton.backgroundColor = UIColor.brownColor()
        confirmButton.addTarget(self, action: "confirmAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(confirmButton)
    }
    
    func confirmAction()
    {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func cancelAction()
    {
        size = oldSize
        difficulty = oldDifficulty
        allowHint = oldAllowHint
        allowAnimation = oldAllowAnimation
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func setNewSize(slider: UISlider)
    {
        slider.value = Float(Int(slider.value + 0.5))
        size = Int(slider.value)
        sizeLabel.text = "游戏尺寸: \(size)x\(size)"
    }
    
    func setNewDifficulty(level: UISegmentedControl)
    {
        difficulty = level.selectedSegmentIndex + 2
        println(difficulty)
    }
    
    func allowHintSwitch(hint: UISwitch)
    {
        allowHint = hint.on
        let hintStatus: String = allowHint == true ? "开":"关"
        enableHintLabel.text = "游戏提示: \(hintStatus)"
        
    }
    
    func allowAnimationSwitch(animation: UISwitch)
    {
        allowAnimation = animation.on
        let animationStatus: String = allowHint == true ? "开":"关"
        enableAnimationLabel.text = "游戏提示: \(animationStatus)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
