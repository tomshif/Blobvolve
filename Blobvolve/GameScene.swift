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


struct PHYSICSTYPES
{
    static let NOTHING:         UInt32=0b0000000000000001
    static let BLOB:            UInt32=0b0000000000000010
    static let WALL:            UInt32=0b0000000000000100
    static let ELECTRICWAVE:    UInt32=0b0000000000001000
    static let SONICWAVE:       UInt32=0b0000000000010000
    static let VIRUS:           UInt32=0b0000000000100000
    static let LIGHTNING:       UInt32=0b0000000001000000
    static let POISONCLOUD:     UInt32=0b0000000010000000

    static let EVERYTHING: UInt32=UInt32.max
} // PHYSICSTYPES

struct GAMESTATES
{
    static let BREED:Int=0
    static let FIGHT:Int=2
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameState:Int=0
    
    let DNA=SKSpriteNode(imageNamed: "DNA_2")
    var blob:BlobClass?
    var blob2:BlobClass?
    
    var baby:BlobClass?
    
    let cam=SKCameraNode()
    
    let bg=SKSpriteNode(imageNamed: "bg01")
    let arenaBorder=SKSpriteNode(imageNamed: "octogon")
    let arenaFloor=SKSpriteNode(imageNamed: "octofloor03")
    
    let saveFrame=SKSpriteNode(imageNamed: "saveFrame")
    let selectArrow=SKSpriteNode(imageNamed: "selectArrow")
    
    let frame1=SKSpriteNode(imageNamed: "DNAFrame")
    let frame2=SKSpriteNode(imageNamed: "DNAFrame")
    
    var arenaEdge=SKShapeNode()
    
    var leftPressed:Bool=false
    var rightPressed:Bool=false
    var upPressed:Bool=false
    var downPressed:Bool=false
    var scrollLeftPressed:Bool=false
    var scrollRightPressed:Bool=false
    
    var zoomInPressed:Bool=false
    var zoomOutPressed:Bool=false
    
    var showGeneName:Bool=false
    var showHUD:Bool=false
    
    var myLight=SKLightNode()
    
    var UIscoutingReportBG=SKSpriteNode(imageNamed: "UIscoutingReportBG")
    var UISRBlob0Name=SKLabelNode(text: "Blob1Name")
    var UISRBlob1Name=SKLabelNode(text: "Blob1Name")
    
    
    var saves=[String]()
    var savesPreview=[SKTexture]()
    var save01=SKSpriteNode(imageNamed: "blob00")
    var save02=SKSpriteNode(imageNamed: "blob00")
    var save03=SKSpriteNode(imageNamed: "blob00")
    
    var blob1Label=SKLabelNode(text: "1-Level")
    var blob2Label=SKLabelNode(text: "2-Level")
    
    var blob1Level=SKLabelNode(text: "Level")
    var blob2Level=SKLabelNode(text: "Level")
    var babyLevel=SKLabelNode(text: "Baby Level")
    var moneyLabel=SKLabelNode(text: "Money")
    var breedCostLabel=SKLabelNode(text: "Breeding Cost")
    var babyGrowthLabel=SKLabelNode(text: "Growth: ")
    var blob1Name=SKLabelNode(text: "")
    var blob2Name=SKLabelNode(text: "")
    var babyName=SKLabelNode(text: "")

    var battleName1=SKLabelNode(text: "")
    var battleName2=SKLabelNode(text: "")
    
    
    
    let clutterPath = Bundle.main.path(
        forResource: "screenClutter", ofType: "sks")
    
    let clutterNode=SKEmitterNode(fileNamed: "screenClutter")
    
    let damageLabelAction=SKAction.sequence([SKAction.fadeIn(withDuration: 0.1), SKAction.wait(forDuration: 2.0), SKAction.fadeOut(withDuration: 0.3)])
    
    var lastMoneyGain=NSDate()
    
    var blobBaseSize:CGFloat=1.0
    var minBlobScale:CGFloat=0.9
    var maxBlobScale:CGFloat=1.1
    
    var pulseScale:CGFloat=1.0
    var pulseMod:CGFloat = 0.0025

    var strandOffset:CGFloat=0
    
    let MOVESPEED:CGFloat=10
    let BREEDCOST:Int=5
    let BREEDCOSTBASE:Int=200
    var MOVEBOUNDARY:CGFloat=0
    let CLOUDINTERVAL:Double=1
    
    var selected:Int=0
    
    var money:Int=500000
    
    
    
    override func didMove(to view: SKView) {

        
        // Setup physics world
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self as! SKPhysicsContactDelegate
        
        MOVEBOUNDARY=size.height
        
        self.backgroundColor=NSColor.black
        // setup camera
        self.camera=cam
        cam.name="camera"
        addChild(cam)
        cam.setScale(1.5)

        let arenaColor=NSColor(calibratedRed: random(min: 0.5, max: 1.0), green: random(min: 0.5, max: 1.0), blue: random(min: 0.5, max: 1.0), alpha: 1.0)
 
        //let lightAction=SKAction.sequence([SKAction.colorize(with: NSColor.black, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: NSColor.white, colorBlendFactor: 1.0, duration: 1.0)])
        //myLight.run(SKAction.repeatForever(lightAction))
        
        
        
        // setup UI pieces
        
        cam.addChild(UIscoutingReportBG)
        UIscoutingReportBG.zPosition=100
        
        UISRBlob0Name.position.x = -size.width*0.25
        UISRBlob1Name.position.x = size.width*0.25
        UISRBlob0Name.position.y = size.height*0.28
        UISRBlob1Name.position.y = size.height*0.28
        UISRBlob0Name.fontColor=NSColor.cyan
        UISRBlob1Name.fontColor=NSColor.cyan
        UISRBlob0Name.zPosition=101
        UISRBlob1Name.zPosition=101
        
        UIscoutingReportBG.addChild(UISRBlob0Name)
        UIscoutingReportBG.addChild(UISRBlob1Name)
        UIscoutingReportBG.isHidden=true
        
        blob=BlobClass(theScene: self)
        blob2=BlobClass(theScene: self)
        baby=BlobClass(theScene: self)
        
        blob!.blobID=0
        blob2!.blobID=1
        
        strandOffset = -size.width*0.4

        battleName1.position.x = -size.width*0.38
        battleName1.position.y = size.height*0.4
        battleName1.fontColor=NSColor.red
        battleName1.fontName="Arial-BoldMT"
        battleName1.fontSize=22
        battleName1.text="Blob1Name"
        battleName1.name="battleUI-Blob0"
        battleName1.alpha=CGFloat.leastNonzeroMagnitude
        cam.addChild(battleName1)
        
        battleName2.position.x = size.width*0.38
        battleName2.position.y = size.height*0.4
        battleName2.fontColor=NSColor.blue
        battleName2.fontName="Arial-BoldMT"
        battleName2.fontSize=22
        battleName2.text="Blob2Name"
        battleName2.name="battleUI-Blob1"
        battleName2.alpha=CGFloat.leastNonzeroMagnitude
        cam.addChild(battleName2)
        

        clutterNode!.name="clutterNode"
        clutterNode!.targetNode=scene
        clutterNode!.particleColor=arenaColor
        cam.addChild(clutterNode!)
        
       
        frame1.position.y = -size.height*0.4
        frame1.zPosition=8
        frame1.name="frame"
        cam.addChild(frame1)
        

        
        // init saves arrays
        for _ in 0..<9
        {
            saves.append("")
            savesPreview.append(SKTexture(imageNamed: "blob00"))
        }
        
        saveFrame.isHidden=true
        saveFrame.name="saveFrame"
        saveFrame.zPosition=20
        cam.addChild(saveFrame)
        
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
        
 
        blob1Level.position.y = size.height*0.25
        blob1Level.zPosition=25
        blob1Level.name="blob1Level"
        addChild(blob1Level)
        

        blob2Level.position.y = size.height*0.25
        blob2Level.zPosition=25
        blob2Level.name="blob2Level"
        addChild(blob2Level)
        
        babyLevel.position.y = size.height*0.25
        babyLevel.name="babyLevel"
        babyLevel.zPosition=25
        addChild(babyLevel)
        
        
        frame2.position.y = size.height*0.4
        frame2.zPosition=8
        frame2.name="Frame"
        cam.addChild(frame2)
        
        moneyLabel.zPosition=10
        moneyLabel.position.y = -size.height*0.38
        moneyLabel.name="moneyLabel"
        cam.addChild(moneyLabel)
        
        breedCostLabel.zPosition=10
        breedCostLabel.name="breedCostLabel"
        breedCostLabel.position.y = -size.height*0.3
        cam.addChild(breedCostLabel)
        
        selectArrow.zPosition=12
        selectArrow.position.y = -size.height*0.25
        selectArrow.setScale(2.0)
        selectArrow.name="selectArrow"
        cam.addChild(selectArrow)

        babyGrowthLabel.zPosition=10
        babyGrowthLabel.position.y = -size.height*0.2
        babyGrowthLabel.name="babyGrowthLabel"
        //cam.addChild(babyGrowthLabel)
        
        bg.zPosition = -5
        bg.name="bg"
        bg.lightingBitMask=1
        //addChild(bg)

        blob1Name.position.x = -size.width*0.40
        blob2Name.position.x = size.width*0.40
        blob1Name.position.y = size.height*0.35
        blob2Name.position.y = size.height*0.35
        babyName.position.y = size.height*0.35
        addChild(blob1Name)
        addChild(blob2Name)
        addChild(babyName)
        
        // add arena
        

        arenaBorder.zPosition = -5
        arenaBorder.lightingBitMask=0
        arenaBorder.name="arenaBorder"
        arenaBorder.colorBlendFactor=1.0
        arenaBorder.color=arenaColor
        addChild(arenaBorder)

        
        
        
        
        arenaFloor.zPosition = -6
        arenaFloor.lightingBitMask=1
        arenaFloor.name="arenaFloor"
        arenaFloor.colorBlendFactor=1.0
        arenaFloor.color=arenaColor
        let floorNum=Int(random(min: 1, max: 3.99999999))
        arenaFloor.texture=SKTexture(imageNamed: "octofloor0\(floorNum)")
        arenaBorder.addChild(arenaFloor)

        
        addChild(blob1Label)
        addChild(blob2Label)
        
        addChild(blob!.sprite)
        addChild(blob2!.sprite)
        addChild(baby!.sprite)
        blob!.sprite.name="blob0"
        blob2!.sprite.name="blob1"
        
        blob!.sprite.position.x = -size.width*0.35
        blob2!.sprite.position.x = size.width*0.35
        baby!.sprite.isHidden=true
        
        blob!.generateByLevel(level: 0)
        blob2!.generateByLevel(level: 0)
        drawDNAStrand()
        
        blob!.age=1.0
        redrawScoutScreen()
        drawArenaEdge()
    } // didMove()
    
    func redrawScoutScreen()
    {
        // remove stars
        for node in UIscoutingReportBG.children
        {
            if node.name != nil
            {
                if node.name!.contains("star")
                {
                    node.removeFromParent()
                }
                if node.name!.contains("level")
                {
                    node.removeFromParent()
                }
                if node.name!.contains("Icon")
                {
                    node.removeFromParent()
                }
            } // if not nil
        } // for each node
        
        
        UISRBlob0Name.text=blob!.generateName()
        UISRBlob1Name.text=blob2!.generateName()
        
        let level1=SKLabelNode(text: "\(blob!.computeLevel())")
        let level2=SKLabelNode(text: "\(blob2!.computeLevel())")

        
        
        level1.position.x = -size.width*0.25
        level1.position.y = size.height*0.215
        level1.fontColor=NSColor.cyan
        level1.fontName="Arial-BoldMT"
        level1.fontSize=30
        level1.zPosition=110
        level1.name="UIlevelName0"
        UIscoutingReportBG.addChild(level1)
        
        level2.position.x = size.width*0.25
        level2.position.y = size.height*0.215
        level2.fontColor=NSColor.cyan
        level2.fontName="Arial-BoldMT"
        level2.fontSize=30
        level2.zPosition=110
        level2.name="UIlevelName1"
        UIscoutingReportBG.addChild(level2)
        
        // Speed
        let speedRatio1=CGFloat(blob!.tripToDec(trip: blob!.getGene(num: 24)))/63
        let speedStars1=Int(5*speedRatio1)-1
        let speedRatio2=CGFloat(blob2!.tripToDec(trip: blob2!.getGene(num: 24)))/63
        let speedStars2=Int(5*speedRatio2)-1
        
        if speedStars1 > -1
        {
            for i in 0...speedStars1
            {
                let star=SKSpriteNode(imageNamed: "UIstar")
                star.setScale(0.5)
                star.position.y=size.height*0.125
                star.position.x = (-CGFloat(i)*(star.size.width*1.5))-size.width*0.2
                star.zPosition=101
                star.name="UISRstar"
                UIscoutingReportBG.addChild(star)
            } // for speed
        }
        if speedStars2 > -1
        {
            for i in 0...speedStars2
            {
                let star2=SKSpriteNode(imageNamed: "UIstar")
                star2.setScale(0.5)
                star2.position.y=size.height*0.125
                star2.position.x = (CGFloat(i)*(star2.size.width*1.5))+size.width*0.2
                star2.zPosition=101
                star2.name="UISRstar"
                UIscoutingReportBG.addChild(star2)
            } // for speedh
        }
        // Damage
        let damRatio1=CGFloat(blob!.tripToDec(trip: blob!.getGene(num: 34))) / 63
        let damStars1=Int(5*damRatio1)-1
        let damRatio2=CGFloat(blob2!.tripToDec(trip: blob2!.getGene(num: 34))) / 63
        let damStars2=Int(5*damRatio2)-1
        
        print("Damage: \(blob!.tripToDec(trip: blob!.getGene(num: 34)))")
        print("Stars: \(damStars1)")
        print("Damage Ratio: \(damRatio1)")
        
        if damStars1 > -1
        {
            for i in 0...damStars1
            {
                let star=SKSpriteNode(imageNamed: "UIstar")
                star.setScale(0.5)
                star.position.y=size.height*0.06
                star.position.x = (-CGFloat(i)*(star.size.width*1.5))-size.width*0.2
                star.zPosition=101
                star.name="UISRstar"
                UIscoutingReportBG.addChild(star)
                print("*")
            } // for damage1
        } // if we have stars
        if damStars2 > -1
        {
            for i in 0...damStars2
            {
                let star2=SKSpriteNode(imageNamed: "UIstar")
                star2.setScale(0.5)
                star2.position.y=size.height*0.06
                star2.position.x = (CGFloat(i)*(star2.size.width*1.5))+size.width*0.2
                star2.zPosition=101
                star2.name="UISRstar"
                UIscoutingReportBG.addChild(star2)
            } // for damage2
        } // if we have stars
        
        // health
        let healthRatio1=CGFloat(blob!.tripToDec(trip: blob!.getGene(num: 32))) / 63
        let healthStars1=Int(5*healthRatio1)-1
        let healthRatio2=CGFloat(blob2!.tripToDec(trip: blob2!.getGene(num: 32))) / 63
        let healthStars2=Int(5*healthRatio2)-1
        

        
        if healthStars1 > -1
        {
            for i in 0...healthStars1
            {
                let star=SKSpriteNode(imageNamed: "UIstar")
                star.setScale(0.5)
                star.position.y = -size.height*0.015
                star.position.x = (-CGFloat(i)*(star.size.width*1.5))-size.width*0.2
                star.zPosition=101
                star.name="UISRstar"
                UIscoutingReportBG.addChild(star)
                print("*")
            } // for damage1
        } // if we have stars
        if healthStars2 > -1
        {
            for i in 0...healthStars2
            {
                let star2=SKSpriteNode(imageNamed: "UIstar")
                star2.setScale(0.5)
                star2.position.y = -size.height*0.015
                star2.position.x = (CGFloat(i)*(star2.size.width*1.5))+size.width*0.2
                star2.zPosition=101
                star2.name="UISRstar"
                UIscoutingReportBG.addChild(star2)
            } // for damage2
        } // if we have stars
        
        
        // Attacks
        
        
        // Defenses
        
        // Sonic
        let sonicIcon=SKSpriteNode(imageNamed: "sonicIcon")
        sonicIcon.position.x = -size.width*0.2
        sonicIcon.position.y = -size.height*0.2
        sonicIcon.zPosition=101
        sonicIcon.setScale(0.5)
        sonicIcon.colorBlendFactor=1.0
        sonicIcon.name="UISRsonicIcon"
        UIscoutingReportBG.addChild(sonicIcon)
        let sonic1=blob!.sonicResist
        if sonic1 > 0.66
        {
            sonicIcon.color=NSColor.red
        }
        else if sonic1 > 0.33
        {
            sonicIcon.color=NSColor.yellow
        }
        else
        {
            sonicIcon.color=NSColor.green
        }
        
        let sonicIcon2=SKSpriteNode(imageNamed: "sonicIcon")
        sonicIcon2.position.x = size.width*0.2
        sonicIcon2.position.y = -size.height*0.2
        sonicIcon2.zPosition=101
        sonicIcon2.setScale(0.5)
        sonicIcon2.colorBlendFactor=1.0
        sonicIcon2.name="UISRsonicIcon"
        UIscoutingReportBG.addChild(sonicIcon2)
        let sonic2=blob2!.sonicResist
        if sonic2 > 0.66
        {
            sonicIcon2.color=NSColor.red
        }
        else if sonic2 > 0.33
        {
            sonicIcon2.color=NSColor.yellow
        }
        else
        {
            sonicIcon2.color=NSColor.green
        }
        
        // Physical
        let physicalIcon=SKSpriteNode(imageNamed: "physicalIcon")
        physicalIcon.setScale(0.5)
        physicalIcon.position.x = -size.width*0.2 - physicalIcon.size.width
        physicalIcon.position.y = -size.height*0.2
        physicalIcon.zPosition=101
        
        physicalIcon.colorBlendFactor=1.0
        physicalIcon.name="UISRphysicalIcon"
        UIscoutingReportBG.addChild(physicalIcon)
        let phys1=blob!.physicalResist
        if phys1 > 0.66
        {
            physicalIcon.color=NSColor.red
        }
        else if phys1 > 0.33
        {
            physicalIcon.color=NSColor.yellow
        }
        else
        {
            physicalIcon.color=NSColor.green
        }
        
        let physicalIcon2=SKSpriteNode(imageNamed: "physicalIcon")
        physicalIcon2.setScale(0.5)
        physicalIcon2.position.x = size.width*0.2 + physicalIcon2.size.width
        physicalIcon2.position.y = -size.height*0.2
        physicalIcon2.zPosition=101

        physicalIcon2.colorBlendFactor=1.0
        physicalIcon2.name="UISRphysicalIcon2"
        UIscoutingReportBG.addChild(physicalIcon2)
        let phys2=blob2!.physicalResist
        if phys2 > 0.66
        {
            physicalIcon2.color=NSColor.red
        }
        else if phys2 > 0.33
        {
            physicalIcon2.color=NSColor.yellow
        }
        else
        {
            physicalIcon2.color=NSColor.green
        }
        
        // Electrical
        let electricalIcon=SKSpriteNode(imageNamed: "electricalIcon")
        electricalIcon.setScale(0.5)
        electricalIcon.position.x = -size.width*0.2 - 2*electricalIcon.size.width
        electricalIcon.position.y = -size.height*0.2
        electricalIcon.zPosition=101
        
        electricalIcon.colorBlendFactor=1.0
        electricalIcon.name="UISRelectricalIcon"
        UIscoutingReportBG.addChild(electricalIcon)
        let elec=blob!.electricalResist
        if elec > 0.66
        {
            electricalIcon.color=NSColor.red
        }
        else if elec > 0.33
        {
            electricalIcon.color=NSColor.yellow
        }
        else
        {
            electricalIcon.color=NSColor.green
        }
        
        let electricalIcon2=SKSpriteNode(imageNamed: "electricalIcon")
        electricalIcon2.setScale(0.5)
        electricalIcon2.position.x = size.width*0.2 + 2*electricalIcon2.size.width
        electricalIcon2.position.y = -size.height*0.2
        electricalIcon2.zPosition=101
        
        electricalIcon2.colorBlendFactor=1.0
        electricalIcon2.name="UISRelectricalIcon2"
        UIscoutingReportBG.addChild(electricalIcon2)
        let elec2=blob2!.electricalResist
        if elec2 > 0.66
        {
            electricalIcon2.color=NSColor.red
        }
        else if elec2 > 0.33
        {
            electricalIcon2.color=NSColor.yellow
        }
        else
        {
            electricalIcon2.color=NSColor.green
        }
        
        // Poison
        let poisonIcon=SKSpriteNode(imageNamed: "poisonIcon")
        poisonIcon.setScale(0.5)
        poisonIcon.position.x = -size.width*0.2 - 3*electricalIcon.size.width
        poisonIcon.position.y = -size.height*0.2
        poisonIcon.zPosition=101
        
        poisonIcon.colorBlendFactor=1.0
        poisonIcon.name="UISRpoisonIcon"
        UIscoutingReportBG.addChild(poisonIcon)
        let poison=blob!.poisonResist
        if poison > 0.66
        {
            poisonIcon.color=NSColor.red
        }
        else if poison > 0.33
        {
            poisonIcon.color=NSColor.yellow
        }
        else
        {
            poisonIcon.color=NSColor.green
        }
        
        let poisonIcon2=SKSpriteNode(imageNamed: "poisonIcon")
        poisonIcon2.setScale(0.5)
        poisonIcon2.position.x = size.width*0.2 + 3*poisonIcon2.size.width
        poisonIcon2.position.y = -size.height*0.2
        poisonIcon2.zPosition=101
        
        poisonIcon2.colorBlendFactor=1.0
        poisonIcon2.name="UISRpoisonIcon2"
        UIscoutingReportBG.addChild(poisonIcon2)
        let poison2=blob2!.poisonResist
        if poison2 > 0.66
        {
            poisonIcon2.color=NSColor.red
        }
        else if poison2 > 0.33
        {
            poisonIcon2.color=NSColor.yellow
        }
        else
        {
            poisonIcon2.color=NSColor.green
        }
        
    } // func drawScoutScreen
    
    
    
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
    
    func drawArenaEdge()
    {
        let edgeRect=CGRect(x: 0, y: 0, width: 640, height: 20)
        arenaEdge=SKShapeNode(rect: edgeRect)
        arenaEdge.fillColor=NSColor.white
        arenaEdge.strokeColor=NSColor.white
        arenaEdge.position=CGPoint(x: -edgeRect.width/2, y: 740)
        arenaEdge.physicsBody=SKPhysicsBody(rectangleOf: CGSize(width: edgeRect.width, height: edgeRect.height), center: CGPoint(x: edgeRect.width/2, y:edgeRect.height/2))
        arenaEdge.physicsBody?.collisionBitMask=PHYSICSTYPES.BLOB
        arenaEdge.physicsBody!.categoryBitMask=PHYSICSTYPES.WALL
        arenaEdge.physicsBody!.contactTestBitMask=PHYSICSTYPES.BLOB
        arenaEdge.physicsBody!.isDynamic=false
        arenaEdge.alpha=CGFloat.leastNonzeroMagnitude
        arenaEdge.name="wall"
        arenaBorder.addChild(arenaEdge)
        
        let bottom=arenaEdge.copy() as! SKShapeNode
        bottom.position.y = -760
        arenaBorder.addChild(bottom)
        
        let right=arenaEdge.copy() as! SKShapeNode
        right.zRotation=CGFloat.pi/2
        right.alpha=CGFloat.leastNonzeroMagnitude
        right.position.x = 760
        right.position.y = -320
        arenaBorder.addChild(right)
        
        let left=arenaEdge.copy() as! SKShapeNode
        left.zRotation=CGFloat.pi/2
        left.position.x = -740
        left.position.y = -320
        left.alpha=CGFloat.leastNonzeroMagnitude
        arenaBorder.addChild(left)
        
        let topleft=arenaEdge.copy() as! SKShapeNode
        topleft.zRotation=CGFloat.pi/4
        topleft.position.x = -740
        topleft.position.y = 300
        topleft.alpha=CGFloat.leastNonzeroMagnitude
        arenaBorder.addChild(topleft)
        
        let bottomright=arenaEdge.copy() as! SKShapeNode
        bottomright.zRotation = -3*CGFloat.pi/4
        bottomright.position.x = 740
        bottomright.position.y = -300
        bottomright.alpha=CGFloat.leastNonzeroMagnitude
        arenaBorder.addChild(bottomright)
        
        let topright=arenaEdge.copy() as! SKShapeNode
        topright.zRotation = 3*CGFloat.pi/4
        topright.position.x = 760
        topright.position.y = 320
        topright.alpha=CGFloat.leastNonzeroMagnitude
        arenaBorder.addChild(topright)
        
        let bottomleft=arenaEdge.copy() as! SKShapeNode
        bottomleft.zRotation = -CGFloat.pi/4
        bottomleft.position.x = -760
        bottomleft.position.y = -320
        bottomleft.alpha=CGFloat.leastNonzeroMagnitude
        arenaBorder.addChild(bottomleft)
    } // func drawArenaEdge
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("Contacting!")
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //print("Logical & blob = \(firstBody.categoryBitMask & PHYSICSTYPES.BLOB)")
        //print("Logical & wall = \(secondBody.categoryBitMask & PHYSICSTYPES.WALL)")
        

        if (firstBody.categoryBitMask & PHYSICSTYPES.BLOB != 0) && (secondBody.categoryBitMask & PHYSICSTYPES.WALL != 0)
        {

            // get angle to center
            let angle=atan2(-firstBody.node!.position.y, -firstBody.node!.position.x)
            print("Angle to center: \(angle)")
            let dx=cos(angle)*500
            let dy=sin(angle)*500
            if (firstBody.node!.name! == "blob0")
            {
                blob!.speed=0
            }
            else if firstBody.node!.name!=="blob1"
            {
                blob2!.speed=0
            }
            firstBody.applyImpulse(CGVector(dx: dx, dy: dy))
            
            let spinspeed=random(min: -CGFloat.pi*1.5, max: CGFloat.pi*1.5)
            firstBody.applyAngularImpulse(spinspeed)
            
            let sparks=SKEmitterNode(fileNamed: "wallSparks")
            let sparkAction=SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.removeFromParent()])
            addChild(sparks!)
            sparks!.run(sparkAction)
            sparks!.position=contact.contactPoint
            //print("Wall Collision")
        
        } // if contact with wall

        if (firstBody.node!.name!.contains("blob")) && (secondBody.node!.name!.contains("blob"))
        {
            let blob1BaseDam=(blob!.getStandardDamage(against: blob2!)/3)
            let blob2BaseDam=(blob2!.getStandardDamage(against: blob!)/3)
            
            let blob1SpeedDamage=(blob!.getVelocity()/250*blob!.getStandardDamage(against: blob2!))
            let blob2SpeedDamage=(blob2!.getVelocity()/250*blob2!.getStandardDamage(against: blob!))
            
            let blob1Dam=blob1BaseDam+blob1SpeedDamage
            let blob2Dam=blob2BaseDam+blob2SpeedDamage
            blob!.health -= blob2Dam
            damageLabel(blobNum: 0, Amount: blob2Dam, Resist: blob2!.getEnemyResist(against: blob!))
            blob2!.health -= blob1Dam
            damageLabel(blobNum: 1, Amount: blob1Dam, Resist: blob!.getEnemyResist(against: blob2!))
            
            print("Blob 1 damage: \(blob1BaseDam) + \(blob1SpeedDamage)")
            print("Blob 1 speed: \(blob!.getVelocity())")
            print("Blob 2 damage: \(blob2BaseDam) + \(blob2SpeedDamage)")
            print("Blob 2 speed: \(blob2!.getVelocity())")
            let sparks=SKEmitterNode(fileNamed: "wallSparks")
            let sparkAction=SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.removeFromParent()])
            addChild(sparks!)
            sparks!.particleColorSequence=nil
            sparks!.particleColorBlendFactor=1.0
            sparks!.particleColor=NSColor.red
            sparks!.run(sparkAction)
            sparks!.position=contact.contactPoint
            
            let dx1=contact.contactPoint.x - firstBody.node!.position.x
            let dy1=contact.contactPoint.y - firstBody.node!.position.y

            let dx2=contact.contactPoint.x - secondBody.node!.position.x
            let dy2=contact.contactPoint.y - secondBody.node!.position.y

            
            firstBody.applyImpulse(CGVector(dx: -dx1*2, dy: -dy1*2))
            secondBody.applyImpulse(CGVector(dx: -dx2*2, dy: -dy2*2))
        } // if contact with another blob
        
         if (firstBody.categoryBitMask & PHYSICSTYPES.BLOB != 0) && (secondBody.categoryBitMask & PHYSICSTYPES.LIGHTNING != 0)
        {
            let parent=secondBody.node!.parent
            
            if parent!.name=="blob0" && firstBody.node!.name=="blob1"
            {
                let damage = blob!.blobDamage*blob2!.electricalResist
                blob2!.health -= damage
                damageLabel(blobNum: 1, Amount: damage, Resist: blob2!.electricalResist)
                print("Hit blob2")
            }
            else if parent!.name=="blob1" && firstBody.node!.name=="blob0"
            {
                let damage=blob2!.blobDamage*blob!.electricalResist
                blob!.health -= damage
                damageLabel(blobNum: 0, Amount: damage, Resist: blob!.electricalResist)
                print("Hit blob1")
            }

        } // if Lightning hits a blob
        
        if (firstBody.categoryBitMask & PHYSICSTYPES.BLOB != 0) && (secondBody.categoryBitMask & PHYSICSTYPES.ELECTRICWAVE != 0)
        {
            let parent=secondBody.node!.parent
            
            if parent!.name=="blob0" && firstBody.node!.name=="blob1"
            {
                let damage=blob!.blobDamage*blob2!.electricalResist
                blob2!.health -= damage
                damageLabel(blobNum: 1, Amount: damage, Resist: blob2!.electricalResist)
                print("Hit blob2")
            }
            else if parent!.name=="blob1" && firstBody.node!.name=="blob0"
            {
                let damage = blob2!.blobDamage*blob!.electricalResist
                blob!.health -= damage
                damageLabel(blobNum: 0, Amount: damage, Resist: blob!.electricalResist)
                print("Hit blob1")
            }
            
        } // if Electric Wave hits a blob
        
        if (firstBody.categoryBitMask & PHYSICSTYPES.BLOB != 0) && (secondBody.categoryBitMask & PHYSICSTYPES.VIRUS != 0)
        {
            let parent=secondBody.node!.parent
            
            if firstBody.node!.name=="blob1"
            {
                let posx=contact.contactPoint.x-blob2!.sprite.position.x
                let posy=contact.contactPoint.y-blob2!.sprite.position.y
                let ang=secondBody.node!.zRotation
                secondBody.node!.removeFromParent()
                let virus=SKSpriteNode(imageNamed: "virus01")
                blob2!.sprite.addChild(virus)
                virus.name="Virus"
                virus.position=CGPoint(x: posx, y: posy)
                virus.zRotation=ang
                //blob2!.health -= blob!.blobDamage*blob2!.electricalResist
                print("Virus Hit blob2")
            }
            else if firstBody.node!.name=="blob0"
            {
                let posx=contact.contactPoint.x-blob!.sprite.position.x
                let posy=contact.contactPoint.y-blob!.sprite.position.y
                let ang=secondBody.node!.zRotation
                secondBody.node!.removeFromParent()
                let virus=SKSpriteNode(imageNamed: "virus01")
                blob!.sprite.addChild(virus)
                virus.name="Virus"
                virus.position=CGPoint(x: posx, y: posy)
                virus.zRotation=ang
                //blob2!.health -= blob!.blobDamage*blob2!.electricalResist
                print("Virus Hit blob1")
            }
            
        } // if Electric Wave hits a blob
        
        
        if (firstBody.categoryBitMask & PHYSICSTYPES.BLOB != 0) && (secondBody.categoryBitMask & PHYSICSTYPES.SONICWAVE != 0)
        {
            let parent=secondBody.node!.parent
            
            if parent!.name=="blob0" && firstBody.node!.name=="blob1"
            {
                let damage=blob!.blobDamage*blob2!.sonicResist
                blob2!.health -= damage
                damageLabel(blobNum: 1, Amount: damage, Resist:blob2!.sonicResist)
                print("Sonic wave resist: \(blob2!.sonicResist)")
                let dx=blob2!.sprite.position.x-contact.contactPoint.x
                let dy=blob2!.sprite.position.y-contact.contactPoint.y
                let ang=atan2(dy,dx)
                let vecx=cos(ang)*1000
                let vecy=sin(ang)*1000
                blob2!.speed=0
                blob2!.sprite.physicsBody!.applyImpulse(CGVector(dx: vecx, dy: vecy))
            }
            else if parent!.name=="blob1" && firstBody.node!.name=="blob0"
            {
                let damage=blob2!.blobDamage*blob!.sonicResist
                blob!.health -= damage
                damageLabel(blobNum: 0, Amount: damage, Resist: blob!.sonicResist)
                print("Sonic wave resist: \(blob!.sonicResist)")
                let dx=blob!.sprite.position.x-contact.contactPoint.x
                let dy=blob!.sprite.position.y-contact.contactPoint.y
                let ang=atan2(dy,dx)
                let vecx=cos(ang)*1000
                let vecy=sin(ang)*1000
                blob!.speed=0
                blob!.sprite.physicsBody!.applyImpulse(CGVector(dx: vecx, dy: vecy))
            } // if parent
        
        } // if sonic wave hits a blob
        

        
    } // func didBegin -- physics contact
    
    func checkCloudDamage()
    {
        for node in blob!.sprite.physicsBody!.allContactedBodies()
        {
            if node.categoryBitMask==PHYSICSTYPES.POISONCLOUD
            {
                if node.node!.name!.contains("1") && -blob!.lastCloudDamage.timeIntervalSinceNow > CLOUDINTERVAL
                {
                    let damage=(blob2!.blobDamage*blob!.poisonResist)/2
                    damageLabel(blobNum: 0, Amount: damage, Resist: blob!.poisonResist)
                    blob!.health -= damage
                    blob!.lastCloudDamage=NSDate()
                } // if dropped by blob 1
            } // if it's a poison cloud
        } // for each node
        
        for node in blob2!.sprite.physicsBody!.allContactedBodies()
        {
            if node.categoryBitMask==PHYSICSTYPES.POISONCLOUD
            {
                if node.node!.name!.contains("0") && -blob2!.lastCloudDamage.timeIntervalSinceNow > CLOUDINTERVAL
                {
                    let damage=(blob!.blobDamage*blob2!.poisonResist)/2
                    damageLabel(blobNum: 1, Amount: damage, Resist: blob2!.poisonResist)
                    blob2!.health -= damage
                    blob2!.lastCloudDamage=NSDate()
                } // if dropped by blob 0
            } // if it's a poison cloud
        } // for each node
    } // func checkCloudDamage()
    
    func damageLabel(blobNum: Int, Amount: CGFloat, Resist: CGFloat)
    {
        if blobNum==0
        {
            let blob1Damage=SKLabelNode(text: "Blob1Damage")
            blob1Damage.fontColor=NSColor.red
            blob1Damage.fontName="Arial-BoldMT"
            blob1Damage.fontSize=64
            blob1Damage.alpha=0
            blob1Damage.name="BlobDamage"
            blob1Damage.zPosition=blob!.sprite.zPosition+10
            addChild(blob1Damage)

            blob1Damage.text=String(format:"-%2.0f (%2.0f%% Resist)",Amount, 100-(Resist*100))
            print("Blob 1 Resist: \(Resist*100)")
            blob1Damage.position.x=blob!.sprite.position.x
            blob1Damage.position.y=blob!.sprite.position.y + 160
            blob1Damage.run(SKAction.moveBy(x: random(min: -60, max: 60), y: random(min: 250, max: 300), duration: 2.0))
            blob1Damage.run(damageLabelAction)
        } // if blob 0
        if blobNum==1
        {
            let blob2Damage=SKLabelNode(text: "Blob2Damage")
            
            blob2Damage.fontColor=NSColor.systemBlue
            blob2Damage.fontName="Arial-BoldMT"
            blob2Damage.fontSize=64
            blob2Damage.alpha=0
            blob2Damage.zPosition=blob2!.sprite.zPosition+10
            blob2Damage.name="BlobDamage"
            addChild(blob2Damage)
            blob2Damage.text=String(format:"-%2.0f (%2.0f%% Resist)",Amount, 100-(Resist*100))
            print("Blob 2 Resist: \(Resist*100)")
            blob2Damage.position.x=blob2!.sprite.position.x
            blob2Damage.position.y=blob2!.sprite.position.y + 160
            blob2Damage.run(SKAction.moveBy(x: random(min: -60, max: 60), y: random(min: 250, max: 300), duration: 2.0))
            blob2Damage.run(damageLabelAction)
        } // if blob 1
        
    } // func damageLabel()
    
    func genNewArena()
    {
        
        let arenaColor=NSColor(calibratedRed: random(min: 0.25, max: 1.0), green: random(min: 0.25, max: 1.0), blue: random(min: 0.25, max: 1.0), alpha: 1.0)
        
        clutterNode!.particleColor=arenaColor
        arenaBorder.color=arenaColor

        

        arenaFloor.color=arenaColor
        let floorNum=Int(random(min: 1, max: 9.99999999))
        arenaFloor.texture=SKTexture(imageNamed: "octofloor0\(floorNum)")
  
    } // func genNewArena
    
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
        redrawScoutScreen()
        //remove existing DNA Strand
        for node in frame2.children
        {
            if node.name!.contains("DNA")
            {
                node.removeFromParent()
            }
        } // for each node
        for node in frame1 .children
        {
            if node.name!.contains("DNA")
            {
                node.removeFromParent()
            }
        } // for each node
        
        blob1Level.text="Level: \(blob!.computeLevel())"
        print("Level: \(blob!.computeLevel())")
        blob2Level.text="Level: \(blob2!.computeLevel())"
        babyLevel.text="Level: \(baby!.computeLevel())"
        
        
        //blob.sprite.removeAllActions()
        blob!.scene=self
        blob2!.scene=self
        baby!.scene=self
        
        let coded=blob!.DNA
        for i in 0..<blob!.GENECOUNT*blob!.GENESIZE
        {
            let dna=SKSpriteNode(imageNamed: "DNA_2")
            dna.name=String(format: "DNA%03d",i)
            dna.setScale(0.65)
            dna.position.y = 30
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
            frame2.addChild(dna)
            
            // for number label
            if i%3==1
            {
                let geneNum=Int(i/3)
                var geneLabel=SKLabelNode()
                //let geneLabel=SKLabelNode(text: "\(geneNum)")
                
                if (showGeneName)
                {
                    if geneNum < blob!.GeneStrings.count
                    {
                        geneLabel=SKLabelNode(text: blob!.GeneStrings[geneNum])
                    }
                    else
                    {
                       geneLabel=SKLabelNode(text: "\(geneNum)")
                    }
                    geneLabel.name="DNALabel"
                    geneLabel.position.y=0
                    geneLabel.fontColor=NSColor.white
                    geneLabel.fontSize=14
                    geneLabel.zPosition=12
                    geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                    frame2.addChild(geneLabel)
                } // if showGeneName is on
                else
                {
                    geneLabel=SKLabelNode(text: "\(geneNum)")
                    geneLabel.name="DNALabel"
                    geneLabel.position.y=0
                    geneLabel.fontColor=NSColor.white
                    geneLabel.fontSize=14
                    geneLabel.zPosition=12
                    geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                    frame2.addChild(geneLabel)
                } // if showGeneName is Off
            }
        } // for each chromosome
        
        let coded2=blob2!.DNA
        for i in 0..<blob2!.GENECOUNT*blob2!.GENESIZE
        {
            let dna=SKSpriteNode(imageNamed: "DNA_2")
            dna.name=String(format: "DNA%03d",i)
            dna.setScale(0.65)
            dna.position.y = -30
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
            frame2.addChild(dna)
            dna.zPosition=10
        }
        
        // draw baby DNA
        if !baby!.sprite.isHidden
        {
            let coded3=baby!.DNA
            for i in 0..<baby!.GENECOUNT*baby!.GENESIZE
            {
                let dna=SKSpriteNode(imageNamed: "DNA_2")
                dna.name=String(format: "DNA%03d",i)
                dna.setScale(0.65)
                dna.position.y = 0
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
                frame1.addChild(dna)
                dna.zPosition=10
                

                // for number label
                if i%3==1
                {
                    let geneNum=Int(i/3)
                    var geneLabel=SKLabelNode()
                    //let geneLabel=SKLabelNode(text: "\(geneNum)")
                    
                    if (showGeneName)
                    {
                        if geneNum < blob!.GeneStrings.count
                        {
                            geneLabel=SKLabelNode(text: blob!.GeneStrings[geneNum])
                        }
                        else
                        {
                            geneLabel=SKLabelNode(text: "\(geneNum)")
                        }
                        geneLabel.name="DNALabel"
                        geneLabel.position.y = 30
                        geneLabel.fontColor=NSColor.white
                        geneLabel.fontSize=14
                        geneLabel.zPosition=12
                        geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                        frame1.addChild(geneLabel)
                    } // if showGeneName is on
                    else
                    {
                        geneLabel=SKLabelNode(text: "\(geneNum)")
                        geneLabel.name="DNALabel"
                        geneLabel.position.y = 30
                        geneLabel.fontColor=NSColor.white
                        geneLabel.fontSize=14
                        geneLabel.zPosition=12
                        geneLabel.position.x=strandOffset+(CGFloat(i)*dna.size.width*0.6)+(CGFloat(i/3)*20)
                        frame1.addChild(geneLabel)
                    } // if showGeneName is Off
                }
            } // for each gene
        }// if baby isn't hidden
    } // func drawDNAStrand
    

    
    func touchDown(atPoint pos : CGPoint) {

        for thisNode in self.nodes(at: pos)
        {
            if thisNode.name != nil
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
                    blob2!.generateNewGene(at: geneNum)
                    blob2!.resetSprite()
                }
                else
                {
                    blob!.generateNewGene(at: geneNum)
                    blob!.resetSprite()
                }
                drawDNAStrand()
                baby!.sprite.isHidden=true
                
            } // if node is DNA
            if thisNode.name!.contains("blob0")
            {
                selected=0
            }
            else if thisNode.name!.contains("blob1")
            {
                selected=1
            }
            
            if !saveFrame.isHidden
            {
                if thisNode.name!.contains("save01")
                {
                    if selected==0
                    {
                        blob!.DNA=saves[0]
                        blob!.resetSprite()
                        drawDNAStrand()
                    } // if blob 1
                    else if selected==1
                    {
                        blob2!.DNA=saves[0]
                        blob2!.resetSprite()
                        
                        drawDNAStrand()
                        
                    } // if blob 2
                } // if click on save #1
                if thisNode.name!.contains("save02")
                {
                    if selected==0
                    {
                        blob!.DNA=saves[1]
                        blob!.resetSprite()
                        drawDNAStrand()
                    } // if blob 1
                    else if selected==1
                    {
                        blob2!.DNA=saves[1]
                        blob2!.resetSprite()
                        drawDNAStrand()
                        
                    } // if blob 2
                } // if click on save #2
                if thisNode.name!.contains("save03")
                {
                    if selected==0
                    {
                        blob!.DNA=saves[2]
                        blob!.resetSprite()
                        drawDNAStrand()
                    } // if blob 1
                    else if selected==1
                    {
                        blob2!.DNA=saves[2]
                        blob2!.resetSprite()
                        drawDNAStrand()
                        
                    } // if blob 2
                } // if click on save #2
            }
            } // if the name isn't nil
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

            
        case 0:     // a
            
            if gameState==GAMESTATES.FIGHT
            {
                leftPressed=true
            }
        case 1:     // s
            if gameState==GAMESTATES.FIGHT
            {
                downPressed=true
            }
        case 2:     // d
            if gameState==GAMESTATES.FIGHT
            {
                rightPressed=true
            }
        case 13:    // w
            if gameState==GAMESTATES.FIGHT
            {
                upPressed=true
            }
        case 3:     // f - switch between fight and breed
            if gameState==GAMESTATES.FIGHT
            {
                gameState=GAMESTATES.BREED
                blob!.sprite.position=CGPoint(x: -size.height*0.40, y: 0)
                blob2!.sprite.position=CGPoint(x: size.height*0.40, y: 0)
                blob!.sprite.physicsBody!.velocity = .zero
                blob2!.sprite.physicsBody!.velocity = .zero
                cam.position = .zero
                endBattle()
            }
            else if gameState==GAMESTATES.BREED
            {
 
                startBattle()
            }
        case 4:
            if showHUD
            {
                showHUD=false
            }
            else
            {
                showHUD=true
            }
            
        case 11:        // m - proc blend textures
            if showHUD
            {
                let temp=blob!.breed(with: blob2!)
                baby!.DNA=temp.DNA
                baby!.resetSprite()
                blob!.scene=self
                blob2!.scene=self
                baby!.scene=self
                baby!.sprite.isHidden=false
                baby!.sprite.position=CGPoint(x: 0, y: 0)
                drawDNAStrand()
                let levels=blob!.computeLevel()+blob2!.computeLevel()
                money -= (levels*BREEDCOST)+BREEDCOSTBASE
                let chance=random(min: 0, max: 1)
                if chance > 0.95
                {
                    baby!.sprite.texture=blendTextures(first: blob!, second: blob2!)
                }
            }
        case 24:        // + zoom in
            if gameState==GAMESTATES.FIGHT
            {
                zoomInPressed=true
            }
        case 27:        // - zoom out
            if gameState==GAMESTATES.FIGHT
            {
                zoomOutPressed=true
            }
            
        case 28:        // 8 - toggle scouting report
            if UIscoutingReportBG.isHidden
            {
                redrawScoutScreen()
                UIscoutingReportBG.isHidden=false
            }
            else
            {
                UIscoutingReportBG.isHidden=true
            }
        case 29:        // 0 - toggle gene names
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

            blob2!.genNewDNA()
            blob2!.generateByLevel(level: 10)
            baby!.sprite.isHidden=true
            drawDNAStrand()
            money -= BREEDCOST
            
        case 33:    // [ - Limit blob 1 to less than level 10

            blob!.genNewDNA()
            blob!.generateByLevel(level: 10)
            baby!.sprite.isHidden=true
            drawDNAStrand()
            money -= BREEDCOST
            
        case 18:
            if saveFrame.isHidden
            {
                blob!.genNewDNA()
                
                baby!.sprite.isHidden=true
                drawDNAStrand()
                money -= BREEDCOST
                let proc1Chance=random(min: 0, max: 1)
                if proc1Chance > 0.8
                {
                    //blob!.sprite.texture=createProcTexture()
                    
                }
                blob!.resetSprite()
                redrawScoutScreen()
            } // if not saving
            else
            {
                saves[0]=baby!.DNA
                print(saves[0])
                self.isPaused=true
                let temp=self.view!.texture(from: baby!.sprite)
                self.isPaused=false
                savesPreview[0]=temp!
                save01.texture=savesPreview[0]
                
            }
        case 19:
            if saveFrame.isHidden
            {
                blob2!.genNewDNA()
                blob2!.resetSprite()
                baby!.sprite.isHidden=true
                drawDNAStrand()
                money -= BREEDCOST
                let proc2Chance=random(min: 0, max: 1)
                if proc2Chance > 0.8
                {
                    blob2!.sprite.texture=createProcTexture()
                    
                }
                redrawScoutScreen()
            } // if not saving
            else
            {
                saves[1]=baby!.DNA
                print(saves[1])
                self.isPaused=true
                let temp=self.view!.texture(from: baby!.sprite)
                self.isPaused=false
                savesPreview[1]=temp!
                save02.texture=savesPreview[1]
            }
        case 20:
            if !saveFrame.isHidden
            {
                saves[2]=baby!.DNA
                print(saves[2])
                self.isPaused=true
                let temp=self.view!.texture(from: baby!.sprite)
                self.isPaused=false
                savesPreview[2]=temp!
                save03.texture=savesPreview[2]
            }
            

        case 34:
            print("Baby Speed: \(baby!.moveSpeed)")
            print("Baby Health: \(baby!.blobHealth)")
            print("Baby Damage: \(baby!.blobDamage)")
            print("Baby Level: \(baby!.computeLevel())")
        
        case 35:
            
            blob!.genNewDNA()
            blob2!.genNewDNA()
            baby!.sprite.isHidden=true
            //changeBlobColor()
            drawDNAStrand()
            money -= BREEDCOST
            blob!.sprite.texture=createProcTexture()
            blob2!.sprite.texture=createProcTexture()
        case 36:
            if saveFrame.isHidden
            {
                saveFrame.isHidden=false
            }
            else
            {
                saveFrame.isHidden=true
            }
            
        case 41:        // ; - set blob special attacks - testing
            blob!.replaceGene(at: 52, with: "RYY")
            blob2!.replaceGene(at: 52, with: "BRG")
            blob!.resetSprite()
            blob2!.resetSprite()
            drawDNAStrand()
            
        case 43:
            scrollLeftPressed=true
            
        case 47:
            scrollRightPressed=true
            
            
        case 45:

            baby!.replaceGene(at: 3, with: "RRR")
            baby!.resetSprite()
            drawDNAStrand()
            
        case 46:        // M - spawn baby with blended texture
            
            if (showHUD)
            {
                let temp=blob!.breed(with: blob2!)

                baby!.DNA=temp.DNA

                
                baby!.sprite.isHidden=false
                baby!.resetSprite()
                baby!.sprite.texture=blendTextures(first: blob!, second: blob2!)
                
                drawDNAStrand()
                
                let levels=blob!.computeLevel()+blob2!.computeLevel()
                money -= (levels*BREEDCOST)+BREEDCOSTBASE
                baby!.age=0.5
                baby!.sprite.position=CGPoint(x: 0, y: 0)
                
            }
        case 49:    // spacebar - spawn 2 new blobs
            
            //genNewArena()
            
            if showHUD
            {

                blob!.genNewDNA()
                blob2!.genNewDNA()
                
                print("Blob 2 DNA: \(blob2!.DNA)")
                baby!.sprite.isHidden=true
                //changeBlobColor()
                drawDNAStrand()
                money -= BREEDCOST
                
                let proc1Chance=random(min: 0, max: 1)
                if proc1Chance > 0.8
                {
                    //blob.sprite.texture=createProcTexture()

                }
                let proc2Chance=random(min: 0, max: 1)
                if proc2Chance>0.8
                {
                    //blob2.sprite.texture=createProcTexture()
                }

                let temp=blob!.threeGenesToDec(gene1: 0, gene2: 1, gene3: 2)
                //print("Three to Dec: \(temp)")
                blob!.resetSprite()
                blob2!.resetSprite()
                print("Blob 1 name: \(blob!.generateName())")
                print("Blob 2 name: \(blob2!.generateName())")
                redrawScoutScreen()
            }
            else
            {
                genNewArena()
            }
        case 123:
            
            blob!.DNA=baby!.DNA
            baby!.sprite.isHidden=true
            let tempTexture=baby!.sprite.texture!
            blob!.resetSprite()
            drawDNAStrand()
            blob!.sprite.texture=tempTexture
        case 124:
            blob2!.DNA=baby!.DNA
            baby!.sprite.isHidden=true
            blob2!.resetSprite()
            let tempTexture=baby!.sprite.texture!
            drawDNAStrand()
            
            blob2!.sprite.texture=tempTexture
            
        case 126:       // up arrow - sell baby
            if !baby!.sprite.isHidden
            {
                money += (baby!.computeLevel()*BREEDCOST)+BREEDCOSTBASE
                baby!.sprite.isHidden=true
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        } // switch
    } // func keyDown
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {

        case 0:     // a
            leftPressed=false
            
        case 1:     // s
            downPressed=false
        case 2:     // d
            rightPressed=false
        case 13:    // w
            upPressed=false

        case 24:        // + zoom in
            zoomInPressed=false
        case 27:        // - zoom out
            zoomOutPressed=false
            
        case 43:        // , - move DNA strand left
            scrollLeftPressed=false
            
        case 47:        // . - move DNA strand right
            scrollRightPressed=false
            
            
        default:
            break
        } // switch
    } // func keyDown
    
    func checkKeys()
    {
        if leftPressed && cam.position.x > -MOVEBOUNDARY
        {
            cam.position.x -= MOVESPEED
        }
        
        if rightPressed && cam.position.x < MOVEBOUNDARY
        {
            cam.position.x += MOVESPEED
        }
        
        if upPressed && cam.position.y < MOVEBOUNDARY
        {
            cam.position.y += MOVESPEED
        }
        
        if downPressed && cam.position.y > -MOVEBOUNDARY
        {
            cam.position.y -= MOVESPEED
        }
        
        
        
        if scrollLeftPressed
        {
            for i in frame2.children
            {
                if i.name!.contains("DNA")
                {
                    i.position.x += MOVESPEED
                    
                }
            }
            for i in frame1.children
            {
                if i.name!.contains("DNA")
                {
                    i.position.x += MOVESPEED
                    
                }
            }
            strandOffset += MOVESPEED
        } // if left
        
        if scrollRightPressed
        {
            for i in frame2.children
            {
                if i.name!.contains("DNA")
                {
                    i.position.x -= MOVESPEED
                    
                }
            }
            for i in frame1.children
            {
                if i.name!.contains("DNA")
                {
                    i.position.x -= MOVESPEED
                    
                }
            }
            strandOffset -= MOVESPEED
        } // if right
        
        if zoomInPressed
        {
            let zoom=cam.xScale
            if zoom > 0.6
            {
                cam.setScale(zoom-0.01)
            }
        }
        
        if zoomOutPressed
        {
            let zoom=cam.xScale
            if zoom < 2.5
            {
                cam.setScale(zoom+0.01)
            }
        }
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
        if baby!.sprite.isHidden
        {
            babyLevel.isHidden=true
            babyGrowthLabel.isHidden=true
        }
        else
        {
            babyLevel.isHidden=false
            babyGrowthLabel.isHidden=false
            babyGrowthLabel.text=String(format: "Growth: %3.2f %", baby!.sprite.xScale*100)
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
        let cost=((blob!.computeLevel()+blob2!.computeLevel())*BREEDCOST)+BREEDCOSTBASE
        breedCostLabel.text="Breeding Cost: $\(cost)"
        
        if showHUD
        {
            frame2.isHidden=false
            frame1.isHidden=false
            breedCostLabel.isHidden=false
            selectArrow.isHidden=false
            moneyLabel.isHidden=false
            
        }
        else
        {
            frame2.isHidden=true
            frame1.isHidden=true
            breedCostLabel.isHidden=true
            selectArrow.isHidden=true
            moneyLabel.isHidden=true
        }
        
        blob1Name.text=blob!.generateName()
        blob2Name.text=blob2!.generateName()
        babyName.text=baby!.generateName()
        
        // move blob labels
        blob1Level.position.x=blob!.sprite.position.x
        blob1Level.position.y=blob!.sprite.position.y+120
        blob2Level.position.x=blob2!.sprite.position.x
        blob2Level.position.y=blob2!.sprite.position.y+120
        blob1Level.text=String(format: "%2.2f",blob!.health)
        blob2Level.text=String(format: "%2.2f",blob2!.health)
        
        blob1Label.position.x=blob!.sprite.position.x
        blob1Label.position.y=blob!.sprite.position.y - 160
        blob1Label.text=String(format: "1 - %2.0d",blob!.computeLevel())
        blob2Label.position.x=blob2!.sprite.position.x
        blob2Label.position.y=blob2!.sprite.position.y - 160
        blob2Label.text=String(format: "2 - %2.0d",blob2!.computeLevel())
    } // func updateUI
    
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
    
    func checkBlobHealth()
    {
        if (blob!.health <= 0)
        {
            gameState=GAMESTATES.BREED
            showHUD=true
            cam.position = .zero
            selected=1
            endBattle()
        }
        
        if blob2!.health <= 0
        {
            gameState=GAMESTATES.BREED
            selected=0
            showHUD=true
            cam.position = .zero
            endBattle()
        }
        
    } // func checkBlobHealth
    
    func startBattle()
    {
        UIscoutingReportBG.isHidden=true
        gameState=GAMESTATES.FIGHT
        blob!.speed=0
        blob2!.speed=0
        cam.run(SKAction.scale(to: 2.0, duration: 0.5))
        blob!.lastSpecialAttack1=NSDate()
        blob2!.lastSpecialAttack1=NSDate()  
        blob!.enemy=blob2!
        blob2!.enemy=blob!
        battleName1.text=blob!.generateName()
        battleName2.text=blob2!.generateName()
        for node in cam.children
        {
            if node.name != nil
            {
                if node.name!.contains("battleUI")
                {
                    print("Found node \(node.name)")
                    node.alpha=1
                    
                }
            }
        } // for each node
        
    } // func startBattle
    
    func endBattle()
    {
        blob!.health = blob!.blobHealth
        blob2!.health=blob2!.blobHealth

        for node in cam.children
        {
            if node.name != nil
            {
                if node.name!.contains("battleUI")
                {
                    node.alpha=CGFloat.leastNonzeroMagnitude
                }
            }
        } // for each node
        
        for node in blob!.sprite.children
        {
            if node.name != nil
            {
                if node.name!.contains("Spec")
                {
                    node.removeFromParent()
                }
                
            }
        }
        for node in blob2!.sprite.children
        {
            if node.name != nil
            {
                if node.name!.contains("Spec")
                {
                    node.removeFromParent()
                }
            }
        }
        
        for node in self.children
        {
            if node.name != nil
            {
                if node.name!.contains("Spec")
                {
                    node.removeFromParent()
                }
                else if node.name!.contains("BlobDamage")
                {
                    node.removeFromParent()
                }
            } // if the node isn't nil
            
        } // for - remove special nodes
    } // func endBattle()
    
    func updateCam()
    {
        
        let midx=(blob!.sprite.position.x + blob2!.sprite.position.x)/2
        let midy=(blob!.sprite.position.y + blob2!.sprite.position.y)/2
        cam.position=CGPoint(x: midx, y: midy)
        
        let dx=blob!.sprite.position.x - blob2!.sprite.position.x
        let dy=blob!.sprite.position.y - blob2!.sprite.position.y
        let dist=hypot(dy, dx)
        let distRatio=dist/900
        cam.setScale(distRatio+1.5)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        checkKeys()

        //print("Age: \(baby.age)")
        //print("Scale: \(baby.sprite.xScale)")
        
        switch gameState
        {
        case GAMESTATES.BREED:
            updateUI()
            //baby!.update()
            baby!.sprite.position=CGPoint(x: 0, y: 0)
            blob!.sprite.position=CGPoint(x: -size.width*0.4, y: 0)
            blob2!.sprite.position=CGPoint(x: size.width*0.4, y: 0)
            cam.setScale(1.3)
            blob1Name.isHidden=false
            blob2Name.isHidden=false
            if baby!.sprite.isHidden
            {
                babyName.isHidden=true
            }
            else
            {
                babyName.isHidden=false
            }
        case GAMESTATES.FIGHT:
            showHUD=false
            updateUI()
            updateCam()
            baby!.sprite.isHidden=true
            blob!.update()
            blob2!.update()
            checkCloudDamage()
            baby!.sprite.position=CGPoint(x: -5000, y: -5000)
            checkBlobHealth()
            blob1Name.isHidden=true
            blob2Name.isHidden=true
            babyName.isHidden=true
        default:
            print("Error - Invalid GameState")
            
        }
        
        if -lastMoneyGain.timeIntervalSinceNow > 5
        {
            money += 1000
            lastMoneyGain=NSDate()
        }
    }
}
