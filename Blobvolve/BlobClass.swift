//
//  BlobClass.swift
//  Blobvolve
//
//  Created by Tom Shiflet on 2/15/19.
//  Copyright © 2019 Tom Shiflet. All rights reserved.
//

// See end of file for gene map

import Foundation
import SpriteKit
import GameplayKit


class BlobClass
{
    
    struct STATE
    {
        static let WANDER:Int = 0
        
    }
    //Genetic Constants
    let GENECOUNT:Int=59
    let GENESIZE:Int=3
    
    var blobID:Int=0
    
    
    
    var coreStats=[Int]()
    
    var sprite=SKSpriteNode()
    var spot1=SKSpriteNode(imageNamed: "spot01")
    var blobCircle=SKSpriteNode(imageNamed: "blobCircle64")
    var blobOuter=SKSpriteNode(imageNamed: "blobOuter64")
    var blobOuter2=SKSpriteNode(imageNamed: "blobOuter64")
    var DNA=String()
    var spike1=SKSpriteNode(imageNamed: "spike64")
    var blobLight=SKLightNode()
    
    var scene:SKScene?
    
    var age:CGFloat=0.5
    var bornTime=NSDate()
    var growthTime:Double=0
    
    var currentState:Int=0
    var lastWanderTurn=NSDate()
    var nextWanderTurn:Double=0
    var isTurning:Bool=false
    var turnToAngle:CGFloat=0
    var speed:CGFloat=0
    var health:CGFloat=0
    
    var enemy:BlobClass?
    
    
    // Genetic Characteristics
    var baseSize:Int=0
    var blobSize:CGFloat=0.0
    var spriteRed:CGFloat=0
    var spriteGreen:CGFloat=0
    var spriteBlue:CGFloat=0
    var pulseSpeed:Double=0
    var spriteAlpha:CGFloat=1.0
    var spot1Angle:CGFloat=0
    var spot1Dist:CGFloat=0
    var spot1Alpha:CGFloat=0
    var spot1RGB=NSColor()
    var spot1Scale:CGFloat=0
    var spot1Rotation:CGFloat=0
    var special1:Int=0
    var special2:Int=0
    var spot1Shape:Int=0
    var blobCircleShape:Int=0
    var blobCircleRGB=NSColor()
    var blobCircleAlpha:CGFloat=0.5
    var blobCircleAction:Int=0
    var blobStyle:Int=0
    var special1RGB=NSColor()
    var blobOuterShape:Int=0
    var blobOuterRGB=NSColor()
    var blobOuterAction:Int=0
    var moveSpeed:CGFloat=0         // Core Stat
    var spike1Type:Int=0
    var spike1Rotation:CGFloat=0
    var blobCircleRotation:CGFloat=0
    var blobOuter2Present:Int=0
    var blobOuter2Shape:Int=0
    var blobOuter2RGB=NSColor()
    var blobOuter2Action:Int=0
    var blobHealth:CGFloat=0        // Core Stat
    var spike1RGB=NSColor()
    var blobDamage:CGFloat=0        // Core Stat
    var blobColor2Chance:Int=0
    var blobColor2RGB=NSColor()
    var blobColor2Action:Int=0
    var blobOuterColor2Chance:Int=0
    var blobOuterColor2RGB=NSColor()
    var blobOuterColor3Chance:Int=0
    var blobOuterColor3RGB=NSColor()
    var spriteRotation:CGFloat=0
    var outer1GapActive:Bool=false
    var outer1GapDist:CGFloat=0
    var outer2GapActive:Bool=false
    var outer2GapDist:CGFloat=0
    var jitterAction:Int=0
    var genSeed1:Int=0
    var genSeed2:Int=0
    var genSeed3:Int=0
    var blobLightFalloff:CGFloat=0
    var specialAttack1:Int=0
    var lastSpecialAttack1=NSDate()
    var poisonResist:CGFloat=0
    var primaryDamageType:Int=0
    var physicalResist:CGFloat=0
    var electricalResist:CGFloat=0
    var sonicResist:CGFloat=0
    var special1Cool:Double=0
    var lastCloudDamage=NSDate()
    
    
    var GeneStrings=["Size", "RGB-R", "RGB-G", "RGB-B", "PlsSpd", "Alpha", "Sp1Ang", "Sp1Dst", "Sp1Alpha", "Sp1RGB", "Sp1Size", "Sp1Rot", "Spec1Typ", "Spec2Typ", "Sp1Shp", "CrcShp", "CrcRGB", "CrcAlpha", "CrcAct", "Sprite", "Spec1RGB", "OuterShp", "OuterRGB", "OutAct", "MoveSpd", "Spk1Typ", "Spk1Ang", "Spk1Rot", "Out2Prsnt", "Out2Shp", "Out2RGB", "Out2Act", "Health", "Spk1RGB", "Damage", "Color2%", "Color2RGB", "Color2Act", "OutClr2%", "OutClr2RGB", "OutColor3%", "OutColor3RGB", "SpriteRot", "Out1GapOn","Out1GapDist", "Out2GapOn","Out2GapDist", "Jitter", "ProcSeed1", "ProcSeed2", "ProcSeed3", "LightFall", "SpAttack-1", "PoisonResist", "PrimAtkType", "PhysResist", "ElecResist", "SonicResist", "Spec1Cool"]
    
    let SpriteNameStrings=["An", "Po", "Ca", "Bac", "Al", "Ra", "Car", "Min",
                           "Mol", "He", "Hai", "Vil", "Yun", "Chlo", "Pri", "Cis",
                           "Ax", "Bru", "Fri", "Qua", "Ai", "Rod", "Si", "Nur",
                           "Swa", "Pro", "Cri", "Calo", "Pub", "Mer", "Vaso", "Oli",
                           "Bacil", "Cuod", "Ero", "Amo", "Coc", "Wil", "Zero", "Los",
                           "Tric", "Sli", "Tomo", "Jinu", "Raivo", "Plu", "Vero", "Vin",
                           "Dia", "Rado", "Cope", "Phil", "Lyco", "Fora", "Mini", "Lori",
                           "Cif", "Roti", "Litho", "Rosi", "Visto", "Foli", "Ersto", "Comu"]
    
    let SpecialNameStrings=["tuso", "pila", "craya", "vol", "rint", "cren", "quol", "sentin",
                           "olin", "hecta", "brin", "rine", "jant", "an", "lin", "crost",
                           "tine", "crax", "lus", "lux", "fino", "vert", "wax", "liso",
                           "rix", "plus", "blo", "fiz", "fix", "yerx", "nit", "dil",
                           "lino", "bine", "cone", "rian", "tom", "poda", "dum", "ate",
                           "ion", "list", "nido", "wuda", "fige", "cus", "drom", "cos",
                           "fera", "fer", "phora", "hida", "blox", "nima", "taso", "jin",
                           "yolop", "yai", "vesto", "lomo", "saz", "plon", "tril", "kil"]
    
    let OuterNameStrings=["yog", "ren", "lois", "list", "selis", "pilom", "castin", "plis",
                           "froz", "moiner", "cust", "bris", "wrip", "prib", "virt", "pnom",
                           "triv", "trem", "caus", "shil", "tom", "trug", "iolk", "xirt",
                           "univ", "erom", "asim", "alim", "cip", "walph", "phob", "zaril",
                           "frin", "flog", "aph", "asib", "vilop", "shan", "quem", "chal",
                           "evop", "tyl", "nol", "kiran", "zul", "fos", "cypl", "anis",
                           "pyr", "lyr", "anon", "zystr", "nox", "quim", "wid", "nat",
                           "irop", "azur", "din", "lux", "ubril", "erst", "jam", "plex"]
    
    let CircleNameStrings=["ila", "onia", "air", "onus", "orus", "ewil", "isano", "ylus",
                           "ist", "eymno", "olim", "ulami", "ipo", "eria", "ebian", "osha",
                           "iphia", "obra", "uphia", "inag", "oce", "ibria", "awa", "irabo",
                           "unia", "izol", "oxo", "ylina", "aquus", "into", "ifora", "onti",
                           "yrae", "ivar", "ileat", "essa", "onim", "owera", "ynsa", "erto",
                           "ibau", "olpa", "yxia", "emanu", "esti", "irra", "ra", "ichia",
                           "asha", "illum", "oprum", "anum", "ivella", "onella", "ifra", "itian",
                           "ulko", "ileer", "unai", "iens", "omo", "ai", "us", "um"]
    
    let DamageNameStrings=["0", "1", "2", "3", "4", "5", "6", "7",
                           "8", "9", "10", "11", "12", "13", "14", "15",
                           "16", "17", "18", "19", "20", "21", "22", "23",
                           "24", "25", "26", "27", "28", "29", "30", "31",
                           "32", "33", "34", "35", "36", "37", "38", "39",
                           "40", "41", "42", "43", "44", "45", "46", "47",
                           "48", "49", "50", "51", "52", "53", "54", "55",
                           "56", "57", "58", "59", "60", "61", "62", "63"]
    
    // Computed Core Stats
    var blobLevel:Int=0
    
    
    
    // Constants

    let UPDATEAGE:CGFloat=0.001
    
    let BLOBPHYSICSSIZE:CGFloat=120
    
    let NUMBLOBTEXTURES:Int=40
    let NUMRANDOMGEN:Int=12
    
    let MINSIZE:CGFloat=0.0
    let MAXSIZE:CGFloat=0.5
    
    let PULSEBASE:Double=0.25
    let MINALPHA:CGFloat=0.0
    let MAXALPHA:CGFloat=0.25
    let ALPHABASE:CGFloat=0.75
    
    let MINSPOTDIST:CGFloat=50
    let MAXSPOTDIST:CGFloat=125
    let SPOTMAXSCALE:CGFloat=0.75
    let SPOTBASESCALE:CGFloat=0.5
    let NUMSPOTTEXTURES:Int=10
    let NUMBLOBCIRCLETEXTURES:Int=33
    let NUMOUTERTEXTURES=18
    let NUMSPIKETYPES:Int=2
    
    let LIGHTMIN:CGFloat=2.5
    let LIGHTMAX:CGFloat=0.75
    let LIGHTBASE:CGFloat=2.75
    
    let SPECIALCOOLBASE:Double=2.0
    let SPECIALCOOLMIN:Double=2
    let SPECIALCOOLMAX:Double=6
    
    
    // Core stat constants
    let NUMCORESTATS:Int=3
    let MOVESPEEDBASE:CGFloat=15
    let MOVESPEEDLEVEL:CGFloat=0.75
    let HEALTHBASE:CGFloat=100
    let HEALTHLEVEL:CGFloat=7.5
    let DAMAGEBASE:CGFloat=12.5
    let DAMAGELEVEL:CGFloat=2.5
    let OUTERMAXDIST:CGFloat=0.8
    
    
    
    struct SpecialType
    {
        public static let ELECTRICFIELD:Int=16
        public static let SMOKEFIELD:Int=32
        public static let MAGICFIELD:Int=3
        public static let FIREFLYFIELD:Int=51
        public static let DRIFTFIELD:Int=23
    }
    
    
    struct SpecialAttacks
    {
        public static let ELECTRICWAVE:Int=3        // RRY
        public static let SONICWAVE:Int=15          // RYY
        public static let LIGHTNINGBOLT:Int=33      // BRG
        public static let VIRUSLAUNCH:Int=48        // YRR
        public static let POISONCLOUD:Int=51        // YRY

        
    } // struct SpecialAttacks
    
    struct DamageType
    {
        public static let Physical  :Int=0
        public static let Electrical:Int=1
        public static let Poison    :Int=2
        public static let Sonic     :Int=3
        
        
    }
    
    init()
    {
        // fill core stats array
        coreStats.append(24)
        coreStats.append(32)
        coreStats.append(34)
        
        /*
        // fill spot texture array
        for i in 0..<NUMSPOTTEXTURES
        {
            let tempTex=SKTexture(imageNamed: String(format: "blob%02d",blobCircleShape))
            
        }
 */
        // generate random DNA strand
        for i in 0..<GENECOUNT*GENESIZE
        {
            var c:Character
            let num=random(min: 1, max: 0)
            if num < 0.25
            {
                c="R"
            }
            else if num < 0.5
            {
                c="G"
            }
            else if num < 0.75
            {
                c="B"
            }
            else
            {
                c="Y"
            }
            DNA.append(c)
        } // for each gene
        

        
        // decode the genes to stats
        
        // Size - gene 0
        let sizeIndex=DNA.index(DNA.startIndex, offsetBy: 3)
        let sizeCoded=String(DNA[..<sizeIndex])
        let sizeDec=tripToDec(trip: sizeCoded)
        let sizeRatio=CGFloat(sizeDec)/63
        blobSize=1.0*sizeRatio
        let blobBaseSize=0.75+blobSize
        let minBlobScale = blobBaseSize * 0.9
        let maxBlobScale = blobBaseSize * 1.1
        
        
        // Color | Red Channel - gene 1
        let colorGeneRed=getGene(num: 1)
        let colorDec=tripToDec(trip: colorGeneRed)
        spriteRed=CGFloat(colorDec)/63
        
        // Color | Green Channel - gene 2
        let colorGeneGreen=getGene(num: 2)
        let colorDecGreen=tripToDec(trip: colorGeneGreen)
        spriteGreen=CGFloat(colorDecGreen)/63

        // Color | Blue Channel - gene 3
        let colorGeneBlue=getGene(num: 3)
        let colorDecBlue=tripToDec(trip: colorGeneBlue)
        spriteBlue=CGFloat(colorDecBlue)/63
        
        // Pulse Speed - gene 4
        let pulseGene=getGene(num:4)
        let pulseDec=tripToDec(trip: pulseGene)
        let pulseRatio=Double(pulseDec)/63
        pulseSpeed=(pulseRatio*0.75)+PULSEBASE
        
        // Alpha - gene 5
        let alphaGene=getGene(num:5)
        let alphaDec=tripToDec(trip: alphaGene)
        let alphaRatio=CGFloat(alphaDec)/63
        spriteAlpha=(alphaRatio*(MAXALPHA-MINALPHA))+ALPHABASE
        
        // Spot #1 angle - gene 6
        let spot1AngleGene=getGene(num: 6)
        let spot1AngleDec=tripToDec(trip: spot1AngleGene)
        let spot1AngleRatio=CGFloat(spot1AngleDec)/63
        spot1Angle = (spot1AngleRatio*CGFloat.pi*2)
        
        // Spot #1 distance - gene 7
        let spot1DistGene=getGene(num: 7)
        let spot1DistDec=tripToDec(trip: spot1DistGene)
        let spot1DistRatio=CGFloat(spot1DistDec)/63
        spot1Dist=(spot1DistRatio*(MAXSPOTDIST-MINSPOTDIST))
        
        // Spot 1 Alpha - gene 8
        let spot1AlphaGene=getGene(num: 8)
        let spot1AlphaDec=tripToDec(trip: spot1AlphaGene)
        spot1Alpha=CGFloat(spot1AlphaDec)/63
        
        // Spot 1 RGB - gene 9
        let spot1RGBGene=getGene(num: 9)
        let spot1RGBDec=tripToDec(trip: spot1RGBGene)
        spot1RGB=getRGB(col: spot1RGBDec)

        // Spot 1 Scale - gene 10
        let spot1ScaleGene=getGene(num: 10)
        let spot1ScaleDec=tripToDec(trip: spot1ScaleGene)
        let spot1scaleRatio=CGFloat(spot1ScaleDec)/63
        spot1Scale=(spot1scaleRatio*SPOTMAXSCALE)+SPOTBASESCALE
        
        // Spot 1 Rotation - gene 11
        let spot1RotationGene=getGene(num: 11)
        let spot1RotDec=tripToDec(trip: spot1RotationGene)
        let spot1RotRatio=CGFloat(spot1RotDec)/63
        spot1Rotation=spot1RotRatio*CGFloat.pi*2
        
        // Special #1 type - gene 12
        let spec1TypeGene=getGene(num: 12)
        special1=tripToDec(trip: spec1TypeGene)
        
        // Special #2 type - gene 13
        let spec2TypeGene=getGene(num: 13)
        special2=tripToDec(trip: spec2TypeGene)
        
        // Spot 1 shape - gene 14
        let spot1ShapeGene=getGene(num: 14)
        spot1Shape=tripToDec(trip: spot1ShapeGene)
        
        // Blob circle shape - gene 15
        let blobCircleShapeGene=getGene(num: 15)
        blobCircleShape=tripToDec(trip: blobCircleShapeGene)
        
        // Blob circle RGB - gene 16
        let blobCircleRGBGene=getGene(num: 16)
        let blobCircleRGBDec=tripToDec(trip: blobCircleRGBGene)
        blobCircleRGB=getRGB(col: blobCircleRGBDec)
        
        // Blob circle Alpha - gene 17
        let blobCircleAlphaGene=getGene(num: 17)
        let blobCircleAlphaDec=tripToDec(trip: blobCircleAlphaGene)
        let blobCircleAlphaRatio=CGFloat(blobCircleAlphaDec)/63
        blobCircleAlpha = (blobCircleAlphaRatio*0.5)+0.2
        
        // Blob circle action - gene 18
        let blobCircleActionGene=getGene(num: 18)
        blobCircleAction=tripToDec(trip: blobCircleActionGene)

        // Blob Sprite - gene 19
        let blobSpriteGene=getGene(num: 19)
        let blobSpriteDec=tripToDec(trip: blobSpriteGene)
        blobStyle=blobSpriteDec
        if blobSpriteDec < NUMBLOBTEXTURES
        {
            sprite.texture=SKTexture(imageNamed: String(format:"blob%02d",blobSpriteDec))
        }
        else if blobSpriteDec < NUMBLOBTEXTURES+NUMRANDOMGEN
        {
            sprite.texture=createProcTexture()
            
        } // if the texture is randomly generated
        
        // Blob Special 1 RGB - gene 20
        let special1RGBGene=getGene(num: 20)
        let special1RGBDec=tripToDec(trip: special1RGBGene)
        special1RGB=getRGB(col: special1RGBDec)
        
        // Blob Outer Shape - gene 21
        let blobOuterShapeGene=getGene(num: 21)
        let blobOuterShapeDec=tripToDec(trip: blobOuterShapeGene)
        blobOuterShape=blobOuterShapeDec
        if blobOuterShapeDec < NUMOUTERTEXTURES
        {
            blobOuter.texture=SKTexture(imageNamed: String(format: "blobOuter%02d",blobOuterShapeDec))
        }
        else
        {
            blobOuter.texture=SKTexture(imageNamed: "blobOuter64")
        }
        
        // Blob Outer RGB - gene 22
        let blobOuterRGBGene=getGene(num: 22)
        let blobOuterRGBDec=tripToDec(trip: blobOuterRGBGene)
        blobOuterRGB=getRGB(col: blobOuterRGBDec)
        
        // Blob outer Action - gene 23
        let blobOuterActionGene=getGene(num: 23)
        blobOuterAction=tripToDec(trip: blobOuterActionGene)
        
        // Movement Speed - gene 24
        let moveSpeedDec=tripToDec(trip: getGene(num: 24))
        moveSpeed=MOVESPEEDBASE+CGFloat(moveSpeedDec)*MOVESPEEDLEVEL
        //print("Move Speed: \(moveSpeed) - \(moveSpeedDec)")
        
        // Spike 1 Type - gene 25
        spike1Type=tripToDec(trip: getGene(num: 25))
        if spike1Type < NUMSPIKETYPES
        {
            spike1.texture=SKTexture(imageNamed: String(format: "spike%02d",spike1Type))
        }
        else
        {
            spike1.texture=SKTexture(imageNamed: "spike64")
        }
        
        // spike 1 Angle - gene 26
        let spike1AngleDec=tripToDec(trip: getGene(num: 26))
        let spike1AngleRatio=CGFloat(spike1AngleDec)/63
        spike1Rotation=spike1AngleRatio*CGFloat.pi*2

        // blob circle rotation - gene 27
        let blobCircleRotDec=tripToDec(trip: getGene(num: 27))
        let blobCircleRotRatio=(CGFloat(blobCircleRotDec)/63)
        blobCircleRotation=blobCircleRotRatio*CGFloat.pi*2
        
        // blob outer #2 present - gene 28
        blobOuter2Present=tripToDec(trip: getGene(num: 28))
        
        // blob outer #2 shape - gene 29
        let blobOuter2ShapeDec=tripToDec(trip: getGene(num: 29))
        if blobOuter2Present%12==0
        {
            if blobOuter2ShapeDec < NUMOUTERTEXTURES
            {
                blobOuter2.texture=SKTexture(imageNamed: String(format: "blobOuter%02d",blobOuter2ShapeDec))
            }
            
        }
        else
        {
            blobOuter2.texture=SKTexture(imageNamed: "blobOuter64")
        }
        
        // Blob outer #2 RGB - gene 30
        var blobOuter2RGBDec=tripToDec(trip: getGene(num: 30))
        blobOuter2RGB=getRGB(col: blobOuter2RGBDec)
        
        // Blob outer #2 Action - gene 31
        blobOuter2Action=tripToDec(trip: getGene(num: 31))
        
        // Blob Health - gene 32
        let blobHealthDec=tripToDec(trip: getGene(num: 32))
        blobHealth=HEALTHBASE+(CGFloat(blobHealthDec)*HEALTHLEVEL)
        
        // Spike 1 RGB - gene 33
        let spike1RGBDec=tripToDec(trip: getGene(num: 33))
        spike1RGB=getRGB(col: spike1RGBDec)
        
        // Blob Damage - gene 34
        let damageDec=tripToDec(trip: getGene(num: 34))
        blobDamage=DAMAGEBASE+(CGFloat(damageDec)*DAMAGELEVEL)
        
        // Blob Color 2 Chance - gene 35
        blobColor2Chance=tripToDec(trip: getGene(num: 35))
        
        // Blob Color 2 RGB - gene 36
        let blobColor2RGBDec=tripToDec(trip: getGene(num: 36))
        blobColor2RGB=getRGB(col: blobColor2RGBDec)
        
        // Blob Color 2 action - gene 37
        blobColor2Action=tripToDec(trip: getGene(num: 37))
        
        // Blob Outer Color 2 Chnce - gene 38
        blobOuterColor2Chance=tripToDec(trip: getGene(num: 38))
        
        // Blob Outer Color 2 RGB - gene 39
        let blobOuterColor2RGBDec=tripToDec(trip: getGene(num: 39))
        blobOuterColor2RGB=getRGB(col: blobOuterColor2RGBDec)
        
        // Blob Outer Color 3 Chance - gene 40
        blobOuterColor3Chance=tripToDec(trip: getGene(num: 40))
        
        // Blob Outer Color 3 RGB - gene 41
        let blobOuterColor3RGBDec=tripToDec(trip: getGene(num: 41))
        blobOuterColor3RGB=getRGB(col: blobOuterColor3RGBDec)
        
        // Blob Sprite Rotation - gene 42
        let blobSpriteRotDec=tripToDec(trip: getGene(num: 42))
        let blobSpriteRotRatio=CGFloat(blobSpriteRotDec)/63
        spriteRotation=blobSpriteRotRatio*CGFloat.pi*2
        
        // Blob Outer 1 Gap Present - gene 43
        let blobOuterGapOnDec=tripToDec(trip: getGene(num: 43))
        if blobOuterGapOnDec%17==0
        {
            outer1GapActive=true
        }
        
        // Blob Outer 1 Gap Dist - gene 44
        let blobOuterGapDistDec=tripToDec(trip: getGene(num: 44))
        let blobOuterGapDistRatio=CGFloat(blobOuterGapDistDec)/63
        outer1GapDist=1+(blobOuterGapDistRatio*OUTERMAXDIST)
        
        // Blob Outer 2 Gap Present - gene 45
        let blobOuter2GapOnDec=tripToDec(trip: getGene(num: 45))
        if blobOuter2GapOnDec%19==0
        {
            outer2GapActive=true
        }
        
        // Blob Outer 2 Gap Dist - gene 46
        let blobOuter2GapDistDec=tripToDec(trip: getGene(num: 46))
        let blobOuter2GapDistRatio=CGFloat(blobOuter2GapDistDec)/63
        outer2GapDist=1+(blobOuter2GapDistRatio*OUTERMAXDIST)
        
        // Blob jitter Action - gene 47
        jitterAction=tripToDec(trip: getGene(num: 47))

        // blobSeed1 - gene 48
        // blobSeed2 - gene 49      These 3 genes supply the random seed for
        // blobSeed3 - gene 50      procedurally generated textures.
        
        // Blob light falloff - gene 51
        let blobLightFalloffDec=tripToDec(trip: getGene(num: 51))
        let blobLightFalloffRatio=CGFloat(blobLightFalloffDec)/63
        blobLightFalloff=blobLightFalloffRatio*(LIGHTMIN-LIGHTMAX)+LIGHTBASE

        // Special attack - gene 52
        specialAttack1=tripToDec(trip: getGene(num: 52))
        
        // Poison Resistance - gene 53
        let poisonResistDec=tripToDec(trip: getGene(num: 53))
        poisonResist=CGFloat(poisonResistDec)/75
        
        // Primary Attack Damage Type - gene 54
        let primDamTypeDec=tripToDec(trip: getGene(num: 54))
        primaryDamageType=primDamTypeDec%4
        
        // Physical Resistance - gene 55
        let physicalResistDec=tripToDec(trip: getGene(num: 55))
        physicalResist=CGFloat(physicalResistDec)/75
        
        // Electrical Resistance - gene 56
        let elecResistDec=tripToDec(trip: getGene(num: 56))
        electricalResist=CGFloat(elecResistDec)/75
        
        // Sonic Resistance - gene 57
        let sonicResistDec=tripToDec(trip: getGene(num: 57))
        sonicResist=CGFloat(sonicResistDec)/75
        
        // Special Attack 1 Cooldown - gene 58
        let spec1CoolDec=tripToDec(trip: getGene(num: 58))
        let spec1CoolRatio=Double(spec1CoolDec)/63
        let spec1CoolRange=(spec1CoolRatio*(SPECIALCOOLMAX-SPECIALCOOLMIN))+SPECIALCOOLMIN
        special1Cool=spec1CoolRange+SPECIALCOOLBASE
        print("Special 1 Cooldown: \(special1Cool)")
        
        
        //////////////////////////////////////////////
        // END OF GENE SEQUENCE //////////////////////
        //////////////////////////////////////////////
        
        // setup the sprite
        sprite=SKSpriteNode(imageNamed: "blob01")
        sprite.name="Blob"
        let pulseAction=SKAction.sequence([SKAction.scale(by: maxBlobScale, duration: pulseSpeed),SKAction.scale(to: minBlobScale, duration: pulseSpeed)])
        sprite.run(SKAction.repeatForever(pulseAction))
        sprite.colorBlendFactor=1.0
        sprite.lightingBitMask=1
        sprite.color=NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0)
        sprite.alpha=spriteAlpha
        sprite.zPosition=9
        sprite.zRotation=spriteRotation
        
        sprite.physicsBody=SKPhysicsBody(circleOfRadius: BLOBPHYSICSSIZE)
        sprite.physicsBody!.categoryBitMask=PHYSICSTYPES.BLOB
        sprite.physicsBody!.collisionBitMask=PHYSICSTYPES.WALL | PHYSICSTYPES.BLOB
        sprite.physicsBody!.contactTestBitMask=PHYSICSTYPES.WALL | PHYSICSTYPES.BLOB
        sprite.physicsBody!.linearDamping=0.5
        sprite.physicsBody!.angularDamping=0.5
        
        // Setup Blob Light
        blobLight.falloff=blobLightFalloff
        blobLight.categoryBitMask=1
        blobLight.lightColor=NSColor.white
        blobLight.name="blobLight"
        sprite.addChild(blobLight)
        
        
        
        // Add blob circle
        if blobCircleShape < NUMBLOBCIRCLETEXTURES
        {
            blobCircle.texture=SKTexture(imageNamed: String(format:"blobCircle%02d",blobCircleShape))
        }
        else
        {
            blobCircle.texture=SKTexture(imageNamed: "blobCircle64")
        }
        blobCircle.colorBlendFactor=1.0
        blobCircle.color=blobCircleRGB
        blobCircle.name="blobCircle"
        
        // Setup blob color 2
        if blobColor2Chance % 8 == 24
        {
            let action=getColor2Action(dec: blobColor2Action)
            sprite.run(SKAction.repeatForever(action))
        }
        
        
        blobCircle.alpha=blobCircleAlpha
        blobCircle.zPosition=10
        blobCircle.zRotation=blobCircleRotation
        sprite.addChild(blobCircle)
        blobCircle.removeAllActions()
        blobCircle.run(SKAction.repeatForever(getAction(dec: blobCircleAction)))
    
        

        
        // Add outer
        blobOuter.zPosition=11
        sprite.addChild(blobOuter)
        blobOuter.name="blobOuter"
        blobOuter.colorBlendFactor=1.0
        blobOuter.color=blobOuterRGB
        blobOuter.alpha=1.0
        blobOuter.setScale(1.0)
        if outer1GapActive
        {
            blobOuter.setScale(outer1GapDist)
        }
        else
        {
            outer1GapActive=false
        }
        
        // Add outer #2
        blobOuter2.zPosition=11
        sprite.addChild(blobOuter2)
        blobOuter2.name="blobOuter2"
        blobOuter2.colorBlendFactor=1.0
        blobOuter2.color=blobOuter2RGB
        blobOuter2.alpha=1.0
        if outer1GapActive
        {
            blobOuter2.setScale(outer2GapDist)
        }
        else
        {
            outer2GapActive=false
        }
        
        // Add outer action
        blobOuter.removeAllActions()
        blobOuter.run(SKAction.repeatForever(getOuterAction(dec: blobOuterAction)))
        
        // Add outer #2 action
        blobOuter2.removeAllActions()
        blobOuter2.run(SKAction.repeatForever(getOuterAction(dec: blobOuter2Action)))
        
        // Add out color actions
        if blobOuterColor2Chance % 10 == 0 && blobOuterColor3Chance % 20 != 0
        {
            let action=SKAction.sequence([SKAction.colorize(with: blobOuterColor2RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterRGB, colorBlendFactor: 1.0, duration: 1.0)])
            blobOuter.run(SKAction.repeatForever(action))
            
        } // if only color #2
        if blobOuterColor2Chance % 10 == 0 && blobOuterColor3Chance % 20 == 0
        {
            let action=SKAction.sequence([SKAction.colorize(with: blobOuterColor2RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterColor3RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterRGB, colorBlendFactor: 1.0, duration: 1.0)])
            blobOuter.run(SKAction.repeatForever(action))
            
        } // if both colors 2 and 3
        
        
        // Add spike 1
        let dx=cos(spike1Rotation)*sprite.size.width*0.425
        let dy=sin(spike1Rotation)*sprite.size.width*0.425
        sprite.addChild(spike1)
        spike1.position=CGPoint(x: dx, y: dy)
        spike1.name="spike1"
        spike1.zPosition=10
        spike1.zRotation=spike1Rotation
        spike1.colorBlendFactor=1.0
        spike1.color=spike1RGB
        
        // add Spots
        if spot1Shape < NUMSPOTTEXTURES
        {

            let s1dx=cos(spot1Angle)*spot1Dist
            let s1dy=sin(spot1Angle)*spot1Dist
            spot1.position=CGPoint(x: s1dx, y: s1dy)
            spot1.alpha=spot1Alpha
            spot1.colorBlendFactor=1.0
            spot1.color=spot1RGB
            spot1.setScale(spot1Scale)
            spot1.zPosition=11
            spot1.zRotation=spot1Rotation
            spot1.name="spot1"
            sprite.addChild(spot1)
        }
        else
        {
            spot1.texture=SKTexture(imageNamed: "spot64")
            let s1dx=cos(spot1Angle)*spot1Dist
            let s1dy=sin(spot1Angle)*spot1Dist
            spot1.position=CGPoint(x: s1dx, y: s1dy)
            spot1.alpha=spot1Alpha
            spot1.colorBlendFactor=1.0
            spot1.color=spot1RGB
            spot1.setScale(spot1Scale)
            spot1.zPosition=11
            spot1.zRotation=spot1Rotation
            spot1.name="spot1"
            sprite.addChild(spot1)
        }
        addSpecials()
        bornTime=NSDate()
        health=blobHealth
        growthTime=Double((computeLevel()*10)+30)
        
        // Add jitter
        
        switch jitterAction
        {
        case 12:
            
            let offset1=CGPoint(x: random(min: -5, max: 5), y: random(min: -5, max: 5))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
            
        case 28:
            
            let offset1=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let offset2=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.15),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        case 30:
            
            let offset1=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let offset2=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.55),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.55), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.55),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.55)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
            
        case 33:
            
            let offset1=CGPoint(x: random(min: -15, max: 15), y: 0)
            
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        case 41:
            let offset1=CGPoint(x: random(min: -15, max: 15), y: random(min: -15, max: 15))
            let offset2=CGPoint(x: random(min: -15, max: 15), y: random(min: -15, max: 15))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.25),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.25), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.25),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.25)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        default:
            break
            
        } // switch jitterAction
        
    } // init()
    
    init(theScene:SKScene)
    {
        scene=theScene
        // fill core stats array
        coreStats.append(24)
        coreStats.append(32)
        coreStats.append(34)
        
        /*
         // fill spot texture array
         for i in 0..<NUMSPOTTEXTURES
         {
         let tempTex=SKTexture(imageNamed: String(format: "blob%02d",blobCircleShape))
         
         }
         */
        // generate random DNA strand
        for i in 0..<GENECOUNT*GENESIZE
        {
            var c:Character
            let num=random(min: 1, max: 0)
            if num < 0.25
            {
                c="R"
            }
            else if num < 0.5
            {
                c="G"
            }
            else if num < 0.75
            {
                c="B"
            }
            else
            {
                c="Y"
            }
            DNA.append(c)
        } // for each gene
        
        
        
        // decode the genes to stats
        
        // Size - gene 0
        let sizeIndex=DNA.index(DNA.startIndex, offsetBy: 3)
        let sizeCoded=String(DNA[..<sizeIndex])
        let sizeDec=tripToDec(trip: sizeCoded)
        let sizeRatio=CGFloat(sizeDec)/63
        blobSize=1.0*sizeRatio
        let blobBaseSize=0.75+blobSize
        let minBlobScale = blobBaseSize * 0.9
        let maxBlobScale = blobBaseSize * 1.1
        
        
        // Color | Red Channel - gene 1
        let colorGeneRed=getGene(num: 1)
        let colorDec=tripToDec(trip: colorGeneRed)
        spriteRed=CGFloat(colorDec)/63
        
        // Color | Green Channel - gene 2
        let colorGeneGreen=getGene(num: 2)
        let colorDecGreen=tripToDec(trip: colorGeneGreen)
        spriteGreen=CGFloat(colorDecGreen)/63
        
        // Color | Blue Channel - gene 3
        let colorGeneBlue=getGene(num: 3)
        let colorDecBlue=tripToDec(trip: colorGeneBlue)
        spriteBlue=CGFloat(colorDecBlue)/63
        
        // Pulse Speed - gene 4
        let pulseGene=getGene(num:4)
        let pulseDec=tripToDec(trip: pulseGene)
        let pulseRatio=Double(pulseDec)/63
        pulseSpeed=(pulseRatio*0.75)+PULSEBASE
        
        // Alpha - gene 5
        let alphaGene=getGene(num:5)
        let alphaDec=tripToDec(trip: alphaGene)
        let alphaRatio=CGFloat(alphaDec)/63
        spriteAlpha=(alphaRatio*(MAXALPHA-MINALPHA))+ALPHABASE
        
        // Spot #1 angle - gene 6
        let spot1AngleGene=getGene(num: 6)
        let spot1AngleDec=tripToDec(trip: spot1AngleGene)
        let spot1AngleRatio=CGFloat(spot1AngleDec)/63
        spot1Angle = (spot1AngleRatio*CGFloat.pi*2)
        
        // Spot #1 distance - gene 7
        let spot1DistGene=getGene(num: 7)
        let spot1DistDec=tripToDec(trip: spot1DistGene)
        let spot1DistRatio=CGFloat(spot1DistDec)/63
        spot1Dist=(spot1DistRatio*(MAXSPOTDIST-MINSPOTDIST))
        
        // Spot 1 Alpha - gene 8
        let spot1AlphaGene=getGene(num: 8)
        let spot1AlphaDec=tripToDec(trip: spot1AlphaGene)
        spot1Alpha=CGFloat(spot1AlphaDec)/63
        
        // Spot 1 RGB - gene 9
        let spot1RGBGene=getGene(num: 9)
        let spot1RGBDec=tripToDec(trip: spot1RGBGene)
        spot1RGB=getRGB(col: spot1RGBDec)
        
        // Spot 1 Scale - gene 10
        let spot1ScaleGene=getGene(num: 10)
        let spot1ScaleDec=tripToDec(trip: spot1ScaleGene)
        let spot1scaleRatio=CGFloat(spot1ScaleDec)/63
        spot1Scale=(spot1scaleRatio*SPOTMAXSCALE)+SPOTBASESCALE
        
        // Spot 1 Rotation - gene 11
        let spot1RotationGene=getGene(num: 11)
        let spot1RotDec=tripToDec(trip: spot1RotationGene)
        let spot1RotRatio=CGFloat(spot1RotDec)/63
        spot1Rotation=spot1RotRatio*CGFloat.pi*2
        
        // Special #1 type - gene 12
        let spec1TypeGene=getGene(num: 12)
        special1=tripToDec(trip: spec1TypeGene)
        
        // Special #2 type - gene 13
        let spec2TypeGene=getGene(num: 13)
        special2=tripToDec(trip: spec2TypeGene)
        
        // Spot 1 shape - gene 14
        let spot1ShapeGene=getGene(num: 14)
        spot1Shape=tripToDec(trip: spot1ShapeGene)
        
        // Blob circle shape - gene 15
        let blobCircleShapeGene=getGene(num: 15)
        blobCircleShape=tripToDec(trip: blobCircleShapeGene)
        
        // Blob circle RGB - gene 16
        let blobCircleRGBGene=getGene(num: 16)
        let blobCircleRGBDec=tripToDec(trip: blobCircleRGBGene)
        blobCircleRGB=getRGB(col: blobCircleRGBDec)
        
        // Blob circle Alpha - gene 17
        let blobCircleAlphaGene=getGene(num: 17)
        let blobCircleAlphaDec=tripToDec(trip: blobCircleAlphaGene)
        let blobCircleAlphaRatio=CGFloat(blobCircleAlphaDec)/63
        blobCircleAlpha = (blobCircleAlphaRatio*0.5)+0.2
        
        // Blob circle action - gene 18
        let blobCircleActionGene=getGene(num: 18)
        blobCircleAction=tripToDec(trip: blobCircleActionGene)
        
        // Blob Sprite - gene 19
        let blobSpriteGene=getGene(num: 19)
        let blobSpriteDec=tripToDec(trip: blobSpriteGene)
        blobStyle=blobSpriteDec
        if blobSpriteDec < NUMBLOBTEXTURES
        {
            sprite.texture=SKTexture(imageNamed: String(format:"blob%02d",blobSpriteDec))
        }
        else if blobSpriteDec < NUMBLOBTEXTURES+NUMRANDOMGEN
        {
            sprite.texture=createProcTexture()
            
        } // if the texture is randomly generated
        
        // Blob Special 1 RGB - gene 20
        let special1RGBGene=getGene(num: 20)
        let special1RGBDec=tripToDec(trip: special1RGBGene)
        special1RGB=getRGB(col: special1RGBDec)
        
        // Blob Outer Shape - gene 21
        let blobOuterShapeGene=getGene(num: 21)
        let blobOuterShapeDec=tripToDec(trip: blobOuterShapeGene)
        blobOuterShape=blobOuterShapeDec
        if blobOuterShapeDec < NUMOUTERTEXTURES
        {
            blobOuter.texture=SKTexture(imageNamed: String(format: "blobOuter%02d",blobOuterShapeDec))
        }
        else
        {
            blobOuter.texture=SKTexture(imageNamed: "blobOuter64")
        }
        
        // Blob Outer RGB - gene 22
        let blobOuterRGBGene=getGene(num: 22)
        let blobOuterRGBDec=tripToDec(trip: blobOuterRGBGene)
        blobOuterRGB=getRGB(col: blobOuterRGBDec)
        
        // Blob outer Action - gene 23
        let blobOuterActionGene=getGene(num: 23)
        blobOuterAction=tripToDec(trip: blobOuterActionGene)
        
        // Movement Speed - gene 24
        let moveSpeedDec=tripToDec(trip: getGene(num: 24))
        moveSpeed=MOVESPEEDBASE+CGFloat(moveSpeedDec)*MOVESPEEDLEVEL
        //print("Move Speed: \(moveSpeed) - \(moveSpeedDec)")
        
        // Spike 1 Type - gene 25
        spike1Type=tripToDec(trip: getGene(num: 25))
        if spike1Type < NUMSPIKETYPES
        {
            spike1.texture=SKTexture(imageNamed: String(format: "spike%02d",spike1Type))
        }
        else
        {
            spike1.texture=SKTexture(imageNamed: "spike64")
        }
        
        // spike 1 Angle - gene 26
        let spike1AngleDec=tripToDec(trip: getGene(num: 26))
        let spike1AngleRatio=CGFloat(spike1AngleDec)/63
        spike1Rotation=spike1AngleRatio*CGFloat.pi*2
        
        // blob circle rotation - gene 27
        let blobCircleRotDec=tripToDec(trip: getGene(num: 27))
        let blobCircleRotRatio=(CGFloat(blobCircleRotDec)/63)
        blobCircleRotation=blobCircleRotRatio*CGFloat.pi*2
        
        // blob outer #2 present - gene 28
        blobOuter2Present=tripToDec(trip: getGene(num: 28))
        
        // blob outer #2 shape - gene 29
        let blobOuter2ShapeDec=tripToDec(trip: getGene(num: 29))
        if blobOuter2Present%12==0
        {
            if blobOuter2ShapeDec < NUMOUTERTEXTURES
            {
                blobOuter2.texture=SKTexture(imageNamed: String(format: "blobOuter%02d",blobOuter2ShapeDec))
            }
            
        }
        else
        {
            blobOuter2.texture=SKTexture(imageNamed: "blobOuter64")
        }
        
        // Blob outer #2 RGB - gene 30
        var blobOuter2RGBDec=tripToDec(trip: getGene(num: 30))
        blobOuter2RGB=getRGB(col: blobOuter2RGBDec)
        
        // Blob outer #2 Action - gene 31
        blobOuter2Action=tripToDec(trip: getGene(num: 31))
        
        // Blob Health - gene 32
        let blobHealthDec=tripToDec(trip: getGene(num: 32))
        blobHealth=HEALTHBASE+(CGFloat(blobHealthDec)*HEALTHLEVEL)
        
        // Spike 1 RGB - gene 33
        let spike1RGBDec=tripToDec(trip: getGene(num: 33))
        spike1RGB=getRGB(col: spike1RGBDec)
        
        // Blob Damage - gene 34
        let damageDec=tripToDec(trip: getGene(num: 34))
        blobDamage=DAMAGEBASE+(CGFloat(damageDec)*DAMAGELEVEL)
        
        // Blob Color 2 Chance - gene 35
        blobColor2Chance=tripToDec(trip: getGene(num: 35))
        
        // Blob Color 2 RGB - gene 36
        let blobColor2RGBDec=tripToDec(trip: getGene(num: 36))
        blobColor2RGB=getRGB(col: blobColor2RGBDec)
        
        // Blob Color 2 action - gene 37
        blobColor2Action=tripToDec(trip: getGene(num: 37))
        
        // Blob Outer Color 2 Chnce - gene 38
        blobOuterColor2Chance=tripToDec(trip: getGene(num: 38))
        
        // Blob Outer Color 2 RGB - gene 39
        let blobOuterColor2RGBDec=tripToDec(trip: getGene(num: 39))
        blobOuterColor2RGB=getRGB(col: blobOuterColor2RGBDec)
        
        // Blob Outer Color 3 Chance - gene 40
        blobOuterColor3Chance=tripToDec(trip: getGene(num: 40))
        
        // Blob Outer Color 3 RGB - gene 41
        let blobOuterColor3RGBDec=tripToDec(trip: getGene(num: 41))
        blobOuterColor3RGB=getRGB(col: blobOuterColor3RGBDec)
        
        // Blob Sprite Rotation - gene 42
        let blobSpriteRotDec=tripToDec(trip: getGene(num: 42))
        let blobSpriteRotRatio=CGFloat(blobSpriteRotDec)/63
        spriteRotation=blobSpriteRotRatio*CGFloat.pi*2
        
        // Blob Outer 1 Gap Present - gene 43
        let blobOuterGapOnDec=tripToDec(trip: getGene(num: 43))
        if blobOuterGapOnDec%17==0
        {
            outer1GapActive=true
        }
        
        // Blob Outer 1 Gap Dist - gene 44
        let blobOuterGapDistDec=tripToDec(trip: getGene(num: 44))
        let blobOuterGapDistRatio=CGFloat(blobOuterGapDistDec)/63
        outer1GapDist=1+(blobOuterGapDistRatio*OUTERMAXDIST)
        
        // Blob Outer 2 Gap Present - gene 45
        let blobOuter2GapOnDec=tripToDec(trip: getGene(num: 45))
        if blobOuter2GapOnDec%19==0
        {
            outer2GapActive=true
        }
        
        // Blob Outer 2 Gap Dist - gene 46
        let blobOuter2GapDistDec=tripToDec(trip: getGene(num: 46))
        let blobOuter2GapDistRatio=CGFloat(blobOuter2GapDistDec)/63
        outer2GapDist=1+(blobOuter2GapDistRatio*OUTERMAXDIST)
        
        // Blob jitter Action - gene 47
        jitterAction=tripToDec(trip: getGene(num: 47))
        
        // Blob light falloff - gene 51
        let blobLightFalloffDec=tripToDec(trip: getGene(num: 51))
        let blobLightFalloffRatio=CGFloat(blobLightFalloffDec)/63
        blobLightFalloff=blobLightFalloffRatio*(LIGHTMIN-LIGHTMAX)+LIGHTBASE
        
        // Special attack - gene 52
        specialAttack1=tripToDec(trip: getGene(num: 52))
        
        // Poison Resistance - gene 53
        let poisonResistDec=tripToDec(trip: getGene(num: 53))
        poisonResist=CGFloat(poisonResistDec)/75
        
        // Primary Attack Damage Type - gene 54
        let primDamTypeDec=tripToDec(trip: getGene(num: 54))
        primaryDamageType=primDamTypeDec%4
        
        // Physical Resistance - gene 55
        let physicalResistDec=tripToDec(trip: getGene(num: 55))
        physicalResist=CGFloat(physicalResistDec)/75
        
        // Electrical Resistance - gene 56
        let elecResistDec=tripToDec(trip: getGene(num: 56))
        electricalResist=CGFloat(elecResistDec)/75
        
        // Sonic Resistance - gene 57
        let sonicResistDec=tripToDec(trip: getGene(num: 57))
        sonicResist=CGFloat(sonicResistDec)/75
        
        // Special Attack 1 Cooldown - gene 58
        let spec1CoolDec=tripToDec(trip: getGene(num: 58))
        let spec1CoolRatio=Double(spec1CoolDec)/63
        let spec1CoolRange=(spec1CoolRatio*(SPECIALCOOLMAX-SPECIALCOOLMIN))+SPECIALCOOLMIN
        special1Cool=spec1CoolRange+SPECIALCOOLBASE
        print("Special 1 Cooldown: \(special1Cool)")
        
        //////////////////////////////////////////////
        // END OF GENE SEQUENCE //////////////////////
        //////////////////////////////////////////////
        
        // setup the sprite
        sprite=SKSpriteNode(imageNamed: "blob01")
        sprite.name="Blob"
        let pulseAction=SKAction.sequence([SKAction.scale(by: maxBlobScale, duration: pulseSpeed),SKAction.scale(to: minBlobScale, duration: pulseSpeed)])
        sprite.run(SKAction.repeatForever(pulseAction))
        sprite.colorBlendFactor=1.0
        sprite.color=NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0)
        sprite.alpha=spriteAlpha
        sprite.zPosition=9
        sprite.zRotation=spriteRotation
        sprite.lightingBitMask=1
        
        sprite.physicsBody=SKPhysicsBody(circleOfRadius: BLOBPHYSICSSIZE)
        sprite.physicsBody!.categoryBitMask=PHYSICSTYPES.BLOB
        sprite.physicsBody!.collisionBitMask=PHYSICSTYPES.WALL | PHYSICSTYPES.BLOB
        sprite.physicsBody!.contactTestBitMask=PHYSICSTYPES.WALL | PHYSICSTYPES.BLOB
        sprite.physicsBody!.linearDamping=0.5
        sprite.physicsBody!.angularDamping=0.5
        
        // Setup Blob Light
        blobLight.falloff=blobLightFalloff
        blobLight.categoryBitMask=1
        blobLight.lightColor=NSColor.white
        blobLight.name="blobLight"
        sprite.addChild(blobLight)
        
        
        // Add blob circle
        if blobCircleShape < NUMBLOBCIRCLETEXTURES
        {
            blobCircle.texture=SKTexture(imageNamed: String(format:"blobCircle%02d",blobCircleShape))
        }
        else
        {
            blobCircle.texture=SKTexture(imageNamed: "blobCircle64")
        }
        blobCircle.colorBlendFactor=1.0
        blobCircle.color=blobCircleRGB
        blobCircle.name="blobCircle"
        
        // Setup blob color 2
        if blobColor2Chance % 8 == 24
        {
            let action=getColor2Action(dec: blobColor2Action)
            sprite.run(SKAction.repeatForever(action))
        }
        
        
        blobCircle.alpha=blobCircleAlpha
        blobCircle.zPosition=10
        blobCircle.zRotation=blobCircleRotation
        sprite.addChild(blobCircle)
        blobCircle.removeAllActions()
        blobCircle.run(SKAction.repeatForever(getAction(dec: blobCircleAction)))
        
        
        
        
        // Add outer
        blobOuter.zPosition=11
        sprite.addChild(blobOuter)
        blobOuter.name="blobOuter"
        blobOuter.colorBlendFactor=1.0
        blobOuter.color=blobOuterRGB
        blobOuter.alpha=1.0
        blobOuter.setScale(1.0)
        if outer1GapActive
        {
            blobOuter.setScale(outer1GapDist)
        }
        else
        {
            outer1GapActive=false
        }
        
        // Add outer #2
        blobOuter2.zPosition=11
        sprite.addChild(blobOuter2)
        blobOuter2.name="blobOuter2"
        blobOuter2.colorBlendFactor=1.0
        blobOuter2.color=blobOuter2RGB
        blobOuter2.alpha=1.0
        if outer1GapActive
        {
            blobOuter2.setScale(outer2GapDist)
        }
        else
        {
            outer2GapActive=false
        }
        
        // Add outer action
        blobOuter.removeAllActions()
        blobOuter.run(SKAction.repeatForever(getOuterAction(dec: blobOuterAction)))
        
        // Add outer #2 action
        blobOuter2.removeAllActions()
        blobOuter2.run(SKAction.repeatForever(getOuterAction(dec: blobOuter2Action)))
        
        // Add out color actions
        if blobOuterColor2Chance % 10 == 0 && blobOuterColor3Chance % 20 != 0
        {
            let action=SKAction.sequence([SKAction.colorize(with: blobOuterColor2RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterRGB, colorBlendFactor: 1.0, duration: 1.0)])
            blobOuter.run(SKAction.repeatForever(action))
            
        } // if only color #2
        if blobOuterColor2Chance % 10 == 0 && blobOuterColor3Chance % 20 == 0
        {
            let action=SKAction.sequence([SKAction.colorize(with: blobOuterColor2RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterColor3RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterRGB, colorBlendFactor: 1.0, duration: 1.0)])
            blobOuter.run(SKAction.repeatForever(action))
            
        } // if both colors 2 and 3
        
        
        // Add spike 1
        let dx=cos(spike1Rotation)*sprite.size.width*0.425
        let dy=sin(spike1Rotation)*sprite.size.width*0.425
        sprite.addChild(spike1)
        spike1.position=CGPoint(x: dx, y: dy)
        spike1.name="spike1"
        spike1.zPosition=10
        spike1.zRotation=spike1Rotation
        spike1.colorBlendFactor=1.0
        spike1.color=spike1RGB
        
        // add Spots
        if spot1Shape < NUMSPOTTEXTURES
        {
            
            let s1dx=cos(spot1Angle)*spot1Dist
            let s1dy=sin(spot1Angle)*spot1Dist
            spot1.position=CGPoint(x: s1dx, y: s1dy)
            spot1.alpha=spot1Alpha
            spot1.colorBlendFactor=1.0
            spot1.color=spot1RGB
            spot1.setScale(spot1Scale)
            spot1.zPosition=11
            spot1.zRotation=spot1Rotation
            spot1.name="spot1"
            sprite.addChild(spot1)
        }
        else
        {
            spot1.texture=SKTexture(imageNamed: "spot64")
            let s1dx=cos(spot1Angle)*spot1Dist
            let s1dy=sin(spot1Angle)*spot1Dist
            spot1.position=CGPoint(x: s1dx, y: s1dy)
            spot1.alpha=spot1Alpha
            spot1.colorBlendFactor=1.0
            spot1.color=spot1RGB
            spot1.setScale(spot1Scale)
            spot1.zPosition=11
            spot1.zRotation=spot1Rotation
            spot1.name="spot1"
            sprite.addChild(spot1)
        }
        addSpecials()
        bornTime=NSDate()
        health=blobHealth
        growthTime=Double((computeLevel()*10)+30)
        
        // Add jitter
        
        switch jitterAction
        {
        case 12:
            
            let offset1=CGPoint(x: random(min: -5, max: 5), y: random(min: -5, max: 5))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
            
        case 28:
            
            let offset1=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let offset2=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.15),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        case 30:
            
            let offset1=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let offset2=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.55),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.55), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.55),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.55)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
            
        case 33:
            
            let offset1=CGPoint(x: random(min: -15, max: 15), y: 0)
            
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        case 41:
            let offset1=CGPoint(x: random(min: -15, max: 15), y: random(min: -15, max: 15))
            let offset2=CGPoint(x: random(min: -15, max: 15), y: random(min: -15, max: 15))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.25),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.25), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.25),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.25)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        default:
            break
            
        } // switch jitterAction
        

        
    } // init(scene)
    
    public func generateName() -> String
    {
        var retName:String=""
        
        retName += SpriteNameStrings[blobStyle]
        retName += SpecialNameStrings[special1]
        retName += " "
        retName += OuterNameStrings[blobOuterShape]
        retName += CircleNameStrings[blobCircleShape]
        
        
        return retName
    }
    
    private func getColor2Action(dec: Int) -> SKAction
    {
        var action=SKAction()
        switch dec
        {
        case 0:
            action=SKAction.sequence([SKAction.colorize(with: blobColor2RGB, colorBlendFactor: 1.0, duration: 0.5), SKAction.colorize(with: NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0), colorBlendFactor: 1.0, duration: 1.5)])
            
        case 12:
            action=SKAction.sequence([SKAction.colorize(with: blobColor2RGB, colorBlendFactor: 1.0, duration: 3.0), SKAction.colorize(with: NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0), colorBlendFactor: 1.0, duration: 3.0)])
            
        case 22:
            action=SKAction.sequence([SKAction.colorize(with: NSColor.black, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteGreen, alpha: 1.0), colorBlendFactor: 1.0, duration: 1.0)])
            
        case 29:
            action=SKAction.sequence([SKAction.colorize(with:NSColor.gray, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0), colorBlendFactor: 1.0, duration: 1.0)])
            
            
        case 34:
            action=SKAction.sequence([SKAction.colorize(with: blobColor2RGB, colorBlendFactor: 1.0, duration: 8.0), SKAction.colorize(with: NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0), colorBlendFactor: 1.0, duration: 8.0)])
            
        case 42:
            action=SKAction.sequence([SKAction.colorize(with: NSColor.gray, colorBlendFactor: 1.0, duration: 3.0), SKAction.colorize(with: blobColor2RGB, colorBlendFactor: 1.0, duration: 3.0), SKAction.colorize(with: NSColor.gray, colorBlendFactor: 1.0, duration: 3.0), SKAction.colorize(with: NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0), colorBlendFactor: 1.0, duration: 8.0)])
        default:
            action=SKAction.sequence([SKAction.colorize(with: blobColor2RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0), colorBlendFactor: 1.0, duration: 1.0)])
        }
        
        return action
    
    }
    

    private func getOuterAction(dec: Int) -> SKAction
    {
        var retAction=SKAction()
        switch dec
        {
        case 1:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi, duration: 0.5)])
        case 7:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 0.5)])
        case 11:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 1.5)])
        case 16:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 2.5)])
        case 19:
            retAction=SKAction.sequence([SKAction.rotate(byAngle:  CGFloat.pi/8, duration: 0.15), SKAction.rotate(byAngle: -CGFloat.pi/4, duration: 0.3),SKAction.wait(forDuration: 0.3)])
        case 22:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi/2, duration: 1.5), SKAction.rotate(byAngle: -CGFloat.pi, duration: 1.5)])
            
        case 27:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 1.5), SKAction.rotate(byAngle: -CGFloat.pi, duration: 1.5)])
            
        case 30:
            let flashAction=SKAction.sequence([SKAction.fadeOut(withDuration: 0.25),SKAction.fadeIn(withDuration: 0.25)])
            let rotateAction=SKAction.rotate(byAngle: -CGFloat.pi, duration: 0.75)
            retAction=SKAction.group([flashAction, rotateAction])
        case 33:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 3.5)])
            
        case 35:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi/2, duration: 1.0),SKAction.rotate(byAngle: CGFloat.pi, duration: 1.0),SKAction.rotate(byAngle: CGFloat.pi, duration: 0.5), SKAction.rotate(byAngle: CGFloat.pi/2, duration: 2.0)])
        case 38:
            retAction=SKAction.sequence([SKAction.fadeOut(withDuration: 1.5), SKAction.fadeIn(withDuration: 1.5)])
            
        case 41:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi, duration: 1.5)])
            
        case 45:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi/4, duration: 0.5), SKAction.rotate(byAngle: CGFloat.pi, duration: 0.5)])
        case 48:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi, duration: 1.0)])

        case 49:
            let flashAction=SKAction.sequence([SKAction.fadeOut(withDuration: 0.25),SKAction.wait(forDuration: 0.25),SKAction.fadeIn(withDuration: 0.25), SKAction.wait(forDuration: 0.25)])
            let rotateAction=SKAction.rotate(byAngle: -CGFloat.pi, duration: 0.75)
            retAction=SKAction.group([flashAction, rotateAction])
            
        case 52:
            retAction=SKAction.sequence([SKAction.fadeOut(withDuration: 1.5), SKAction.fadeIn(withDuration: 1.5)])
        case 59:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi/2, duration: 1.5), SKAction.rotate(byAngle: CGFloat.pi, duration: 1.5)])
        case 62:
            retAction=SKAction.sequence([SKAction.scale(to: 1.05, duration: 0.5), SKAction.scale(by: 0.95, duration: 0.5)])
        default:
            retAction=SKAction.sequence([SKAction.fadeAlpha(to: 1.0, duration: 1.5)])
 
        } // switch
        
        return retAction
    } // func getOuterAction
    
    private func addSpecials()
    {
        
        // first remove all special emitters
        for kid in sprite.children
        {
            if kid.name!.contains("Special")
            {
                kid.removeFromParent()
            }
        } // for each child node
        
        
        if special1==SpecialType.ELECTRICFIELD
        {
            let sparkPath = Bundle.main.path(
                forResource: "electricField", ofType: "sks")
            
            let sparkNode =
                NSKeyedUnarchiver.unarchiveObject(withFile: sparkPath!)
                    as! SKEmitterNode
            sparkNode.name="sparkNodeSpecial"
            sparkNode.zPosition=11
            sprite.addChild(sparkNode)
            
        } // if electric field
        if special2==SpecialType.ELECTRICFIELD
        {
            let sparkPath = Bundle.main.path(
                forResource: "electricField", ofType: "sks")
            
            let sparkNode =
                NSKeyedUnarchiver.unarchiveObject(withFile: sparkPath!)
                    as! SKEmitterNode
            sparkNode.name="sparkNodeSpecial"
            sparkNode.zPosition=9
            sprite.addChild(sparkNode)
            if special1==SpecialType.ELECTRICFIELD
            {
                sparkNode.particleColor=NSColor.yellow
            }
        } // if electric field
        if special1==SpecialType.SMOKEFIELD
        {
            let smokePath = Bundle.main.path(
                forResource: "smokeEffect01", ofType: "sks")
            
            let smokeNode =
                NSKeyedUnarchiver.unarchiveObject(withFile: smokePath!)
                    as! SKEmitterNode
            smokeNode.name="smokeNodeSpecial"
            smokeNode.zPosition=8
            smokeNode.particleColorSequence=nil
            smokeNode.particleColorBlendFactor=1.0
            smokeNode.particleColor=special1RGB
            sprite.addChild(smokeNode)
            
        } // if smoke field
        if special2==SpecialType.SMOKEFIELD
        {
            let smokePath = Bundle.main.path(
                forResource: "smokeEffect01", ofType: "sks")
            
            let smokeNode =
                NSKeyedUnarchiver.unarchiveObject(withFile: smokePath!)
                    as! SKEmitterNode
            smokeNode.name="smokeNodeSpecial"
            smokeNode.zPosition=11
            sprite.addChild(smokeNode)
            
        } // if smoke field

        if special1==SpecialType.MAGICFIELD
        {
            let magicPath = Bundle.main.path(
                forResource: "magicEffect", ofType: "sks")
            
            let magicNode =
                NSKeyedUnarchiver.unarchiveObject(withFile: magicPath!)
                    as! SKEmitterNode
            magicNode.name="magicNodeSpecial"
            magicNode.zPosition=8
            magicNode.particleColorSequence=nil
            magicNode.particleColorBlendFactor=1.0
            magicNode.particleColor=special1RGB
            sprite.addChild(magicNode)
            
        } // if magic field
        
        if special1==SpecialType.FIREFLYFIELD
        {
            let fireFlyPath = Bundle.main.path(
                forResource: "fireFlyEffect", ofType: "sks")
            
            let fireFlyNode =
                NSKeyedUnarchiver.unarchiveObject(withFile: fireFlyPath!)
                    as! SKEmitterNode
            fireFlyNode.name="magicNodeSpecial"
            fireFlyNode.zPosition=8
            fireFlyNode.particleColorSequence=nil
            fireFlyNode.particleColorBlendFactor=1.0
            fireFlyNode.particleColor=special1RGB
            sprite.addChild(fireFlyNode)
            
        } // if firefly field
        
        if special1==SpecialType.DRIFTFIELD
        {
            let fireFlyPath = Bundle.main.path(
                forResource: "driftEffect", ofType: "sks")
            
            let fireFlyNode =
                NSKeyedUnarchiver.unarchiveObject(withFile: fireFlyPath!)
                    as! SKEmitterNode
            fireFlyNode.name="driftNodeSpecial"
            fireFlyNode.zPosition=8
            fireFlyNode.particleColorSequence=nil
            fireFlyNode.particleColorBlendFactor=1.0
            fireFlyNode.particleColor=special1RGB
            sprite.addChild(fireFlyNode)
            
        } // if drift field
    } // add specials
    
    private func getAction(dec: Int) -> SKAction
    {
        var retAction=SKAction()
        
        switch dec
        {
        case 0:
            retAction=SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.5), SKAction.scale(to: 0.9, duration: 0.5)])
            
        case 1:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 2.5)])
            
        case 2:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 2.5)])
          
        case 3:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 4.5)])
            
        case 4:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 4.5)])
            
        case 5:
            retAction=SKAction.sequence([SKAction.scale(to: 1.1, duration: 3.5), SKAction.scale(to: 0.5, duration: 3.5)])
            
        case 6:
            retAction=SKAction.sequence([SKAction.scale(to: 1.1, duration: 1.5), SKAction.scale(to: 0.5, duration: 3.5)])
          
        case 7:
            retAction=SKAction.sequence([SKAction.scale(to: 1.1, duration: 3.5), SKAction.scale(to: 0.5, duration: 1.5)])
            
        case 8:
            retAction = SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 2.0),SKAction.scaleX(to: 1.1, duration: 1.5), SKAction.scaleX(to: 0.6, duration: 1.5)])
            
        case 9:
            retAction = SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi, duration: 2.0),SKAction.scaleX(to: 1.1, duration: 1.5), SKAction.scaleX(to: 0.6, duration: 1.5)])
            
        case 10:
            retAction=SKAction.sequence([SKAction.fadeOut(withDuration: 1.0),SKAction.fadeIn(withDuration: 1.0)])
            
        case 11:
            retAction=SKAction.sequence([SKAction.fadeOut(withDuration: 2.0),SKAction.fadeIn(withDuration: 2.0)])
            
        case 12:
            retAction=SKAction.sequence([SKAction.fadeOut(withDuration: 3.0),SKAction.fadeIn(withDuration: 1.0)])
            
        case 13:
            retAction=SKAction.sequence([SKAction.fadeOut(withDuration: 1.0),SKAction.fadeIn(withDuration: 3.0)])

        case 14:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi, duration: 3.5)])
            
        case 15:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi, duration: 2.0)])
        case 16:
            retAction=SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.5), SKAction.scale(to: 0.5, duration: 0.5)])
        case 17:
            retAction=SKAction.sequence([SKAction.scale(to: 0.7, duration: 0.25), SKAction.scale(to: 0.5, duration: 0.25)])
        
        case 18:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi, duration: 0.50)])
        
        case 19:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 0.250)])
            
        case 20:
            retAction=SKAction.sequence([SKAction.fadeOut(withDuration: 0.2),SKAction.fadeIn(withDuration: 0.2)])
            
        case 21:
            retAction=SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi*8, duration: 1.00), SKAction.rotate(byAngle: -CGFloat.pi*2, duration: 0.50) ])
        case 22 :
            retAction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi/2, duration: 0.5), SKAction.rotate(byAngle: CGFloat.pi/4, duration: 0.250) ])
        default:
            //retAction=SKAction.sequence([SKAction.scale(to: 0.7, duration: 0.25), SKAction.scale(to: 0.5, duration: 0.25)])
            retAction = SKAction.sequence([SKAction.scale(to: 1.0, duration: 1.0),SKAction.scale(to: 1.0, duration: 1.0)])
        }
        
        
        print("Action \(dec)")
        return retAction
        
    } // func getAction
    
    func computeLevel() -> Int
    {
        let levelTotal=tripToDec(trip: getGene(num: 34))+tripToDec(trip: getGene(num: 32))+tripToDec(trip: getGene(num: 24))
        
        let level=levelTotal //NUMCORESTATS
        //print("Level: \(level)")
        return level
        
    }
    
    private func getRGB(col: Int) -> NSColor
    {
        var r:CGFloat=0
        var g:CGFloat=0
        var b:CGFloat=0
        var tempCol=col
        

        if Int(tempCol/32) > 0
        {
            r+=0.75
            tempCol -= 32
        }


        if Int(tempCol/16) > 0
        {
            r+=0.25
            tempCol -= 16
        }

        if Int(tempCol/8) > 0
        {
            g+=0.75
            tempCol -= 8
        }
        
        if Int(tempCol/4) > 0
        {
            g+=0.25
            tempCol -= 4
        }
        
        if Int(tempCol/2) > 0
        {
            b+=0.75
            tempCol -= 2
        }
        
        if tempCol > 0
        {
            b+=0.25
        }
        
        return NSColor(calibratedRed: r, green: g, blue: b, alpha: 1.0)
        
        
    }
    
    public func breed(with: BlobClass) -> BlobClass
    {
        var offspring=BlobClass(theScene: self.scene!)
        //print("Breeding")
        
        for i in 0..<GENECOUNT
        {
            let chance=random(min: 0, max: 1)
            if chance < 0.495
            {
                offspring.replaceGene(at: i, with: self.getGene(num: i))
                if getGene(num: i) == with.getGene(num: i)
                {
                    let mutateChance=random(min: 0, max: 1)
                    if mutateChance > 0.8
                    {
                        offspring.replaceGene(at: i, with: genNewGeneString())
                        print("Inbreeding mutation at gene #\(i) ")
                    }
                } // if the genes match give a high chance to mutate
            } // if inheriting our gene
            else if chance < 0.99
            {
                offspring.replaceGene(at: i, with: with.getGene(num: i))
                if getGene(num: i) == with.getGene(num: i)
                {
                    let mutateChance=random(min: 0, max: 1)
                    if mutateChance > 0.8
                    {
                        offspring.replaceGene(at: i, with: genNewGeneString())
                        print("Inbreeding mutation at gene #\(i) ")
                    }
                } // if the genes match give a high chance to mutate
            } // if if inheriting from the partner
            else
            {
                let temp=genNewGeneString()
                offspring.replaceGene(at: i, with: temp)
                print("Mutation at gene #\(i) ")
            }
        } // for each gene
    
        return offspring
    } // func breed
    
    public func getGene(num: Int) -> String
    {
        let start = DNA.index(DNA.startIndex, offsetBy: num*3)
        let end = DNA.index(DNA.startIndex, offsetBy: (num*3)+3)
        let range = start..<end
        
        let mySubstring = DNA[range]  
        
        return String(mySubstring)
        
    } // func getGene
    
    public func generateByLevel(level: Int)
    {
        genNewDNA()
        
        for i in 0..<coreStats.count
        {
            var quit=false
            var gene:String=""
            while !quit
            {
                let temp=genNewGeneString()
                if tripToDec(trip: temp) <= level
                {
                    gene=temp
                    quit=true
                }
            } // while
            replaceGene(at: coreStats[i], with: gene)
        } // for each core stat gene
        
        resetSprite()
        
    } // func generateByLevel
    
    
    public func generateNewGene(at: Int)
    {
        var newString=String()

        for i in 0..<3
        {
            var c:Substring
            let num=random(min: 1, max: 0)
            if num < 0.25
            {
                c="R"
            }
            else if num < 0.5
            {
                c="G"
            }
            else if num < 0.75
            {
                c="B"
            }
            else
            {
                c="Y"
            }
            newString=String(DNA.prefix(at*3+i)+c+DNA.dropFirst(at*3+i+1))
            DNA=newString
            
        } // for


        //resetSprite()
    }
    
    func genNewGeneString() -> String
    {
        var newString=String()
        
        for _ in 0..<3
        {
            var c:Character
            let num=random(min: 1, max: 0)
            if num < 0.25
            {
                c="R"
            }
            else if num < 0.5
            {
                c="G"
            }
            else if num < 0.75
            {
                c="B"
            }
            else
            {
                c="Y"
            }
            newString.append(c)
        }
        return newString
    } // func genNewGeneString
    
    func replaceGene(at: Int, with: String)
    {
        var i = 0
        for char in with
        {
            var newString=String(DNA.prefix(at*3+i)+String(char)+DNA.dropFirst(at*3+i+1))
            DNA=newString
            i+=1
        } // for
    } // replaceGene
    
    public func resetSprite()
    {
        
        sprite.setScale(1.0)
        speed=0
        
        growthTime=Double((computeLevel()*0)+1)
        
        // reset size - gene 0
        let sizeString=getGene(num: 0)
        let sizeCoded=sizeString
        let sizeDec=tripToDec(trip: sizeCoded)
        let sizeRatio=CGFloat(sizeDec)/63
        blobSize=1.0*sizeRatio
        let blobBaseSize=0.75+blobSize
        let minBlobScale = blobBaseSize * 0.9
        let maxBlobScale = blobBaseSize * 1.1
        sprite.removeAllActions()


        
        // Color | Red Channel - gene 1
        let colorGene=getGene(num: 1)
        let colorDec=tripToDec(trip: colorGene)
        spriteRed=CGFloat(colorDec)/64
        
        // Color | Green Channel - gene 2
        let colorGeneGreen=getGene(num: 2)
        let colorDecGreen=tripToDec(trip: colorGeneGreen)
        spriteGreen=CGFloat(colorDecGreen)/64
        
        // Color | Blue Channel - gene 3
        let colorGeneBlue=getGene(num: 3)
        let colorDecBlue=tripToDec(trip: colorGeneBlue)
        spriteBlue=CGFloat(colorDecBlue)/64
        
        // Pulse Speed - gene 4
        let pulseGene=getGene(num:4)
        let pulseDec=tripToDec(trip: pulseGene)
        let pulseRatio=Double(pulseDec)/63
        pulseSpeed=(pulseRatio*0.75)+PULSEBASE

        // Alpha - gene 5
        let alphaGene=getGene(num:5)
        let alphaDec=tripToDec(trip: alphaGene)
        let alphaRatio=CGFloat(alphaDec)/63
        spriteAlpha=(alphaRatio*(MAXALPHA-MINALPHA))+ALPHABASE

        // Spot #1 angle - gene 6
        let spot1AngleGene=getGene(num: 6)
        let spot1AngleDec=tripToDec(trip: spot1AngleGene)
        let spot1AngleRatio=CGFloat(spot1AngleDec)/63
        spot1Angle = (spot1AngleRatio*CGFloat.pi*2)
        
        // Spot #1 distance - gene 7
        let spot1DistGene=getGene(num: 7)
        let spot1DistDec=tripToDec(trip: spot1DistGene)
        let spot1DistRatio=CGFloat(spot1DistDec)/63
        spot1Dist=(spot1DistRatio*(MAXSPOTDIST-MINSPOTDIST))
        
        // Spot 1 Alpha - gene 8
        let spot1AlphaGene=getGene(num: 8)
        let spot1AlphaDec=tripToDec(trip: spot1AlphaGene)
        spot1Alpha=CGFloat(spot1AlphaDec)/63
        
        // Spot 1 RGB - gene 9
        let spot1RGBGene=getGene(num: 9)
        let spot1RGBDec=tripToDec(trip: spot1RGBGene)
        spot1RGB=getRGB(col: spot1RGBDec)

        // Spot 1 Scale - gene 10
        let spot1ScaleGene=getGene(num: 10)
        let spot1ScaleDec=tripToDec(trip: spot1ScaleGene)
        let spot1scaleRatio=CGFloat(spot1ScaleDec)/63
        spot1Scale=(spot1scaleRatio*SPOTMAXSCALE)+SPOTBASESCALE

        // Spot 1 Rotation - gene 11
        let spot1RotationGene=getGene(num: 11)
        let spot1RotDec=tripToDec(trip: spot1RotationGene)
        let spot1RotRatio=CGFloat(spot1RotDec)/63
        spot1Rotation=spot1RotRatio*CGFloat.pi*2
        
        // Special #1 type - gene 12
        let spec1TypeGene=getGene(num: 12)
        special1=tripToDec(trip: spec1TypeGene)
        
        // Special #2 type - gene 13
        let spec2TypeGene=getGene(num: 13)
        special2=tripToDec(trip: spec2TypeGene)
        
        // Spot 1 shape - gene 14
        let spot1ShapeGene=getGene(num: 14)
        spot1Shape=tripToDec(trip: spot1ShapeGene)
        
        // Blob circle shape - gene 15
        let blobCircleShapeGene=getGene(num: 15)
        blobCircleShape=tripToDec(trip: blobCircleShapeGene)
        
        // Blob circle RGB - gene 16
        let blobCircleRGBGene=getGene(num: 16)
        let blobCircleRGBDec=tripToDec(trip: blobCircleRGBGene)
        blobCircleRGB=getRGB(col: blobCircleRGBDec)
        
        // Blob circle Alpha - gene 17
        let blobCircleAlphaGene=getGene(num: 17)
        let blobCircleAlphaDec=tripToDec(trip: blobCircleAlphaGene)
        let blobCircleAlphaRatio=CGFloat(blobCircleAlphaDec)/63
        blobCircleAlpha = (blobCircleAlphaRatio*0.5)+0.2
        
        // Blob circle action - gene 18
        let blobCircleActionGene=getGene(num: 18)
        blobCircleAction=tripToDec(trip: blobCircleActionGene)

        
        // Blob Sprite - gene 19
        let blobSpriteGene=getGene(num: 19)
        let blobSpriteDec=tripToDec(trip: blobSpriteGene)
        blobStyle=blobSpriteDec
        if blobSpriteDec < NUMBLOBTEXTURES
        {
            sprite.texture=SKTexture(imageNamed: String(format:"blob%02d",blobSpriteDec))
        }
        else if blobSpriteDec < NUMBLOBTEXTURES+NUMRANDOMGEN
        {
            sprite.texture=createProcTexture()
            
        } // if the texture is randomly generated
        
        // Blob Special 1 RGB - gene 20
        let special1RGBGene=getGene(num: 20)
        let special1RGBDec=tripToDec(trip: special1RGBGene)
        special1RGB=getRGB(col: special1RGBDec)
        
        // Blob Outer Shape - gene 21
        let blobOuterShapeGene=getGene(num: 21)
        let blobOuterShapeDec=tripToDec(trip: blobOuterShapeGene)
        blobOuterShape=blobOuterShapeDec
        if blobOuterShapeDec < NUMOUTERTEXTURES
        {
            blobOuter.texture=SKTexture(imageNamed: String(format: "blobOuter%02d",blobOuterShapeDec))
        }
        else
        {
            blobOuter.texture=SKTexture(imageNamed: "blobOuter64")
        }
        
        // Blob Outer RGB - gene 22
        let blobOuterRGBGene=getGene(num: 22)
        let blobOuterRGBDec=tripToDec(trip: blobOuterRGBGene)
        blobOuterRGB=getRGB(col: blobOuterRGBDec)
        
        // Blob outer Action - gene 23
        let blobOuterActionGene=getGene(num: 23)
        blobOuterAction=tripToDec(trip: blobOuterActionGene)
        
        // Movement Speed - gene 24
        let moveSpeedDec=tripToDec(trip: getGene(num: 24))
        moveSpeed=MOVESPEEDBASE+CGFloat(moveSpeedDec)*MOVESPEEDLEVEL
        //print("Move Speed: \(moveSpeed) - \(moveSpeedDec)")
        
        // Spike 1 Type - gene 25
        spike1Type=tripToDec(trip: getGene(num: 25))
        if spike1Type < NUMSPIKETYPES
        {
            spike1.texture=SKTexture(imageNamed: String(format: "spike%02d",spike1Type))
        }
        else
        {
            spike1.texture=SKTexture(imageNamed: "spike64")
        }
        
        // spike 1 Angle - gene 26
        let spike1AngleDec=tripToDec(trip: getGene(num: 26))
        let spike1AngleRatio=CGFloat(spike1AngleDec)/63
        spike1Rotation=spike1AngleRatio*CGFloat.pi*2

        // blob circle rotation - gene 27
        let blobCircleRotDec=tripToDec(trip: getGene(num: 27))
        let blobCircleRotRatio=(CGFloat(blobCircleRotDec)/63)
        blobCircleRotation=blobCircleRotRatio*CGFloat.pi*2
        
        // blob outer #2 present - gene 28
        blobOuter2Present=tripToDec(trip: getGene(num: 28))
        
        // blob outer #2 shape - gene 29
        let blobOuter2ShapeDec=tripToDec(trip: getGene(num: 29))
        if blobOuter2Present%12==0
        {
            if blobOuter2ShapeDec < NUMOUTERTEXTURES
            {
                blobOuter2.texture=SKTexture(imageNamed: String(format: "blobOuter%02d",blobOuter2ShapeDec))
            }
            else
            {
                blobOuter2.texture=SKTexture(imageNamed: "blobOuter64")
            }
            
        }
        else
        {
            blobOuter2.texture=SKTexture(imageNamed: "blobOuter64")
        }
        
        // Blob outer #2 RGB - gene 30
        var blobOuter2RGBDec=tripToDec(trip: getGene(num: 30))
        blobOuter2RGB=getRGB(col: blobOuter2RGBDec)
        
        // Blob outer #2 Action - gene 31
        blobOuter2Action=tripToDec(trip: getGene(num: 31))
        
        // Blob Health - gene 32
        let blobHealthDec=tripToDec(trip: getGene(num: 32))
        blobHealth=HEALTHBASE+(CGFloat(blobHealthDec)*HEALTHLEVEL)
        
        // Spike 1 RGB - gene 33
        let spike1RGBDec=tripToDec(trip: getGene(num: 33))
        spike1RGB=getRGB(col: spike1RGBDec)
        
        // Blob Damage - gene 34
        let damageDec=tripToDec(trip: getGene(num: 34))
        blobDamage=DAMAGEBASE+(CGFloat(damageDec)*DAMAGELEVEL)
        
        // Blob Color 2 Chance - gene 35
        blobColor2Chance=tripToDec(trip: getGene(num: 35))
        
        // Blob Color 2 RGB - gene 36
        let blobColor2RGBDec=tripToDec(trip: getGene(num: 36))
        blobColor2RGB=getRGB(col: blobColor2RGBDec)
        
        // Blob Color 2 action - gene 37
        blobColor2Action=tripToDec(trip: getGene(num: 37))
        
        // Blob Outer Color 2 Chnce - gene 38
        blobOuterColor2Chance=tripToDec(trip: getGene(num: 38))
        
        // Blob Outer Color 2 RGB - gene 39
        let blobOuterColor2RGBDec=tripToDec(trip: getGene(num: 39))
        blobOuterColor2RGB=getRGB(col: blobOuterColor2RGBDec)
        
        // Blob Outer Color 3 Chance - gene 40
        blobOuterColor3Chance=tripToDec(trip: getGene(num: 40))
        
        // Blob Outer Color 3 RGB - gene 41
        let blobOuterColor3RGBDec=tripToDec(trip: getGene(num: 41))
        blobOuterColor3RGB=getRGB(col: blobOuterColor3RGBDec)
        
        // Blob Sprite Rotation - gene 42
        let blobSpriteRotDec=tripToDec(trip: getGene(num: 42))
        let blobSpriteRotRatio=CGFloat(blobSpriteRotDec)/63
        spriteRotation=blobSpriteRotRatio*CGFloat.pi*2
        
        
        // Blob Outer 1 Gap Present - gene 43
        let blobOuterGapOnDec=tripToDec(trip: getGene(num: 43))
        if blobOuterGapOnDec%17==0
        {
            outer1GapActive=true
        }
        else
        {
            outer1GapActive=false
        }
        
        // Blob Outer 1 Gap Dist - gene 44
        let blobOuterGapDistDec=tripToDec(trip: getGene(num: 44))
        let blobOuterGapDistRatio=CGFloat(blobOuterGapDistDec)/63
        outer1GapDist=1+(blobOuterGapDistRatio*OUTERMAXDIST)
        
        // Blob Outer 2 Gap Present - gene 45
        let blobOuter2GapOnDec=tripToDec(trip: getGene(num: 45))
        if blobOuter2GapOnDec%19==0
        {
            outer2GapActive=true
        }
        
        // Blob Outer 2 Gap Dist - gene 46
        let blobOuter2GapDistDec=tripToDec(trip: getGene(num: 46))
        let blobOuter2GapDistRatio=CGFloat(blobOuter2GapDistDec)/63
        outer2GapDist=1+(blobOuter2GapDistRatio*OUTERMAXDIST)
        
        // Blob jitter Action - gene 47
        jitterAction=tripToDec(trip: getGene(num: 47))
        
        // Blob light falloff - gene 51
        let blobLightFalloffDec=tripToDec(trip: getGene(num: 51))
        let blobLightFalloffRatio=CGFloat(blobLightFalloffDec)/63
        blobLightFalloff=blobLightFalloffRatio*(LIGHTMIN-LIGHTMAX)+LIGHTBASE
        print("Light fall: \(blobLightFalloff)")
        
        // Special attack - gene 52
        specialAttack1=tripToDec(trip: getGene(num: 52))
        
        // Poison Resistance - gene 53
        let poisonResistDec=tripToDec(trip: getGene(num: 53))
        poisonResist=CGFloat(poisonResistDec)/75
        
        // Primary Attack Damage Type - gene 54
        let primDamTypeDec=tripToDec(trip: getGene(num: 54))
        primaryDamageType=primDamTypeDec%4
        
        // Physical Resistance - gene 55
        let physicalResistDec=tripToDec(trip: getGene(num: 55))
        physicalResist=CGFloat(physicalResistDec)/75
        
        // Electrical Resistance - gene 56
        let elecResistDec=tripToDec(trip: getGene(num: 56))
        electricalResist=CGFloat(elecResistDec)/75
        
        // Sonic Resistance - gene 57
        let sonicResistDec=tripToDec(trip: getGene(num: 57))
        sonicResist=CGFloat(sonicResistDec)/75
        
        // Special Attack 1 Cooldown - gene 58
        let spec1CoolDec=tripToDec(trip: getGene(num: 58))
        let spec1CoolRatio=Double(spec1CoolDec)/63
        let spec1CoolRange=(spec1CoolRatio*(SPECIALCOOLMAX-SPECIALCOOLMIN))+SPECIALCOOLMIN
        special1Cool=spec1CoolRange+SPECIALCOOLBASE
        print("Special 1 Cooldown: \(special1Cool)")
        
        /////////////////////////////////////////////
        // End of gene sequence
        /////////////////////////////////////////////
        
        
        sprite.color=NSColor(calibratedRed: spriteRed, green: spriteGreen, blue: spriteBlue, alpha: 1.0)
        let pulseAction=SKAction.sequence([SKAction.scale(by: 1.1, duration: pulseSpeed),SKAction.scale(by: 0.9090909090909090909090909090, duration: pulseSpeed)])
        sprite.run(SKAction.repeatForever(pulseAction))
        sprite.alpha=spriteAlpha
        sprite.lightingBitMask=1
        sprite.zRotation=spriteRotation
        
        // Setup Blob Light
        blobLight.falloff=blobLightFalloff
        blobLight.categoryBitMask=1
        blobLight.lightColor=NSColor.white
        blobLight.name="blobLight"
        
        
        // Setup blob color 2
        if blobColor2Chance % 24 == 0
        {
            let action=getColor2Action(dec: blobColor2Action)
            sprite.run(SKAction.repeatForever(action))
        }
        
        blobOuter.color=blobOuterRGB
        // Add outer action
        blobOuter.alpha=1.0
        blobOuter.zRotation=0
        blobOuter.removeAllActions()
        blobOuter.run(SKAction.repeatForever(getOuterAction(dec: blobOuterAction)))
        //print("Outer Action: \(blobOuterAction)")
        if outer1GapActive
        {
            blobOuter.setScale(outer1GapDist)
        }
        else
        {
            blobOuter.setScale(1.0)
        }
        // Add outer #2
        blobOuter2.zPosition=11
        blobOuter2.zRotation=0
        blobOuter2.name="blobOuter2"
        blobOuter2.colorBlendFactor=1.0
        blobOuter2.color=blobOuter2RGB
        blobOuter2.alpha=1.0
        blobOuter2.removeAllActions()
        blobOuter2.run(SKAction.repeatForever(getOuterAction(dec: blobOuter2Action)))
        if outer2GapActive
        {
            blobOuter2.setScale(outer2GapDist)
        }
        else
        {
            blobOuter2.setScale(1.0)
        }
        
        // Add out color actions
        if blobOuterColor2Chance % 10 == 0 && blobOuterColor3Chance % 20 != 0
        {
            let action=SKAction.sequence([SKAction.colorize(with: blobOuterColor2RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterRGB, colorBlendFactor: 1.0, duration: 1.0)])
            blobOuter.run(SKAction.repeatForever(action))
            
        } // if only color #2
        if blobOuterColor2Chance % 10 == 0 && blobOuterColor3Chance % 20 == 0
        {
            let action=SKAction.sequence([SKAction.colorize(with: blobOuterColor2RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterColor3RGB, colorBlendFactor: 1.0, duration: 1.0), SKAction.colorize(with: blobOuterRGB, colorBlendFactor: 1.0, duration: 1.0)])
            blobOuter.run(SKAction.repeatForever(action))
            
        } // if both colors 2 and 3
        
        // Add blob circle
        //print("blobCircle: \(blobCircleShape)")
        if blobCircleShape < NUMBLOBCIRCLETEXTURES
        {
            blobCircle.texture=SKTexture(imageNamed: String(format:"blobCircle%02d",blobCircleShape))
        }
        else
        {
            blobCircle.texture=SKTexture(imageNamed: "blobCircle64")
        }
        blobCircle.colorBlendFactor=1.0
        blobCircle.color=blobCircleRGB
        blobCircle.name="blobCircle"
        blobCircle.alpha=blobCircleAlpha
        blobCircle.zPosition=10
        blobCircle.zRotation=blobCircleRotation
        blobCircle.run(SKAction.stop())
        blobCircle.removeAllActions()
        blobCircle.run(SKAction.repeatForever(getAction(dec: blobCircleAction)))
        
        
        // update spike 1
        let dx=cos(spike1Rotation)*sprite.size.width*0.425
        let dy=sin(spike1Rotation)*sprite.size.width*0.425
        spike1.position=CGPoint(x: dx, y: dy)
        spike1.zRotation=spike1Rotation
        spike1.color=spike1RGB
        
        if spot1Shape < NUMSPOTTEXTURES
        {

            spot1.texture=SKTexture(imageNamed: "spot0\(spot1Shape)")
            let s1dx=cos(spot1Angle)*spot1Dist
            let s1dy=sin(spot1Angle)*spot1Dist
            spot1.position=CGPoint(x: s1dx, y: s1dy)
            spot1.alpha=spot1Alpha
            spot1.colorBlendFactor=1.0
            spot1.color=spot1RGB
            spot1.setScale(spot1Scale)
            spot1.zPosition=11
            spot1.zRotation=spot1Rotation
            spot1.name="spot1"
 
        }
        else
        {
            spot1.texture=SKTexture(imageNamed: "spot64")
        }
        addSpecials()
        bornTime=NSDate()
        health=blobHealth
        growthTime=Double((computeLevel()*0)+1)
        
        
        //jitterAction=33
        switch jitterAction
        {
        case 12:
            
            let offset1=CGPoint(x: random(min: -5, max: 5), y: random(min: -5, max: 5))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
            
        case 28:
            
            let offset1=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let offset2=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.15),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        case 30:
            
            let offset1=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let offset2=CGPoint(x: random(min: -10, max: 10), y: random(min: -10, max: 10))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.55),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.55), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.55),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.55)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
            
        case 33:
            
            let offset1=CGPoint(x: random(min: -15, max: 15), y: 0)

            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        case 34:
            
            let offset1=CGPoint(x: 0, y: random(min: -15, max: 15))
            
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.15),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.15)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        case 41:
            let offset1=CGPoint(x: random(min: -15, max: 15), y: random(min: -15, max: 15))
            let offset2=CGPoint(x: random(min: -15, max: 15), y: random(min: -15, max: 15))
            let jitterAct=SKAction.sequence([SKAction.moveBy(x: offset1.x, y: offset1.y, duration: 0.25),SKAction.moveBy(x: -offset1.x, y: -offset1.y, duration: 0.25), SKAction.moveBy(x: offset2.x, y: offset2.y, duration: 0.25),SKAction.moveBy(x: -offset2.x, y: -offset2.y, duration: 0.25)])
            sprite.run(SKAction.repeatForever(jitterAct))
            
        default:
            break
            
        } // switch jitterAction
        
    

        
    }
    
    public func genNewDNA()
    {
        for i in 0..<GENECOUNT
        {
            generateNewGene(at: i)
        }
    }
    
    public func tripToDec(trip: String) -> Int
    {
        var num:Int=0
        var digit:Int=2
        //print("Trip: \(trip)" )
        for char in trip
        {
            var mult:Int=0
            switch char
            {
            case "R":
                mult=0
                
            case "G":
                mult=1
            case "B":
                mult=2
            case "Y":
                mult=3
            default:
                print("Error in tripToDec - Unknown base")
            } // swith
            
            num += 4^^digit * mult

            digit -= 1
            
        } // for
        return num
    } // func tripToDec()

    func threeGenesToDec(gene1: Int, gene2:Int, gene3: Int) -> Int
    {
        var num:Int=0
        var digit:Int=8
        var current:Int=0
        //print("Trip: \(trip)" )
        for gene in 0...2
        {
            if gene==0
            {
                current=gene1
            }
            else if gene==1
            {
                current=gene2
            }
            else if gene==2
            {
                current=gene3
            }
            let trip=getGene(num: current)
            for char in trip
            {
                var mult:Int=0
                switch char
                {
                case "R":
                    mult=0
                    
                case "G":
                    mult=1
                case "B":
                    mult=2
                case "Y":
                    mult=3
                default:
                    print("Error in three Genes to Dec - Unknown base")
                } // swith
                
                num += 4^^digit * mult
                
                digit -= 1
                
            } // for each character
        } // for each gene
        return num
        
    } // func threeGenesToDec
    
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
        //var type=Int(random(min: 0, max: 11.9999999))
        // print("Type: \(type)")
        //type=10
        print("Resetting Sprite")
        var seed=threeGenesToDec(gene1: 48, gene2: 49, gene3: 50)
        print("Seed: \(seed)")
        var type:Int=blobStyle-NUMBLOBTEXTURES
        switch type
        {
        case 0:
            noise=GKNoise(GKVoronoiNoiseSource(frequency: Double(random(min: 0.01, max: 0.025)), displacement: Double(random(min: 0.5, max: 3.5)), distanceEnabled: false, seed: Int32(seed)))
        case 1:
            noise=GKNoise(GKCylindersNoiseSource(frequency: Double(random(min: 0.01, max: 0.15))))
            mapCenter.x=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
            mapCenter.y=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
        case 2:
            noise=GKNoise(GKVoronoiNoiseSource(frequency: Double(random(min: 0.01, max: 0.025)), displacement: Double(random(min: 0.5, max: 3.5)), distanceEnabled: true, seed: Int32(seed)))
        case 3:
            noise=GKNoise(GKRidgedNoiseSource(frequency: Double(random(min: 0.01, max: 0.1)), octaveCount: Int(random(min: 1, max: 10)), lacunarity: Double(random(min: 0.001, max: 5)), seed: Int32(seed)))
            
        case 4:
            noise=GKNoise(GKSpheresNoiseSource(frequency: Double(random(min: 0.001, max: 0.55))))
            mapCenter.x=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
            mapCenter.y=Double(random(min: CGFloat(-mapSize.x*1.9), max: CGFloat(mapSize.x*1.9)))
            
        case 5:
            noise = GKNoise(GKBillowNoiseSource(frequency: Double(random(min: 0.015, max: 0.035)), octaveCount: Int(random(min: 15, max: 19.9999)), persistence: 0.65, lacunarity: 0.05, seed: Int32(seed)))
        case 6:
            noise = GKNoise(GKBillowNoiseSource(frequency: Double(random(min: 0.015, max: 0.035)), octaveCount: Int(random(min: 15, max: 19.9999)), persistence: 0.65, lacunarity: Double(random(min: 0.25, max: 0.65)), seed: Int32(seed)))
            
        case 7:
            noise=GKNoise(GKVoronoiNoiseSource(frequency: Double(random(min: 0.025, max: 0.25)), displacement: Double(random(min: 3.5, max: 8.5)), distanceEnabled: false, seed: Int32(seed)))
            
        case 8:
            noise=GKNoise(GKCheckerboardNoiseSource(squareSize: Double(random(min: 5.5, max: 15.5))))
            
        case 9:
            noise=GKNoise(GKCheckerboardNoiseSource(squareSize: Double(random(min: 15.5, max: 45.5))))
            
        case 10:
            noise=GKNoise(GKCheckerboardNoiseSource(squareSize: Double(random(min: 45.5, max: 145.5))))
            
        default:
            noise = GKNoise(GKBillowNoiseSource(frequency: Double(random(min: 0.01, max: 0.025)), octaveCount: Int(random(min: 1, max: 4.9999)), persistence: 0.2, lacunarity: 0.5, seed: Int32(seed)))
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
        if scene != nil
        {
            scene!.addChild(thisNode)
        }
        else
        {
            print("SCENE NIL.")
        }
        let retText=scene!.view!.texture(from: thisNode)
        thisNode.removeFromParent()
        return retText!
        
    }
    
    
    func wander()
    {
        if -lastWanderTurn.timeIntervalSinceNow > nextWanderTurn
        {
            let turnAmount=random(min: -CGFloat.pi*0.6, max: CGFloat.pi*0.6)
            turnToAngle=sprite.zRotation+turnAmount
            if turnToAngle > CGFloat.pi*2
            {
                turnToAngle-=CGFloat.pi*2
            }
            if turnToAngle < 0
            {
                turnToAngle+=CGFloat.pi*2
            }
            isTurning=true
            lastWanderTurn=NSDate()
            nextWanderTurn=Double(random(min: 2.5, max: 5.5))
        } // if it's time to turn
        
        // decide what to do with speed
        let chance=random(min: 0, max: 1)
        if chance > 0.75
        {
            speed += 0.1
        }
        else if chance > 0.5
        {
            speed -= 0.1
        }
        if speed > moveSpeed
        {
            speed=moveSpeed
        }
        if speed > 0
        {
            moveSpeed=0
        }
        
        
    } // func wander
    
    func doTurn()
    {
        if abs(sprite.zRotation-turnToAngle) < 0.1
        {
            isTurning=false
        }
        
        if isTurning
        {
            if sprite.zRotation-turnToAngle > 0 || sprite.zRotation-turnToAngle < -CGFloat.pi
            {
                sprite.zRotation -= 0.01
            }
            if sprite.zRotation-turnToAngle < 0 || sprite.zRotation-turnToAngle >= CGFloat.pi
            {
                sprite.zRotation += 0.01
            }
            
        } // if we're turning
    } // func doTurn
    
    func updatePosition()
    {
        let dx=cos(sprite.zRotation)*speed
        let dy=sin(sprite.zRotation)*speed
        sprite.position.x+=dx
        sprite.position.y+=dy
        
        // normalize rotation
        if sprite.zRotation > CGFloat.pi*2
        {
            sprite.zRotation -= CGFloat.pi*2
        }
        
        if sprite.zRotation < 0
        {
            sprite.zRotation += CGFloat.pi*2
        }
        
    } // func updatePosition
    
    public func getStandardDamage(against: BlobClass) -> CGFloat
    {
        // used to compute damage of one blob against another
        // taking into account type from attacker and resistance of defender
        var damage:CGFloat=0
        
        switch primaryDamageType
        {
        case DamageType.Poison:
            damage=blobDamage*against.poisonResist
            
        case DamageType.Physical:
            damage=blobDamage*against.physicalResist
            
        case DamageType.Electrical:
            damage=blobDamage*against.electricalResist
            
        case DamageType.Sonic:
            damage=blobDamage*against.sonicResist
            
        default:
            damage=blobDamage
            print("Error - Invalid damage type")
        } // switch

        return damage
        
    } // func getStandardDamage
    
    func checkSpecialAttacks()
    {
        
        if specialAttack1 == SpecialAttacks.ELECTRICWAVE
        {
            if -lastSpecialAttack1.timeIntervalSinceNow > special1Cool
            {
                let wave=SKSpriteNode(imageNamed: "electricWave")
                //wave.position=self.sprite.position
                wave.setScale(sprite.xScale*1.5)
                wave.name="SpecElectricWave"
                wave.physicsBody=SKPhysicsBody(circleOfRadius: wave.size.height*0.35)
                wave.physicsBody!.categoryBitMask=PHYSICSTYPES.ELECTRICWAVE
                wave.physicsBody!.collisionBitMask=PHYSICSTYPES.NOTHING
                wave.physicsBody!.contactTestBitMask=PHYSICSTYPES.BLOB
                sprite.addChild(wave)
                wave.run(SKAction.rotate(byAngle: CGFloat.pi*8, duration: 1))
                let waveAction = SKAction.sequence([SKAction.scale(to: 8, duration: 1.0), SKAction.fadeOut(withDuration: 0.1),SKAction.removeFromParent()])
                wave.run(waveAction)
                lastSpecialAttack1=NSDate()
                
            } // if wave is on cooldown
            
        } // if special is electric wave
        
        if specialAttack1 == SpecialAttacks.SONICWAVE
        {
            if -lastSpecialAttack1.timeIntervalSinceNow > special1Cool
            {
                let wave=SKSpriteNode(imageNamed: "sonicWave01")
                //wave.position=self.sprite.position
                wave.setScale(sprite.xScale*1.5)
                wave.name="SpecsonicWave"
                wave.physicsBody=SKPhysicsBody(circleOfRadius: wave.size.height*0.35)
                wave.physicsBody!.categoryBitMask=PHYSICSTYPES.SONICWAVE
                wave.physicsBody!.collisionBitMask=PHYSICSTYPES.NOTHING
                wave.physicsBody!.contactTestBitMask=PHYSICSTYPES.BLOB
                sprite.addChild(wave)
                wave.run(SKAction.rotate(byAngle: CGFloat.pi*8, duration: 1))
                let waveAction = SKAction.sequence([SKAction.scale(to: 8, duration: 1.0), SKAction.fadeOut(withDuration: 0.1),SKAction.removeFromParent()])
                wave.run(waveAction)
                lastSpecialAttack1=NSDate()
                
            } // if wave is on cooldown
            
        } // if special is electric wave
  
        if specialAttack1 == SpecialAttacks.POISONCLOUD
        {
            if -lastSpecialAttack1.timeIntervalSinceNow > special1Cool
            {
                let cloud=SKSpriteNode(imageNamed: "cloud01")
                //wave.position=self.sprite.position
                cloud.setScale(sprite.xScale*2.5)
                cloud.name="ElectricWave"
                cloud.physicsBody=SKPhysicsBody(circleOfRadius: cloud.size.height*0.35)
                cloud.physicsBody!.categoryBitMask=PHYSICSTYPES.POISONCLOUD
                cloud.physicsBody!.collisionBitMask=PHYSICSTYPES.NOTHING
                cloud.physicsBody!.contactTestBitMask=PHYSICSTYPES.BLOB
                cloud.position=sprite.position
                cloud.colorBlendFactor=1.0
                cloud.color=NSColor.green
                cloud.name="SpecpoisonCloud\(blobID)"
                scene!.addChild(cloud)
                cloud.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi*16, duration: 1.5)))
                cloud.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.5),SKAction.fadeAlpha(to: 1.0, duration: 0.5)])))
                cloud.run(SKAction.sequence([SKAction.wait(forDuration: 6.0),SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))

                //cloud.run(waveAction)
                lastSpecialAttack1=NSDate()
                
            } // if wave is on cooldown
            
        } // if special is electric wave
        
        
        if specialAttack1 == SpecialAttacks.LIGHTNINGBOLT         
        {
            if -lastSpecialAttack1.timeIntervalSinceNow > special1Cool
            {
                let bolt=SKSpriteNode(imageNamed: "lightningBolt01")
                //wave.position=self.sprite.position
    
                // get distance and angle to enemy
                let dx=enemy!.sprite.position.x-sprite.position.x
                let dy=enemy!.sprite.position.y-sprite.position.y
                let dist = hypot(dy, dx)
                let angle = atan2(dy, dx) - sprite.zRotation
                
                let distanceRatio:CGFloat=dist/258
                
                
                
                print("Distance: \(dist)")
                print("Angle: \(angle)")
                let posx=cos(angle)*(140+(bolt.size.width/2))
                let posy=sin(angle)*(140+(bolt.size.width/2))
                bolt.zRotation=angle
                bolt.position=CGPoint(x: posx, y: posy)
                
                bolt.name="SpecLightningBolt"
                bolt.physicsBody=SKPhysicsBody(rectangleOf: bolt.size)
                bolt.physicsBody!.categoryBitMask=PHYSICSTYPES.LIGHTNING
                bolt.physicsBody!.collisionBitMask=PHYSICSTYPES.NOTHING
                bolt.physicsBody!.contactTestBitMask=PHYSICSTYPES.BLOB
                bolt.physicsBody!.pinned=true
                bolt.physicsBody!.allowsRotation=false
                bolt.physicsBody!.mass=0
                bolt.zPosition=sprite.zPosition+10
                
                bolt.setScale(1.5)
                sprite.addChild(bolt)
                
                let flickerAction=SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.fadeIn(withDuration: 0.1), SKAction.wait(forDuration: 0.1)])
                bolt.run(SKAction.repeatForever(flickerAction))
                
                let boltAction = SKAction.sequence([SKAction.wait(forDuration: 0.8),SKAction.removeFromParent()])
                bolt.run(boltAction)
                lastSpecialAttack1=NSDate()
                
            } // if wave is on cooldown
            
        } // if special is electric wave
        
        
        if specialAttack1 == SpecialAttacks.VIRUSLAUNCH         // change to electric wave
        {
            if -lastSpecialAttack1.timeIntervalSinceNow > special1Cool
            {
                for i in 0...Int(random(min: 1, max: 3.9999))
                {
                    let virus=SKSpriteNode(imageNamed: "virus01")
                    //wave.position=self.sprite.position
                    virus.setScale(sprite.xScale*1.5)
                    virus.name="Specvirus"
                    virus.physicsBody=SKPhysicsBody(circleOfRadius: virus.size.height*0.35)
                    virus.physicsBody!.categoryBitMask=PHYSICSTYPES.VIRUS
                    virus.physicsBody!.collisionBitMask=PHYSICSTYPES.NOTHING
                    virus.physicsBody!.contactTestBitMask=PHYSICSTYPES.BLOB
                    scene!.addChild(virus)
                    let angle=sprite.zRotation-CGFloat.pi/2+random(min: -CGFloat.pi/4, max: CGFloat.pi/4)
                    let dx=cos(angle)*50
                    let dy=sin(angle)*50
                    let posx=cos(angle)*190
                    let posy=sin(angle)*190
                    virus.position=CGPoint(x: sprite.position.x+posx, y: sprite.position.y+posy)
                    virus.colorBlendFactor=1.0
                    virus.color=blobOuterRGB
                    virus.physicsBody!.applyImpulse(CGVector(dx: dx, dy: dy))
                    let virusAction=SKAction.sequence([SKAction.wait(forDuration: 10.0),SKAction.removeFromParent()])
                    virus.run(virusAction)
                    lastSpecialAttack1=NSDate()
                } // for each virus
            } // if wave is on cooldown
            
        } // if special is electric wave
    } // func checkSpecialAttacks
    

    public func update()
    {
       
        let timeDelta = -bornTime.timeIntervalSinceNow
        if timeDelta < growthTime
        {
            let growthRatio=CGFloat(timeDelta/growthTime)
            sprite.xScale=growthRatio
            sprite.yScale=growthRatio
        }
        else
        {
            //sprite.xScale=blobSize
            //sprite.yScale=blobSize
        }
        
        switch currentState
        {
        case STATE.WANDER:
            doTurn()
            wander()
            updatePosition()
            checkSpecialAttacks()
        default:
            break
        } // switch currentState
        
    } // update
    
    
    
} // class BlobClass


///////////////////////////////////////////
// Gene Map
///////////////////////////////////////////

// 0: Size
// 1: Color Red (0-1)
// 2: Color Green (0-1)
// 3: Color Blue (0-1)
// 4: Pulse Speed (0.25-1.0)
// 5: Alpha (0.5-1.0)
// 6: Spot 1 Angle
// 7: Spot 1 Distance
// 8: Spot 1 Alpha
// 9: Spot 1 RGB
// 10: Spot 1 Scale
// 11: Spot 1 Rotation
// 12: Special Power 1 Type
// 13: Special Power 2 Type
// 14: Spot 1 Shape

