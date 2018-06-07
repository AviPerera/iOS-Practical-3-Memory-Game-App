//
//  ViewController.swift
//  Practical 3
//
//  Created by Avi Perera on 7/6/18.
//  Copyright © 2018 Avishka Perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imgs : [UIImage] = [
        UIImage(named: "X")!,
        UIImage(named: "monkey")!,
        UIImage(named: "mickey")!,
        UIImage(named: "panda")!,
        UIImage(named: "tom")!,
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func rotate(_ sender : UIButton) {
        UIView.animate(withDuration: 0.75, animations: {sender.layer.transform = CATransform3DMakeRotation(22.0/7, 0, 1, 0)})
    }
    
    @IBOutlet weak var score: UILabel!
    var lastButton : UIButton?
    @IBAction func buttonTouched(_ sender: UIButton) {
        
        if sender.tag == -1
        {
            return
        }
        
        sender.setImage(imgs[sender.tag], for: .normal)
        
        rotate(sender)
        
        //first touch
        if lastButton == nil{
            lastButton = sender
        }
        //match found
        else if lastButton != nil && sender.tag == lastButton!.tag{
            score.text = "\(Int(score.text!)! + 1)"

            sender.tag = -1
            lastButton!.tag = -1
            lastButton = nil
        }
        else
        {
            sender.setImage(imgs[0], for: .normal)
            lastButton!.setImage(imgs[0], for: .normal)
            rotate(sender)
            rotate(lastButton!)
            lastButton = nil

        }
        
    }
    
    @IBOutlet var buttons: [UIButton]!
    @IBAction func reset(_ sender: UIButton) {

        score.text = "0"
        
        var nums = Array(0..<buttons.count)
        
        while nums.count > 0 {
            var j = Int(arc4random_uniform(UInt32(nums.count)))
            var i = Int(arc4random_uniform(UInt32(nums.count)))
        
        if i != j
        {
            if i > j
            {
                i = nums.remove(at: i)
                j = nums.remove(at: j)
            }
            else
            {
                j = nums.remove(at: j)
                i = nums.remove(at: i)
            }
        }
            //get a random number for tag
            let random = Int(arc4random_uniform(UInt32(imgs.count - 1)) + 1)
            
            //reset buttons with random tags
            buttons[i].tag = random
            buttons[j].tag = random
            
            //reset button images
            buttons[i].setImage(imgs[0], for: .normal)
            buttons[j].setImage(imgs[0], for: .normal)
            
        }
        
    }
}

