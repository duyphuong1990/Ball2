//
//  ViewController.swift
//  ping pong
//
//  Created by Duy Phuong on 5/25/17.
//  Copyright © 2017 Duy Phuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    var ball = UIImageView()
    var radian = CGFloat()
    var ballRaius = CGFloat()
    var deltaAngle = CGFloat()
    var xuoi = Bool()
    var direction:CGFloat = 1
    var truot : UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addBall()
        addTruot()
        xuoi = true
        let time = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(rollBall), userInfo: nil, repeats: true)
        
    }
    
    
    
    func onPan(panGesture: UIGestureRecognizer) {
        print("Hello")
        if (panGesture.state == .began || panGesture.state == .changed){
            let point = panGesture.location(in: self.view)
            self.truot.center = point
            
           
            
        }
    }

    func addBall() {
        let mainViewSize = self.view.bounds.size
        ball = UIImageView(image: UIImage(named: "ball"))
        ballRaius = 32.0
        ball.center = CGPoint(x: mainViewSize.width * 0.5, y: mainViewSize.height)
        self.view.addSubview(ball)
    }
    func addTruot() {
        truot = UIView(frame: CGRect(x: view.bounds.size.width/2-50, y: view.bounds.size.height - 30, width: 150, height: 30))
        truot.layer.backgroundColor = UIColor.blue.cgColor
        view.addSubview(truot)
        let panGesture = UIGestureRecognizer(target: self, action: #selector(onPan))
        //self.view.addGestureRecognizer(panGesture)
        
        //truot.addGestureRecognizer(panGesture)
        truot.isUserInteractionEnabled = true
        truot.addGestureRecognizer(panGesture)
        
    }
    
    func rollBall() {
        if xuoi == true {
            doichieugocquay()
            quayXuoi()
            
        }
        else {
        doichieugocquay()
        quayNguoc()}
    }

    func quayXuoi() {
        deltaAngle = 0.1
        radian = radian + deltaAngle
        ball.transform = CGAffineTransform(rotationAngle: radian)
        self.ball.center = CGPoint(x: self.ball.center.x + ballRaius * deltaAngle, y: self.ball.center.y + ballRaius * direction * deltaAngle)
        
        if (ball.center.x >=  view.bounds.size.width - ballRaius) {
            xuoi = false
            quayNguoc()}
    }
   
    
    
    func quayNguoc() {
        deltaAngle = -0.1
        radian = radian + deltaAngle
        ball.transform = CGAffineTransform(rotationAngle: radian)
        self.ball.center = CGPoint(x: self.ball.center.x + ballRaius * deltaAngle, y: self.ball.center.y - ballRaius * deltaAngle * direction)
        
        if (ball.center.x <=  ballRaius) {
            xuoi = true
            quayXuoi()}
        
    }
    
    func random1dentru1() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func doichieugocquay() {
        let dic = random1dentru1()
//        print(dic)
        if (ball.center.y >= view.bounds.size.height - ballRaius) {
        direction = -dic}
        else if (ball.center.y <= ballRaius) {
        direction = dic}
    }

}
