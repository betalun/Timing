//
//  ViewController.swift
//  Counter
//
//  Created by betalun on 15/7/30.
//  Copyright (c) 2015年 betalun. All rights reserved.
//
//TODO list: 时间到达零秒的时候就要有警告而不是到达零秒以后一面再提醒
//           第一次打开程序的时候不容许提醒


import UIKit

class ViewController: UIViewController {
    
    
    var label: UILabel?
    var beginStopButton: UIButton?
    var resetButton: UIButton?
    var timer: NSTimer?
    var isCounting: Bool = false{
        willSet{
            if newValue {
                
                //lable stop
                beginStopButton?.setTitle("暂停", forState: UIControlState.Normal)
                //start counting
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
            }else{
                //lable begin
                //stop counting
                beginStopButton?.setTitle("开始", forState: UIControlState.Normal)
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    //subclaculate time per seconds
    func updateTime(sender: UIButton){
        remainTime -= 1;
    }
    
    let timeButtonInfo = [("1分",60),("2分",120),("3分",180),("秒",1)]
    var timeButtons = [UIButton]()

    var remainTime: Int = 0 {
        willSet(newSecends){
            if remainTime<=0 {
                beginStopButton?.setTitle("开始", forState: UIControlState.Normal)
                timer?.invalidate()
                timer = nil
                alertTimeout()
                return
            }
            let mint = newSecends / 60
            let secs = newSecends % 60
            label!.text = NSString(format: "%02d:%02d", mint,secs) as String
        }
    }
    
    func alertTimeout(){
        var alert = UIAlertView()
        alert.title = "时间到了";
        alert.message = "where are you"
        alert.addButtonWithTitle("OK")
        alert.show();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLabelView()
        initTimeButton()
        initOperationButton()
        initResetButton()
    }
    

    //创建Label控件
    func initLabelView(){
        label = UILabel(frame: CGRectMake(5, 20, 200, 80))
        label!.backgroundColor = UIColor.blackColor()
        label!.textColor = UIColor.whiteColor()
        label!.font = UIFont(name: "",size: 70)
        label!.textAlignment = NSTextAlignment.Center
        label!.text = NSString(format: "%02d:%02d", 0,0) as String;
        self.view.addSubview(label!)
    }
    
    
    //创建时间按钮
    func initTimeButton(){
        for (index,(title,_)) in enumerate(timeButtonInfo){
            var button = UIButton(frame: CGRectMake(CGFloat(5+45*index), 120, 30,15))
            button.backgroundColor = UIColor.orangeColor()
            button.tag = index
            button.setTitle("\(title)", forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            button.addTarget(self, action: "onClickTimeButton:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            timeButtons.append(button)
        }
    }
    
    //create operation button
    func initOperationButton(){
        beginStopButton = UIButton(frame: CGRectMake(15, 250, 50, 70))
        beginStopButton!.backgroundColor = UIColor.orangeColor()
        beginStopButton!.setTitle("开始", forState: UIControlState.Normal)
        beginStopButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        beginStopButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        beginStopButton!.addTarget(self, action: "onClickBeginStopButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(beginStopButton!)
    }
    
    func initResetButton(){
        resetButton = UIButton(frame: CGRectMake(100, 250, 50, 70))
        resetButton!.backgroundColor = UIColor.orangeColor()
        resetButton!.setTitle("复位", forState: UIControlState.Normal)
        resetButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        resetButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        resetButton!.addTarget(self, action: "onClickResetButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(resetButton!)
        
    }
    
    //event handler of time button
    func onClickTimeButton(sender: UIButton){
        println("time button clicked")
        let (_,time) = timeButtonInfo[sender.tag]
        remainTime += time
    }
    
    //event handle of begin-stop button
    func onClickBeginStopButton(sender: UIButton){
        println("beginStopButton clicked")
        if remainTime <= 0{
            return
        }
        isCounting = !isCounting
    }
    
    func onClickResetButton(sender: UIButton){
        println("resetButton clicked")
        remainTime = 0;
        isCounting = false
    }
        
    //functions 1.set time 2.begin&stop 3.timeout alter
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

