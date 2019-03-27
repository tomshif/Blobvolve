//
//  GameScene.swift
//  Blobvolve
//
//  Created by Tom Shiflet on 2/15/19.
//  Copyright © 2019 Tom Shiflet. All rights reserved.
//

import SpriteKit
import GameplayKit

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}


class GameScene: SKScene {
    
    let DNA=SKSpriteNode(imageNamed: "DNA_2")
    var blob=BlobClass()
    var blob2=BlobClass()
    
    var baby=BlobClass()
    
    let bg=SKSpriteNode(imageNamed: "bg01")
    let saveFrame=SKSpriteNode(imageNamed: "saveFrame")
    let selectArrow=SKSpriteNode(imageNamed: "selectArrow")
    
    var leftPressed:Bool=false
    var rightPressed:Bool=false
    var showGeneName:Bool=false
    
    
    var saves=[String]()
    var savesPreview=[SKTexture]()
    var save01=SKSpriteNode(imageNamed: "blob00")
    var save02=SKSpriteNode(imageNamed: "blob00")
    var save03=SKSpriteNode(imageNamed: "blob00")
    
    var blob1Level=SKLabelNode(text: "Level")
    var blob2Level=SKLabelNode(text: "Level")
    var babyLevel=SKLabelNode(text: "Baby Level")
    var moneyLabel=SKLabelNode(text: "Money")
    var breedCostLabel=SKLabelNode(text: "Breeding Cost")
    
    var lastMoneyGain=NSDate()
    
    var blobBaseSize:CGFloat=1.0
    var minBlobScale:CGFloat=0.9
    var maxBlobScale:CGFloat=1.1
    
    var pulseScale:CGFloat=1.0
    var pulseMod:CGFloat = 0.0025

    var strandOffset:CGFloat=0
    
    let MOVESPEED:CGFloat=5
    let BREEDCOST:Int=5
    let BREEDCOSTBASE:Int=200
    
    var selected:Int=0
    
    var money:Int=500000
    
    override func didMove(to view: SKView) {

        strandOffset = -size.width*0.4
        let clutterPath = Bundle.main.path(
            forResource: "screenClutter", ofType: "sks")

        let clutterNode =
            NSKeyedUnarchiver.unarchiveObject(withFile: clutterPath!)
                as! SKEmitterNode
        clutterNode.name="clutterNode"
        addChild(clutterNode)
        
        let frame=SKSpriteNode(imageNamed: "DNAFrame")
        frame.position.y = -size.height*0.4
        frame.zPosition=8
        frame.name="frame"
        addChild(frame)
        
        // init saves arrays
        for _ in 0..<9
        {
            saves.append("")
            savesPreview.append(SKTexture(imageNamed: "blob00"))
        }
        
        saveFrame.isHidden=true
        saveFrame.name="saveFrame"
        saveFrame.zPosition=20
        addChild(saveFrame)
        
        save01.setScale(0.75)
        saveFrame.addChild(save01)
        save01.position.y = saveFrame.size.height*0.33
        save01.position.x = -saveFrame.size.width*0.33
        save01.alpha=1.0
        save01.name="save01"
        save01.zPosition=22
        
        save02.setScale(0.75)
        saveFrame.addChild(save02)
        save02.position.y = saveFrame.size.height*0.33
        save02.position.x = 0
        save02.alpha=1.0
        save02.name="save02"
        save02.zPosition=22
        
        save03.setScale(0.75)
        saveFrame.addChild(save03)
        save03.position.y = saveFrame.size.height*0.33
        save03.position.x = saveFrame.size.width*0.33
        save03.alpha=1.0
        save03.name="save03"
        save03.zPosition=22
        
        blob1Level.position.x = -size.width*0.35
        blob1Level.position.y = size.height*0.25
        blob1Level.zPosition=25
        blob1Level.name="blob1Level"
        addChild(blob1Level)
        
        blob2Level.position.x = size.width*0.35
        blob2Level.position.y = size.height*0.25
        blob2Level.zPosition=25
        blob2Level.name="blob2Level"
        addChild(blob2Level)
        
        babyLevel.position.y = size.height*0.25
        babyLevel.name="babyLevel"
        babyLevel.zPosition=25
        addChild(babyLevel)
        
        let frame2=SKSpriteNode(imageNamed: "DNAFrame")
        frame2.position.y = size.height*0.4
        frame2.zPosition=8
        frame2.name="Frame"
        addChild(frame2)
        
        moneyLabel.zPosition=10
        moneyLabel.position.y = -size.height*0.38
        moneyLabel.name="moneyLabel"
        addChild(moneyLabel)
        
        breedCostLabel.zPosition=10
        breedCostLabel.name="breedCostLabel"
        breedCostLabel.position.y = -size.height*0.3
        addChild(breedCostLabel)
        
        selectArrow.zPosition=12
        selectArrow.position.y = -size.height*0.25
        selectArrow.setScale(2.0)
        selectArrow.name="selectArrow"
        addChild(selectArrow)

        
        bg.zPosition = -5
        bg.name="bg"
        addChild(bg)
        

        
        addChild(blob.sprite)
        addChild(blob2.sprite)
        addChild(baby.sprite)
        blob.sprite.name="blob00"
        blob2.sprite.name="blob01"
        
        blob.sprite.position.x = -size.width*0.35
        blob2.sprite.position.x = size.width*0.35
        baby.sprite.isHidden=true
        
        blob.generateByLevel(level: 0)
        blob2.generateByLevel(level: 0)
        drawDNAStrand()
        
        blob.age=1.0
    } // didMove()
    

    func toDNA(code: String) -> String
    {
        var coded:String=""
        var length:Int=0
        for char in code
        {
            length+=1
            switch char
            {
            case "0":
                coded.append("R")
            case "1":
                coded.append("G")
            case "2":
                coded.append("B")
            case "3":
                coded.append("Y")
            default:
                print("Conversion Error to encoded DNA")
            } // switch
        } // for each character
        if length < 3
        {
            for _ in 0..<3-length
            {
                coded.insert("R", at: coded.startIndex)
            }
        }
        return coded
    } // toDNA()
    
    func toBase(dec: Int, b:Int) -> String {
        guard b > 1 && b < 11 else {
            fatalError("base too high")
        }
        var num:Int=dec
        var str = ""
        repeat {
            str = String(num%b) + str
            num = num/b
        }
            while num > 0
        return str
    } //toBase()
    
    
    /*
    func tripToDec(trip: String) -> Int
    {
        var num:Int=0
        var digit:Int=2
        print("Trip: \(trip)" )
        for char in trip
        {
            var mult:Int=0
            print("Char: \(char)")
            switch char
            {
            case "R":
                mult=0
            
            case "G":
                mult = 1
                
            case "B":
                mult=2
            case "Y":
                mult=3
            default:
                print("Error in tripToDec - Unknown base")
            } // swith
            
            num += 4^^digit * mult
            print("Digit \(digit): \(num)")
            
            digit -= 1
            
        } // for
        return num
    }
    */
    func drawDNAStrand()
    {
        //remove existing DNA Strand
        for node in self.children
        {
            if node.name!.contains("DNA")
            {
                node.removeFromParent()
            }
        } // for each node
    
        blob1Level.text="Level: \(blob.computeLevel())"
        print("Level: \(blob.computeLevel())")
        blob2Level.text="Level: \(blob2.computeLevel())"
        babyLevel.text="Level: \(baby.computeLevel())"
        
        
        //blob.sprite.removeAllActions()
        //blob=BlobClass()
        let coded=blob.DNA
        for i in 0..<blob.GENECOUNT*blob.GENESIZE
        {
            let dna=SKSpriteNode(imageNamed: "DNA_2")
            dna.name=String(format: "DNA%03d",i)
            dna.setScale(0.65)
            dna.position.y = size.height*0.38
            dna.position.x = strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
            dna.colorBlendFactor=1.0

            let thisChar=coded[coded.index(coded.startIndex, offsetBy: i)]
            switch (thisChar)
            {
            case "R":
                dna.color=NSColor.red
            case "G":
                dna.color=NSColor.green
            case "B":
                dna.color=NSColor.blue
            case "Y":
                dna.color=NSColor.yellow
            default:
                break
                
            } // switch
            dna.zPosition=10
            addChild(dna)
            
            // for number label
            if i%3==1
            {
                let geneNum=Int(i/3)
                var geneLabel=SKLabelNode()
                //let geneLabel=SKLabelNode(text: "\(geneNum)")
                
                if (showGeneName)
                {
                    if geneNum < blob.GeneStrings.count
                    {
                        geneLabel=SKLabelNode(text: blob.GeneStrings[geneNum])
                    }
                    else
                    {
                       geneLabel=SKLabelNode(text: "\(geneNum)")
                    }
                    geneLabel.name="DNALabel"
                    geneLabel.position.y=size.height*0.445
                    geneLabel.fontColor=NSColor.white
                    geneLabel.fontSize=14
                    geneLabel.zPosition=12
                    geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                    addChild(geneLabel)
                } // if showGeneName is on
                else
                {
                    geneLabel=SKLabelNode(text: "\(geneNum)")
                    geneLabel.name="DNALabel"
                    geneLabel.position.y=size.height*0.445
                    geneLabel.fontColor=NSColor.white
                    geneLabel.fontSize=14
                    geneLabel.zPosition=12
                    geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                    addChild(geneLabel)
                } // if showGeneName is Off
            }
        } // for each chromosome
        
        let coded2=blob2.DNA
        for i in 0..<blob2.GENECOUNT*blob2.GENESIZE
        {
            let dna=SKSpriteNode(imageNamed: "DNA_2")
            dna.name=String(format: "DNA%03d",i)
            dna.setScale(0.65)
            dna.position.y = size.height*0.42
            dna.position.x = strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
            dna.colorBlendFactor=1.0
            
            let thisChar=coded2[coded2.index(coded2.startIndex, offsetBy: i)]
            switch (thisChar)
            {
            case "R":
                dna.color=NSColor.red
            case "G":
                dna.color=NSColor.green
            case "B":
                dna.color=NSColor.blue
            case "Y":
                dna.color=NSColor.yellow
            default:
                break
                
            } // switch
            addChild(dna)
            dna.zPosition=10
        }
        
        // draw baby DNA
        if !baby.sprite.isHidden
        {
            let coded3=baby.DNA
            for i in 0..<baby.GENECOUNT*baby.GENESIZE
            {
                let dna=SKSpriteNode(imageNamed: "DNA_2")
                dna.name=String(format: "DNA%03d",i)
                dna.setScale(0.65)
                dna.position.y = -size.height*0.425
                dna.position.x = strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                dna.colorBlendFactor=1.0
                
                let thisChar=coded3[coded3.index(coded3.startIndex, offsetBy: i)]
                switch (thisChar)
                {
                case "R":
                    dna.color=NSColor.red
                case "G":
                    dna.color=NSColor.green
                case "B":
                    dna.color=NSColor.blue
                case "Y":
                    dna.color=NSColor.yellow
                default:
                    break
                    
                } // switch
                addChild(dna)
                dna.zPosition=10
                

                // for number label
                if i%3==1
                {
                    let geneNum=Int(i/3)
                    var geneLabel=SKLabelNode()
                    //let geneLabel=SKLabelNode(text: "\(geneNum)")
                    
                    if (showGeneName)
                    {
                        if geneNum < blob.GeneStrings.count
                        {
                            geneLabel=SKLabelNode(text: blob.GeneStrings[geneNum])
                        }
                        else
                        {
                            geneLabel=SKLabelNode(text: "\(geneNum)")
                        }
                        geneLabel.name="DNALabel"
                        geneLabel.position.y = -size.height*0.47
                        geneLabel.fontColor=NSColor.white
                        geneLabel.fontSize=14
                        geneLabel.zPosition=12
                        geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                        addChild(geneLabel)
                    } // if showGeneName is on
                    else
                    {
                        geneLabel=SKLabelNode(text: "\(geneNum)")
                        geneLabel.name="DNALabel"
                        geneLabel.position.y = -size.height*0.47
                        geneLabel.fontColor=NSColor.white
                        geneLabel.fontSize=14
                        geneLabel.zPosition=12
                        geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                        addChild(geneLabel)
                    } // if showGeneName is Off
                }
            } // for each gene
        }// if baby isn't hidden
    } // func drawDNAStrand
    

    
    func touchDown(atPoint pos : CGPoint) {

        for thisNode in self.nodes(at: pos)
        {
            if thisNode.name!.contains("DNA")
            {
                let theName=thisNode.name!
                var start=theName.index(theName.startIndex, offsetBy: 3)
                let end=theName.endIndex
                let range=start..<end
                let num=Int(theName[range])!
                let geneNum=Int(num/3)
                //print("Gene: \(geneNum)")
                if pos.y > size.height*0.4
                {
                    blob2.generateNewGene(at: geneNum)
                }
                else
                {
                    blob.generateNewGene(at: geneNum)
                }
                drawDNAStrand()
                baby.sprite.isHidden=true
                
            } // if node is DNA
            if thisNode.name!.contains("blob00")
            {
                selected=0
            }
            else if thisNode.name!.contains("blob01")
            {
                selected=1
            }
            
            if !saveFrame.isHidden
            {
                if thisNode.name!.contains("save01")
                {
                    if selected==0
                    {
                        blob.DNA=saves[0]
                        blob.resetSprite()
                        drawDNAStrand()
                    } // if blob 1
                    else if selected==1
                    {
                        blob2.DNA=saves[0]
                        blob2.resetSprite()
                        
                        drawDNAStrand()
                        
                    } // if blob 2
                } // if click on save #1
                if thisNode.name!.contains("save02")
                {
                    if selected==0
                    {
                        blob.DNA=saves[1]
                        blob.resetSprite()
                        drawDNAStrand()
                    } // if blob 1
                    else if selected==1
                    {
                        blob2.DNA=saves[1]
                        blob2.resetSprite()
                        drawDNAStrand()
                        
                    } // if blob 2
                } // if click on save #2
                if thisNode.name!.contains("save03")
                {
                    if selected==0
                    {
                        blob.DNA=saves[2]
                        blob.resetSprite()
                        drawDNAStrand()
                    } // if blob 1
                    else if selected==1
                    {
                        blob2.DNA=saves[2]
                        blob2.resetSprite()
                        drawDNAStrand()
                        
                    } // if blob 2
                } // if click on save #2
            }
        } // for each node
    } // touchDown
    
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
        case 0:
            leftPressed=true
            
        case 2:
            rightPressed=true
            
        case 11:
            let temp=blob.breed(with: blob2)
            baby.DNA=temp.DNA
            baby.resetSprite()
            
            baby.sprite.isHidden=false
            drawDNAStrand()
            let levels=blob.computeLevel()+blob2.computeLevel()
            money -= (levels*BREEDCOST)+BREEDCOSTBASE
            let chance=random(min: 0, max: 1)
            if chance > 0.95
            {
                baby.sprite.texture=blendTextures(first: blob, second: blob2)
            }
            
        case 29:
            if showGeneName
            {
                showGeneName = false
                drawDNAStrand()
            }
            else
            {
                showGeneName=true
                drawDNAStrand()
            }
            //print("showGeneName is \(showGeneName)")
        case 30:    // ] - Limit blob 2 to less than level 10

            blob2.genNewDNA()
            blob2.generateByLevel(level: 10)
            baby.sprite.isHidden=true
            drawDNAStrand()
            money -= BREEDCOST
            
        case 33:    // [ - Limit blob 1 to less than level 10

            blob.genNewDNA()
            blob.generateByLevel(level: 10)
            baby.sprite.isHidden=true
            drawDNAStrand()
            money -= BREEDCOST
            
        case 18:
            if saveFrame.isHidden
            {
                blob.genNewDNA()
                blob.resetSprite()
                baby.sprite.isHidden=true
                drawDNAStrand()
                money -= BREEDCOST
                let proc1Chance=random(min: 0, max: 1)
                if proc1Chance > 0.8
                {
                    blob.sprite.texture=createProcTexture()
                    
                }
                
            } // if not saving
            else
            {
                saves[0]=baby.DNA
                print(saves[0])
                self.isPaused=true
                let temp=self.view!.texture(from: baby.sprite)
                self.isPaused=false
                savesPreview[0]=temp!
                save01.texture=savesPreview[0]
                
            }
        case 19:
            if saveFrame.isHidden
            {
                blob2.genNewDNA()
                blob2.resetSprite()
                baby.sprite.isHidden=true
                drawDNAStrand()
                money -= BREEDCOST
                let proc2Chance=random(min: 0, max: 1)
                if proc2Chance > 0.8
                {
                    blob2.sprite.texture=createProcTexture()
                    
                }
            } // if not saving
            else
            {
                saves[1]=baby.DNA
                print(saves[1])
                self.isPaused=true
                let temp=self.view!.texture(from: baby.sprite)
                self.isPaused=false
                savesPreview[1]=temp!
                save02.texture=savesPreview[1]
            }
        case 20:
            if !saveFrame.isHidden
            {
                saves[2]=baby.DNA
                print(saves[2])
                self.isPaused=true
                let temp=self.view!.texture(from: baby.sprite)
                self.isPaused=false
                savesPreview[2]=temp!
                save03.texture=savesPreview[2]
            }
            
        case 34:
            print("Baby Speed: \(baby.moveSpeed)")
            print("Baby Health: \(baby.blobHealth)")
            print("Baby Damage: \(baby.blobDamage)")
            print("Baby Level: \(baby.computeLevel())")
        
        case 35:
            
            blob.genNewDNA()
            blob2.genNewDNA()
            baby.sprite.isHidden=true
            //changeBlobColor()
            drawDNAStrand()
            money -= BREEDCOST
            blob.sprite.texture=createProcTexture()
            blob2.sprite.texture=createProcTexture()
        case 36:
            if saveFrame.isHidden
            {
                saveFrame.isHidden=false
            }
            else
            {
                saveFrame.isHidden=true
            }
        case 45:

            baby.replaceGene(at: 3, with: "RRR")
            baby.resetSprite()
            drawDNAStrand()
            
        case 46:        // M - spawn baby with blended texture
            let temp=blob.breed(with: blob2)
            baby.DNA=temp.DNA
            baby.resetSprite()
            
            baby.sprite.isHidden=false
            baby.sprite.texture=blendTextures(first: blob, second: blob2)
            drawDNAStrand()
            
            let levels=blob.computeLevel()+blob2.computeLevel()
            money -= (levels*BREEDCOST)+BREEDCOSTBASE
            baby.age=0.5
        case 49:    // spacebar - spawn 2 new blobs
            blob.genNewDNA()
            blob2.genNewDNA()
            baby.sprite.isHidden=true
            //changeBlobColor()
            drawDNAStrand()
            money -= BREEDCOST
            
            let proc1Chance=random(min: 0, max: 1)
            if proc1Chance > 0.8
            {
                blob.sprite.texture=createProcTexture()

            }
            let proc2Chance=random(min: 0, max: 1)
            if proc2Chance>0.8
            {
                blob2.sprite.texture=createProcTexture()
            }


        case 123:
            
            blob.DNA=baby.DNA
            baby.sprite.isHidden=true
            let tempTexture=baby.sprite.texture!
            blob.resetSprite()
            drawDNAStrand()
            blob.sprite.texture=tempTexture
        case 124:
            blob2.DNA=baby.DNA
            baby.sprite.isHidden=true
            blob2.resetSprite()
            let tempTexture=baby.sprite.texture!
            drawDNAStrand()
            
            blob2.sprite.texture=tempTexture
            
        case 126:       // up arrow - sell baby
            if !baby.sprite.isHidden
            {
                money += (baby.computeLevel()*BREEDCOST)+BREEDCOSTBASE
                baby.sprite.isHidden=true
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        } // switch
    } // func keyDown
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 0:
            leftPressed=false
            
        case 2:
            rightPressed=false

        default:
            break
        } // switch
    } // func keyDown
    
    func checkKeys()
    {
        if leftPressed
        {
            for i in self.children
            {
                if i.name!.contains("DNA")
                {
                    i.position.x += MOVESPEED
                    
                }
            }
            strandOffset += MOVESPEED
        } // if left
        
        if rightPressed
        {
            for i in self.children
            {
                if i.name!.contains("DNA")
                {
                    i.position.x -= MOVESPEED
                    
                }
            }
            strandOffset -= MOVESPEED
        } // if right
    } // func checkKeys()

    func updateUI()
    {
        if selected==0
        {
            selectArrow.position.x = -size.width*0.35
        }
        else if selected==1
        {
            selectArrow.position.x = size.width*0.35
        }
        if baby.sprite.isHidden
        {
            babyLevel.isHidden=true
        }
        else
        {
            babyLevel.isHidden=false
        }
        moneyLabel.text="$\(money)"
        if money < 0
        {
            moneyLabel.fontColor=NSColor.red
        }
        else
        {
            moneyLabel.fontColor=NSColor.white
        }
        let cost=((blob.computeLevel()+blob2.computeLevel())*BREEDCOST)+BREEDCOSTBASE
        breedCostLabel.text="Breeding Cost: $\(cost)"
    }
    
    func blendTextures(first: BlobClass, second: BlobClass) -> SKTexture
    {
        
        var firstNode=SKSpriteNode()
        var secondNode=SKSpriteNode()
        
        let chance=random(min: 0, max: 1)
        if chance > 0.5
        {
            let firstAlpha=first.sprite.alpha
            let secondAlpha=second.sprite.alpha
            let firstColor=first.sprite.color
            let secondColor=second.sprite.color
            first.sprite.alpha=1.0
            second.sprite.alpha=1.0
            first.sprite.color=NSColor.white
            second.sprite.color=NSColor.white
            firstNode=SKSpriteNode(texture: first.sprite.texture!)
            //firstNode.zRotation=first.sprite.zRotation
            secondNode=SKSpriteNode(texture: second.sprite.texture!)
            //secondNode.zRotation=second.sprite.zRotation
            first.sprite.alpha=firstAlpha
            second.sprite.alpha=secondAlpha
            first.sprite.color=firstColor
            second.sprite.color=secondColor
            
        }
        else
        {
            let firstAlpha=second.sprite.alpha
            let secondAlpha=first.sprite.alpha
            let firstColor=second.sprite.color
            let secondColor=first.sprite.color
            first.sprite.alpha=1.0
            second.sprite.alpha=1.0
            first.sprite.color=NSColor.white
            second.sprite.color=NSColor.white
            firstNode=SKSpriteNode(texture: second.sprite.texture!)
            //firstNode.zRotation=second.sprite.zRotation
            secondNode=SKSpriteNode(texture: first.sprite.texture!)
            //secondNode.zRotation=first.sprite.zRotation
            first.sprite.alpha=secondAlpha
            second.sprite.alpha=firstAlpha
            first.sprite.color=secondColor
            second.sprite.color=firstColor
        }
        let tempNode=SKSpriteNode()
        let alphaRatio=random(min: 0.3, max: 1)
        tempNode.blendMode=SKBlendMode.add
        tempNode.position=CGPoint(x: size.width*10, y: size.height*10)

        //let solidNode=SKSpriteNode(texture: SKTexture(imageNamed: "blob00"))
        //tempNode.addChild(solidNode)
        firstNode.alpha=1.0
        firstNode.blendMode=SKBlendMode.add
        tempNode.addChild(firstNode)

        secondNode.alpha=1.0-alphaRatio
        secondNode.blendMode=SKBlendMode.add
        tempNode.addChild(secondNode)
        tempNode.alpha=1.0
        let retText=self.view!.texture(from: tempNode)
        tempNode.removeFromParent()
        
        return retText!
    }
    
    public func createProcTexture() -> SKTexture
    {
        //let noise = GKNoise(GKBillowNoiseSource(frequency: 0.015, octaveCount: 2, persistence: 0.2, lacunarity: 0.005, seed: Int32(random(min: 0, max: 25000))))
        var noise=GKNoise()
        var mapCenter=vector_double2()
        mapCenter.x=0
        mapCenter.y=0
        var mapSize=vector_double2()
        mapSize.x=256
        mapSize.y=256
        var type=Int(random(min: 0, max: 11.9999999))
        // print("Type: \(type)")
        //type=10
        switch type
        {
        case 0:
            noise=GKNoise(GKVoronoiNoiseSource(frequency: Double(random(min: 0.01, max: 0.025)), displacement: Double(random(min: 0.5, max: 3.5)), distanceEnabled: false, seed: Int32(random(min: 0, max: 25000))))
        case 1:
            noise=GKNoise(GKCylindersNoiseSource(frequency: Double(random(min: 0.01, max: 0.15))))
            mapCenter.x=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
            mapCenter.y=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
        case 2:
            noise=GKNoise(GKVoronoiNoiseSource(frequency: Double(random(min: 0.01, max: 0.025)), displacement: Double(random(min: 0.5, max: 3.5)), distanceEnabled: true, seed: Int32(random(min: 0, max: 25000))))
        case 3:
            noise=GKNoise(GKRidgedNoiseSource(frequency: Double(random(min: 0.01, max: 0.1)), octaveCount: Int(random(min: 1, max: 10)), lacunarity: Double(random(min: 0.001, max: 5)), seed: Int32(random(min: 0, max: 25000))))
            
        case 4:
            noise=GKNoise(GKSpheresNoiseSource(frequency: Double(random(min: 0.001, max: 0.55))))
            mapCenter.x=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
            mapCenter.y=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
            
        case 5:
            noise = GKNoise(GKBillowNoiseSource(frequency: Double(random(min: 0.015, max: 0.035)), octaveCount: Int(random(min: 15, max: 19.9999)), persistence: 0.65, lacunarity: 0.05, seed: Int32(random(min: 0, max: 25000))))
        case 6:
            noise = GKNoise(GKBillowNoiseSource(frequency: Double(random(min: 0.015, max: 0.035)), octaveCount: Int(random(min: 15, max: 19.9999)), persistence: 0.65, lacunarity: Double(random(min: 0.25, max: 0.65)), seed: Int32(random(min: 0, max: 25000))))

        case 7:
            noise=GKNoise(GKVoronoiNoiseSource(frequency: Double(random(min: 0.025, max: 0.25)), displacement: Double(random(min: 3.5, max: 8.5)), distanceEnabled: false, seed: Int32(random(min: 0, max: 25000))))
            
        case 8:
            noise=GKNoise(GKCheckerboardNoiseSource(squareSize: Double(random(min: 5.5, max: 15.5))))
            
        case 9:
            noise=GKNoise(GKCheckerboardNoiseSource(squareSize: Double(random(min: 15.5, max: 45.5))))
            
        case 10:
            noise=GKNoise(GKCheckerboardNoiseSource(squareSize: Double(random(min: 45.5, max: 145.5))))
            
        default:
            noise = GKNoise(GKBillowNoiseSource(frequency: Double(random(min: 0.01, max: 0.025)), octaveCount: Int(random(min: 1, max: 4.9999)), persistence: 0.2, lacunarity: 0.5, seed: Int32(random(min: 0, max: 25000))))
        }

        
        //mapCenter.x=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
        //mapCenter.y=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))

        var mapSamples=vector_int2()
        mapSamples.x=256
        mapSamples.y=256
        
        let noiseMap = GKNoiseMap(noise, size: mapSize, origin: mapCenter, sampleCount: mapSamples, seamless: true)
        
        let text=SKTexture(noiseMap: noiseMap)
        let thisNode=SKSpriteNode()
        let cropNode=SKSpriteNode(imageNamed: "blob00")
        cropNode.blendMode=SKBlendMode.multiply
        let tempNode=SKSpriteNode(texture: text)
        tempNode.blendMode=SKBlendMode.alpha
        tempNode.zPosition=1
        cropNode.zPosition=2
        thisNode.addChild(tempNode)
        thisNode.name="DNACrop"
        thisNode.addChild(cropNode)
        let ang=random(min: 0, max: CGFloat.pi*2)
        addChild(thisNode)
        let retText=scene!.view!.texture(from: thisNode)
        thisNode.removeFromParent()
        return retText!
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        checkKeys()
        updateUI()
        baby.update()
        print("Age: \(baby.age)")
        print("Scale: \(baby.sprite.xScale)")
        
        if -lastMoneyGain.timeIntervalSinceNow > 5
        {
            money += 1000
            lastMoneyGain=NSDate()
        }
    }
}
