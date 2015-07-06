//
//  ViewController.swift
//  MyPlayer
//
//  Created by tony on 7/5/15.
//  Copyright (c) 2015 shadyzoz. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var musicModels: NSArray!
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        var path = NSBundle.mainBundle().pathForResource("Musics.plist", ofType: nil)
        self.musicModels = NSArray(contentsOfFile: path!)
        var musicListTableView = UITableView(frame: self.view.frame)
        musicListTableView.delegate = self
        musicListTableView.rowHeight = 80
        musicListTableView.dataSource = self
        self.view.addSubview(musicListTableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCellWithIdentifier("cellself.musicModels") as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        var dict: NSDictionary = self.musicModels[indexPath.row] as! NSDictionary
        cell.textLabel?.text = dict["name"] as? String
        cell.detailTextLabel?.text = dict["singer"] as? String
        var singerIcon: String = dict["singerIcon"] as! String
        cell.imageView?.image = UIImage(named: singerIcon)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var dict: NSDictionary = self.musicModels[indexPath.row] as! NSDictionary
        var filename: String = dict["filename"] as! String
        var path = NSBundle.mainBundle().pathForResource(filename, ofType: nil)
        var url: NSURL = NSURL.fileURLWithPath(path!)!
        self.player = AVAudioPlayer(contentsOfURL: url, error: nil)
        self.player.prepareToPlay()
        self.player.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

