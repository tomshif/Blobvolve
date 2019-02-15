//
//  GameScene.swift
//  Blobvolve
//
//  Created by Tom Shiflet on 2/15/19.
//  Copyright © 2019 Tom Shiflet. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let DNA=SKSpriteNode(imageNamed: "DNA_2")
    let blob=SKSpriteNode(imageNamed: "blob01")
    
    let minBlobScale:CGFloat=0.9
    let maxBlobScale:CGFloat=1.1
    
    var pulseScale:CGFloat=1.0
    var pulseMod:CGFloat = 0.0025
    
    override func didMove(to view: SKView) {

        drawDNAStrand()
        blob.colorBlendFactor=1.0
        let blobR=random(min: 0, max: 1)
        let blobG=random(min: 0, max: 1)
        let blobB=random(min: 0, max: 1)
        
        blob.color=NSColor(calibratedRed: blobR, green: blobG, blue: blobB, alpha: 1.0)
        
        addChild(blob)
    }
    
    func drawDNAStrand()
    {
        //remove existing DNA Strand
        for node in self.children
        {
            if node.name=="DNA"
            {
                node.removeFromParent()
            }
        }
        
        for i in 1...20
        {
            let dna=SKSpriteNode(imageNamed: "DNA_2")
            dna.name="DNA"
            dna.position.y=size.height*0.4
            dna.position.x = -size.width*0.3+(CGFloat(i)*dna.size.width*0.55)
            dna.colorBlendFactor=1.0
            let col=random(min: 0, max: 1.9999999)
            if col < 1
            {
                dna.color=NSColor.blue
            }
            if col >= 1
            {
                dna.color=NSColor.red
            }
            addChild(dna)
            
            let dna2=SKSpriteNode(imageNamed: "DNA_2")
            dna2.name="DNA"
            dna2.position.y=size.height*0.34
            dna2.position.x = -size.width*0.3+(CGFloat(i)*dna.size.width*0.55)
            dna2.zRotation=CGFloat.pi
            dna2.colorBlendFactor=1.0
            let col2=random(min: 0, max: 1.9999999)
            if col2 < 1
            {
                dna2.color=NSColor.yellow
            }
            else
            {
                dna2.color=NSColor.green
            }
            
            addChild(dna2)
        }
    }
    
    func changeBlobColor()
    {
        let blobR=random(min: 0, max: 1)
        let blobG=random(min: 0, max: 1)
        let blobB=random(min: 0, max: 1)
        
        blob.color=NSColor(calibratedRed: blobR, green: blobG, blue: blobB, alpha: 1.0)
        
        
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49:
            changeBlobColor()
            drawDNAStrand()
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    func pulseBlob()
    {
        if pulseScale > maxBlobScale
        {
            pulseMod *= -1
            pulseScale=maxBlobScale
        }
        if pulseScale < minBlobScale
        {
            pulseMod *= -1
            pulseScale=minBlobScale
        }

        pulseScale += pulseMod
        blob.setScale(pulseScale)
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        pulseBlob()
    }
}
