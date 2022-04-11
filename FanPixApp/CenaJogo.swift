//
//  CenaJogo.swift
//  FanPixApp
//
//  Created by Matheus Maxwell Meireles on 02/06/17.
//  Copyright © 2017 maxnewsoftware. All rights reserved.
//

import SpriteKit

class CenaJogo: SKScene, SKPhysicsContactDelegate {
    
    var fant = SKSpriteNode()
    var _comecou = false
    var _acabou = false
    let objetoDummyMoveCena = SKNode()
    
    let grupoFant:UInt32 = 1
    let grupoCano:UInt32 = 2
    let grupoMarcadores:UInt32 = 0
    
    var imagemFundo:SKSpriteNode = SKSpriteNode()
    
    var impulse = 0
    
    var timer = Timer()
    
    var txtPers = ""
    
    var morcegoMount = SKSpriteNode(imageNamed: "morcegoVirado1")
    
    var score:Int = 0
    var distanciaPercorrida:Int = 0
    var recordePontos:Int = 0
    var recordeDistancia:Int = 0
    
    var botaoPausa:SKSpriteNode = SKSpriteNode()
    
    var pausa = false
    
    let pauseLayer = SKNode()
    let gameLeyer = SKNode()
    
    
    
    var botaoVoltar:SKSpriteNode = SKSpriteNode ()
    var botaoSair:SKSpriteNode = SKSpriteNode()
    
    var morcegosLabel = SKLabelNode ()
    
    var hudMorcego = SKSpriteNode ()
    
    let label = SKLabelNode()
    
    var numeroItemMorcego:Int = 0
    
    var autorizado = true
   /* var numeroItemSementes:Int = 0
    
    var hudSemente = SKSpriteNode()
    var hudEstrela = SKSpriteNode()
    var sementesLabel = SKLabelNode()
    var estrelasLabel = SKLabelNode()
    */
    var distanciaLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var textoInicio = SKLabelNode()
    var botaoPausarLabel = SKLabelNode()
    
    //var estadoInvisivel = false
    var estadoInvencivel = false
    
    //var somFlecha = SKAction.playSoundFileNamed("somBolhaShot.mp3", waitForCompletion: false)
    var somClica = SKAction.playSoundFileNamed("somClick.mp3", waitForCompletion: false)
    var somFimDeJogo = SKAction.playSoundFileNamed("Game Over 01.mp3", waitForCompletion: false)
    var somHit = SKAction.playSoundFileNamed("somHit.mp3", waitForCompletion: false)
    var somVoa = SKAction.playSoundFileNamed("Jump3.mp3", waitForCompletion: false)
    //var somInvencivel = SKAction.playSoundFileNamed("somInvencible.mp3", waitForCompletion: false)
    //var somScore = SKAction.playSoundFileNamed("somScore.mp3", waitForCompletion: false)
    var somMorcego = SKAction.playSoundFileNamed("somMorcego.mp3", waitForCompletion: false)
    var somMorde = SKAction.playSoundFileNamed("somMorde.mp3", waitForCompletion: false)
    var somFelpudoVoa = SKAction.playSoundFileNamed("Jump3.mp3", waitForCompletion: false)
    //var somInvisivelStart = SKAction.playSoundFileNamed("somInvisibleStarts.mp3", waitForCompletion: false)
    //var somInvisivelEnd = SKAction.playSoundFileNamed("somInvisibleEnds.mp3", waitForCompletion: false)
    
    
    
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.black
        
        self.physicsWorld.contactDelegate = self
        
        carregarJogo()
        
        
        let moveFundo = SKAction.moveBy(x: -self.size.width, y: 0, duration: 9)
        let reposicionaFundo = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let moveFundoSempre = SKAction.repeatForever(SKAction.sequence([moveFundo, reposicionaFundo]))
        
        for i in 0 ... 2 {
            
            imagemFundo = SKSpriteNode(imageNamed: "fundo_2")
            imagemFundo.size.width = self.size.width
            imagemFundo.size.height = self.size.height
            imagemFundo.position = CGPoint(x: self.size.width/2 + self.size.width * CGFloat(i), y: self.size.height/2)
            imagemFundo.run(moveFundoSempre)
            imagemFundo.zPosition = -1
            imagemFundo.alpha = 0.85
            imagemFundo.texture!.filteringMode = .nearest
            objetoDummyMoveCena.addChild(imagemFundo)
            
        }
        
        self.addChild(objetoDummyMoveCena)
        
    
       // criaObjetoDeath()
        criaObjetoFant()
        
        let chaoDummy = SKNode()
        chaoDummy.position = CGPoint(x: self.size.width/2, y: -10)
        chaoDummy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 1))
        chaoDummy.physicsBody?.isDynamic = false
        self.addChild(chaoDummy)
        
        let tetoDummy = SKNode()
        tetoDummy.position = CGPoint(x: self.size.width/2, y: self.size.height+10)
        tetoDummy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width,height: 1))
        tetoDummy.physicsBody?.isDynamic = false
        self.addChild(tetoDummy)
        
        chaoDummy.name = "chaoTeto"
        tetoDummy.name = "chaoTeto"
        
        
        hudMorcego = SKSpriteNode(imageNamed: "morcego1")
        hudMorcego.name = "Hud Morcego"
        hudMorcego.texture?.filteringMode = .nearest
        hudMorcego.size.width = 80
        hudMorcego.size.height = 60
        hudMorcego.position = CGPoint(x: hudMorcego.size.width/2+10, y: hudMorcego.size.height/2+10)
        /*hudEstrela = SKSpriteNode(imageNamed: "estrela")
        
        hudSemente.name = "Hud Semente"
        hudEstrela.name = "Hud Estrela"
        
        hudSemente.texture?.filteringMode = .nearest
        hudEstrela.texture?.filteringMode = .nearest
        
        hudSemente.size.width = 70
        hudSemente.size.height = 70 //85
        
        hudEstrela.size.width = 70
        hudEstrela.size.height = 70
        
        hudEstrela.position = CGPoint(x: self.size.width-hudEstrela.size.width/2-10, y: hudEstrela.size.height/2+10)
        hudSemente.position = CGPoint(x: hudSemente.size.width/2+10, y: hudSemente.size.height/2+10)
        */
        
        botaoPausa = SKSpriteNode (imageNamed: "botaoPausa")
        botaoPausa.texture!.filteringMode = .nearest
        botaoPausa.setScale(1.3)
        botaoPausa.position = CGPoint(x: self.size.width-16, y: self.size.height-16)
        botaoPausa.name = "Botao Pausa"
        
        distanciaLabel = SKLabelNode()
        distanciaLabel.fontName = "True Crimes"
        distanciaLabel.fontSize = 17
        distanciaLabel.text = "Distancia: \(distanciaPercorrida) m."
        distanciaLabel.position = CGPoint(x: 10, y: self.frame.size.height-30)
        distanciaLabel.horizontalAlignmentMode = .left
        distanciaLabel.zPosition = 11
        
        self.addChild(botaoPausa)
        
        hudMorcego.zPosition = 12
        morcegosLabel = SKLabelNode ()
        morcegosLabel.fontName = "True Crimes"
        morcegosLabel.fontSize = 47
        morcegosLabel.fontColor = UIColor.white
        morcegosLabel.text = "\(numeroItemMorcego)"
        /*sementesLabel = SKLabelNode()
        sementesLabel.fontName = "True Crimes"
        sementesLabel.fontSize = 47
        sementesLabel.fontColor = UIColor.orange
        sementesLabel.text = "\(numeroItemSementes)"
        
        hudSemente.zPosition = 12
        hudEstrela.zPosition = 12
        
        sementesLabel.zPosition = 12
        
        estrelasLabel = SKLabelNode()
        estrelasLabel.fontName = "True Crimes"
        estrelasLabel.fontSize = 47
        estrelasLabel.fontColor = UIColor.black
        estrelasLabel.text = "\(numeroItemEstrelas)"
        estrelasLabel.zPosition = 12
        
        sementesLabel.position.y -= 21
        estrelasLabel.position.y -= 21
        
        sementesLabel.name = "Hud Semente"
        estrelasLabel.name = "Hud Estrela"
        */
       /* scoreLabel = SKLabelNode()
        scoreLabel.fontName = "True Crimes"
        scoreLabel.fontSize = 130
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height-140)
        scoreLabel.alpha = 0.65
        scoreLabel.zPosition = 11
        scoreLabel.text = "\(score)"
        
        self.addChild(scoreLabel)*/
        //self.addChild(hudSemente)
        //self.addChild(hudEstrela)
        self.addChild(hudMorcego)
        self.addChild(distanciaLabel)
        hudMorcego.addChild(morcegosLabel)
        //hudSemente.addChild(sementesLabel)
        //hudEstrela.addChild(estrelasLabel)
        
        textoInicio = SKLabelNode()
        textoInicio.fontName = "True Crimes"
        textoInicio.fontSize = 25
        textoInicio.text = "Toque para iniciar"
        textoInicio.position = CGPoint(x: self.frame.midX, y: self.frame.size.height/2+50)
        textoInicio.alpha = 0.65
        textoInicio.zPosition = 11
        
        self.addChild(textoInicio)
        
        scoreLabel.isHidden = true
        
        label.fontName = "True Crimes"
        label.fontSize = 25
        label.position = CGPoint (x: self.size.width/2, y: self.size.height/2)
        label.fontColor = UIColor.white
        label.text = "Toque para reiniciar"
        
       
        
    }
    
    func criaObjetoPrincipal (txt:String){
        if(txt == "Botao Fant"){
            criaObjetoFant()
        }
        else{
            if(txt == "Botao Death"){
                criaObjetoDeath()
            }
        }
    }
    
    func criaObjetoFant (){
        
        var arrayImagensFant:[SKTexture]=[]
        var animacaoFantVoa = SKAction()
        
        for i in 1 ... 3 { //6
            let imagem = SKTexture(imageNamed: "fantasminha\(i)") //felpudoVoa\(i)
            imagem.filteringMode = .nearest
            arrayImagensFant.append(imagem)
        }
        
        animacaoFantVoa = SKAction.animate(with: arrayImagensFant, timePerFrame: 0.07, resize: false, restore: true)
        fant = SKSpriteNode(texture: arrayImagensFant[1])
        fant.setScale(0.3) //1.5
        fant.position = CGPoint(x: self.size.width/3, y: self.size.height/2)
        fant.zPosition = 10
        fant.run(SKAction.repeatForever(animacaoFantVoa))
        impulse = 40
        self.addChild(fant)
    }
    
    func criaObjetoDeath () {
        
        var arrayImagensDeath:[SKTexture]=[]
        var animacaoDeathVoa = SKAction()
        
        for i in 1 ... 3 { //6
            let imagem = SKTexture(imageNamed: "death\(i)")
            imagem.filteringMode = .nearest
            arrayImagensDeath.append(imagem)
        }
        
        animacaoDeathVoa = SKAction.animate(with: arrayImagensDeath, timePerFrame: 0.07, resize: false, restore: true)
        fant = SKSpriteNode(texture: arrayImagensDeath[1])
        fant.setScale(0.3) //1.5
        fant.position = CGPoint(x: self.size.width/3, y: self.size.height/2)
        fant.zPosition = 10
        fant.run(SKAction.repeatForever(animacaoDeathVoa))
        impulse = 50
        self.addChild(fant)
        
    }
    
    @objc func sorteiaObjetos(){
        let sorteiaObjeto = Int(arc4random_uniform(30)+1)
        //criaObjetoMorcego()
        if(!pausa){
            if(distanciaPercorrida < 50){
                if sorteiaObjeto < 29 {
                    criaObjetoBloco()
                }
                if sorteiaObjeto == 30{
                    criaObjetoMorcego()
                }
            }
            if(distanciaPercorrida >= 50 && distanciaPercorrida < 200){
                if(distanciaPercorrida<100 && !estadoInvencivel){
                    physicsWorld.speed = 1.1
                    speed = 1.1
                }
                if(distanciaPercorrida>=100 && !estadoInvencivel){
                    physicsWorld.speed = 1.2
                    speed = 1.2
                }
                if sorteiaObjeto < 29 {
                    
                    cria2ObjetoBloco()
                }
                else {
                    criaObjetoMorcego()
                }
            }
            if(distanciaPercorrida >= 200){
                if(distanciaPercorrida<250 && !estadoInvencivel){
                    physicsWorld.speed = 1.3
                    speed = 1.3
                }
                if(distanciaPercorrida>=250 && !estadoInvencivel){
                    physicsWorld.speed = 1.5
                    speed = 1.5
                }
                
                if(sorteiaObjeto <= 20){
                    cria2ObjetoBloco()
                }
                else{
                    cria3ObjetoBloco()
                }
            }
            
            
            _ = Timer.scheduledTimer(timeInterval: retornaTempo(), target: self, selector: #selector(CenaJogo.sorteiaObjetos), userInfo: nil, repeats: false)
        }
        
        
        
    }
    
    /*func criaObjetoCanos(){
        
        let vao = SKNode() //espaco em branco entre os canos
        let canoCima = SKSpriteNode(imageNamed: "canoCima")
        let canoBaixo = SKSpriteNode(imageNamed: "canoBaixo")
        
        let moveCano = SKAction.moveBy(x: -self.frame.size.width * 3, y: 0, duration: TimeInterval(4/speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        let alturaVao = CGFloat(150)
        
        canoBaixo.setScale(3*0.75)
        canoCima.setScale(3*0.75)
        
        let numeroRandom = arc4random() % UInt32(100)
        let alturaRandom = CGFloat(numeroRandom) - 50
        
        canoBaixo.position = CGPoint(x: self.size.width + canoBaixo.size.width/2+10, y: alturaRandom)
        vao.position = CGPoint(x: canoBaixo.position.x + canoBaixo.size.width/2, y: canoBaixo.position.y + canoBaixo.size.height/2 + alturaVao/2)
        canoCima.position = CGPoint(x: canoBaixo.position.x, y: canoBaixo.position.y + canoCima.size.height + alturaVao)
        canoCima.texture?.filteringMode = .nearest
        canoBaixo.texture?.filteringMode = .nearest
        canoCima.physicsBody = SKPhysicsBody(rectangleOf: canoCima.size)
        canoBaixo.physicsBody = SKPhysicsBody(rectangleOf: canoBaixo.size)
        
        vao.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 3, height: self.size.height*2))
        vao.physicsBody?.isDynamic = false
        canoCima.physicsBody?.isDynamic = false
        canoBaixo.physicsBody?.isDynamic = false
        
        canoBaixo.name = "cimaBaixo"
        canoCima.name = "cimaBaixo"
        vao.name = "vao"
        
        vao.physicsBody?.collisionBitMask = grupoMarcadores
        vao.physicsBody?.categoryBitMask = grupoMarcadores
        vao.physicsBody?.contactTestBitMask = grupoFant
        
        vao.run(sequenciaCano)
        canoBaixo.run(sequenciaCano)
        canoCima.run(sequenciaCano)
        
        objetoDummyMoveCena.addChild(canoBaixo)
        objetoDummyMoveCena.addChild(canoCima)
        objetoDummyMoveCena.addChild(vao)
        
    }*/
    
    func criaObjetoMorcego (){
        
        var morcego = SKSpriteNode(imageNamed: "morcego1")
        let imagem = SKTexture(imageNamed: "morcego1")
        //let imagemSeed2 = SKTexture(imageNamed: "semente2")
        var arrayMorc:[SKTexture] = []
        
        for i in 1 ... 4{
            let imagemMorc = SKTexture(imageNamed: "morcego\(i)")
            imagemMorc.filteringMode = .nearest
            arrayMorc.append(imagemMorc)
        }
        
        //let arrayImagensSemente:[SKTexture] = [imagemSeed1, imagemSeed2]
        
        let moveMorc = SKAction.moveBy(x: -self.frame.size.width*3, y: 0, duration: TimeInterval(4/speed))
        let apagaMorc = SKAction.removeFromParent()
        let sequenciaMorc = SKAction.sequence([moveMorc, apagaMorc])
        
        morcego = SKSpriteNode(texture: imagem)
        morcego.setScale(0.7)
        morcego.texture!.filteringMode = .nearest
        morcego.physicsBody = SKPhysicsBody(rectangleOf: morcego.size)
        morcego.physicsBody?.isDynamic = false
        morcego.physicsBody?.collisionBitMask = grupoMarcadores
        morcego.physicsBody?.categoryBitMask = grupoMarcadores
        morcego.physicsBody?.contactTestBitMask = grupoFant
        morcego.name = "Morcego"
        morcego.run(SKAction.repeatForever(SKAction.animate(with: arrayMorc, timePerFrame: 0.1, resize: false, restore: true)))
        
        let objParent = SKNode()
        let randomPosicaoItem = CGFloat(arc4random_uniform(300)) - 100
        
        objParent.position = CGPoint(x: self.size.width+100, y: self.size.height/2 + randomPosicaoItem)
        objParent.run(sequenciaMorc)
        objParent.addChild(morcego)
        
        objetoDummyMoveCena.addChild(objParent)
        criaParticulaMorcego(objeto: objParent)
        
    }
    
    func criaObjetoMorcegoVirado (objeto:SKNode) {
        let imagem = SKTexture(imageNamed: "morcegoVirado1")
        var arrayMorc:[SKTexture] = []
        
        for i in 1 ... 4{
            let imagemMorc = SKTexture(imageNamed: "morcegoVirado\(i)")
            imagemMorc.filteringMode = .nearest
            arrayMorc.append(imagemMorc)
        }
        
        
        morcegoMount = SKSpriteNode(texture: imagem)
        morcegoMount.setScale(1.1)
        morcegoMount.position.x = objeto.position.x - 3
        morcegoMount.position.y = objeto.position.y - 5
        morcegoMount.run(SKAction.repeatForever(SKAction.animate(with: arrayMorc, timePerFrame: 0.1, resize: false, restore: true)))
        morcegoMount.run(SKAction.fadeAlpha(to: 1, duration: 10))
        morcegoMount.texture!.filteringMode = .nearest
        morcegoMount.zPosition = 10
        morcegoMount.name = "Morcego"
        

        objetoDummyMoveCena.addChild(morcegoMount)
    }
    
    func criaObjetoBloco () {
        
        var bloco = SKSpriteNode(imageNamed: "bloco")
        let imagem = SKTexture(imageNamed: "bloco")
        //let imagemSeed2 = SKTexture(imageNamed: "semente2")
        var arrayBloco:[SKTexture] = []
        
        
        let imagemBloco = SKTexture(imageNamed: "bloco")
        imagemBloco.filteringMode = .nearest
        arrayBloco.append(imagemBloco)
   
        
        //let arrayImagensSemente:[SKTexture] = [imagemSeed1, imagemSeed2]
        
        let moveBloco = SKAction.moveBy(x: -self.frame.size.width*3, y: 0, duration: TimeInterval(4/speed))
        let apagaBloco = SKAction.removeFromParent()
        let sequenciaBloco = SKAction.sequence([moveBloco, apagaBloco])
        
        bloco = SKSpriteNode(texture: imagem)
        bloco.setScale(0.2)
        bloco.texture!.filteringMode = .nearest
        bloco.physicsBody = SKPhysicsBody(rectangleOf: bloco.size)
        bloco.physicsBody?.isDynamic = false
        bloco.physicsBody?.collisionBitMask = grupoMarcadores
        bloco.physicsBody?.categoryBitMask = grupoMarcadores
        bloco.physicsBody?.contactTestBitMask = grupoFant
        bloco.name = "cimaBaixo"
        bloco.run(SKAction.repeatForever(SKAction.animate(with: arrayBloco, timePerFrame: 0.1, resize: false, restore: true)))
        
        let objParent = SKNode()
        let randomPosicaoItem = CGFloat(arc4random_uniform(300)) - 100
        
        objParent.position = CGPoint(x: self.size.width+100, y: self.size.height/2 + randomPosicaoItem)
        objParent.run(sequenciaBloco)
        objParent.addChild(bloco)
        
        objetoDummyMoveCena.addChild(objParent)
        
        
    }
    
    func cria2ObjetoBloco() {
        
        let vao = SKNode() //espaco em branco entre os canos
        let blocoCima = SKSpriteNode(imageNamed: "bloco")
        let blocoBaixo = SKSpriteNode(imageNamed: "bloco")
        
        let moveCano = SKAction.moveBy(x: -self.frame.size.width * 3, y: 0, duration: TimeInterval(4/speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        let alturaVao = CGFloat(200)
        
        blocoBaixo.setScale(0.2)
        blocoCima.setScale(0.2)
        
        let numeroRandom = arc4random() % UInt32(100)
        let alturaRandom = CGFloat(numeroRandom) + 100
        
        blocoBaixo.position = CGPoint(x: self.size.width + blocoBaixo.size.width/2+120, y: alturaRandom)
        vao.position = CGPoint(x: blocoBaixo.position.x + blocoBaixo.size.width/2, y: blocoBaixo.position.y + blocoBaixo.size.height/2 + alturaVao/2)
        blocoCima.position = CGPoint(x: blocoBaixo.position.x, y: blocoBaixo.position.y + blocoCima.size.height + alturaVao)
        blocoCima.texture?.filteringMode = .nearest
        blocoBaixo.texture?.filteringMode = .nearest
        blocoCima.physicsBody = SKPhysicsBody(rectangleOf: blocoCima.size)
        blocoBaixo.physicsBody = SKPhysicsBody(rectangleOf: blocoBaixo.size)
        
        vao.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 3, height: self.size.height*2))
        vao.physicsBody?.isDynamic = false
        blocoCima.physicsBody?.isDynamic = false
        blocoBaixo.physicsBody?.isDynamic = false
        
        blocoBaixo.name = "cimaBaixo"
        blocoCima.name = "cimaBaixo"
        vao.name = "vao"
        
        vao.physicsBody?.collisionBitMask = grupoMarcadores
        vao.physicsBody?.categoryBitMask = grupoMarcadores
        vao.physicsBody?.contactTestBitMask = grupoFant
        
        vao.run(sequenciaCano)
        blocoBaixo.run(sequenciaCano)
        blocoCima.run(sequenciaCano)
        
        objetoDummyMoveCena.addChild(blocoBaixo)
        objetoDummyMoveCena.addChild(blocoCima)
        objetoDummyMoveCena.addChild(vao)

    }
    
    func cria3ObjetoBloco () {
        let vao = SKNode() //espaco em branco entre os canos
        let vao2 = SKNode ()
        let blocoCima = SKSpriteNode(imageNamed: "bloco")
        let blocoBaixo = SKSpriteNode(imageNamed: "bloco")
        let blocoMeio = SKSpriteNode(imageNamed: "bloco")
        
        let moveBloco = SKAction.moveBy(x: -self.frame.size.width * 3, y: 0, duration: TimeInterval(4/speed))
        let apagaBloco = SKAction.removeFromParent()
        let sequenciaBloco = SKAction.sequence([moveBloco, apagaBloco])
        let alturaVao = CGFloat(150)
        
        blocoBaixo.setScale(0.2)
        blocoCima.setScale(0.2)
        blocoMeio.setScale(0.2)
        
        let numeroRandom = arc4random() % UInt32(100)
        let alturaRandom = CGFloat(numeroRandom) + 50
        
        blocoBaixo.position = CGPoint(x: self.size.width + blocoBaixo.size.width/2+120, y: alturaRandom)
        vao.position = CGPoint(x: blocoBaixo.position.x + blocoBaixo.size.width/2, y: blocoBaixo.position.y + blocoBaixo.size.height/2 + alturaVao/2)
        blocoMeio.position = CGPoint(x: blocoBaixo.position.x, y: blocoBaixo.position.y + blocoMeio.size.height + alturaVao)
        blocoCima.position = CGPoint(x: blocoBaixo.position.x, y: blocoMeio.position.y + blocoCima.size.height + alturaVao)
        blocoCima.texture?.filteringMode = .nearest
        blocoMeio.texture?.filteringMode = .nearest
        blocoBaixo.texture?.filteringMode = .nearest
        blocoCima.physicsBody = SKPhysicsBody(rectangleOf: blocoCima.size)
        blocoMeio.physicsBody = SKPhysicsBody(rectangleOf: blocoMeio.size)
        blocoBaixo.physicsBody = SKPhysicsBody(rectangleOf: blocoBaixo.size)
        
        vao.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 3, height: self.size.height*2))
        vao.physicsBody?.isDynamic = false
        vao2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 3, height: self.size.height*2))
        vao2.physicsBody?.isDynamic = false
        blocoMeio.physicsBody?.isDynamic = false
        blocoBaixo.physicsBody?.isDynamic = false
        blocoCima.physicsBody?.isDynamic = false
        
        blocoBaixo.name = "cimaBaixo"
        blocoMeio.name = "cimaBaixo"
        blocoCima.name = "cimaBaixo"
        vao.name = "vao"
        vao2.name = "vao"
        
        vao.physicsBody?.collisionBitMask = grupoMarcadores
        vao.physicsBody?.categoryBitMask = grupoMarcadores
        vao.physicsBody?.contactTestBitMask = grupoFant
        
        vao2.physicsBody?.collisionBitMask = grupoMarcadores
        vao2.physicsBody?.categoryBitMask = grupoMarcadores
        vao2.physicsBody?.contactTestBitMask = grupoFant
        
        vao.run(sequenciaBloco)
        vao2.run(sequenciaBloco)
        blocoBaixo.run(sequenciaBloco)
        blocoMeio.run(sequenciaBloco)
        blocoCima.run(sequenciaBloco)
        
        objetoDummyMoveCena.addChild(blocoBaixo)
        objetoDummyMoveCena.addChild(blocoMeio)
        objetoDummyMoveCena.addChild(blocoCima)
        objetoDummyMoveCena.addChild(vao)
        objetoDummyMoveCena.addChild(vao2)
    }
    
    /*func criaObjetoEstrela(){
        let itemEstrela = SKSpriteNode(imageNamed: "estrela")
        
        let moveCano = SKAction.moveBy(x: -self.frame.size.width*3, y: 0, duration: TimeInterval(4/speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        
        itemEstrela.setScale(3*1.3)
        itemEstrela.texture!.filteringMode = .nearest
        itemEstrela.physicsBody = SKPhysicsBody(rectangleOf: itemEstrela.size)
        itemEstrela.physicsBody?.isDynamic = false
        itemEstrela.physicsBody?.collisionBitMask = grupoMarcadores
        itemEstrela.physicsBody?.categoryBitMask = grupoMarcadores
        itemEstrela.physicsBody?.contactTestBitMask = grupoFant
        itemEstrela.name = "Estrela"
        
        let objParent = SKNode()
        let randomPosicaoItem = CGFloat(arc4random_uniform(100)) - 50
        
        objParent.position = CGPoint(x: self.size.width+100, y: self.size.height/2 + randomPosicaoItem)
        objParent.run(sequenciaCano)
        objParent.addChild(itemEstrela)
        
        objetoDummyMoveCena.addChild(objParent)
        
        
    }
    
    func criaObjetoFlecha(){
        let itemFlecha = SKSpriteNode(imageNamed: "flecha")
        
        let moveCano = SKAction.moveBy(x: -self.frame.size.width*3, y: 0, duration: TimeInterval(4/speed))
        let apagaCano = SKAction.removeFromParent()
        let sequenciaCano = SKAction.sequence([moveCano, apagaCano])
        
        itemFlecha.setScale(3*1.3)
        itemFlecha.texture!.filteringMode = .nearest
        itemFlecha.physicsBody = SKPhysicsBody(rectangleOf: itemFlecha.size)
        itemFlecha.physicsBody?.isDynamic = false
        itemFlecha.physicsBody?.collisionBitMask = grupoMarcadores
        itemFlecha.physicsBody?.categoryBitMask = grupoMarcadores
        itemFlecha.physicsBody?.contactTestBitMask = grupoFant
        itemFlecha.name = "cimaBaixo"
        
        let objParent = SKNode()
        let randomPosicaoItem = CGFloat(arc4random_uniform(100)) - 50
        
        objParent.position = CGPoint(x: self.size.width+100, y: self.size.height/2 + randomPosicaoItem)
        objParent.run(sequenciaCano)
        objParent.addChild(itemFlecha)
        
        objetoDummyMoveCena.addChild(objParent)
        
        self.run (somFlecha)
        
        
        
    }*/
    
    func retornaTempo () -> Double{
        var tempo = 3.0
        
        if (pausa){
            tempo = 0
        }
        if(distanciaPercorrida <= 10){
            tempo = 3.0
        }
        if(distanciaPercorrida > 10 && distanciaPercorrida <= 20){
            tempo = 2.5
        }
        if(distanciaPercorrida > 20) && (distanciaPercorrida <= 40){
            tempo = 2.0
        }
        if(distanciaPercorrida > 40) && (distanciaPercorrida <= 100){
            tempo = 1.5
        }
        if(distanciaPercorrida > 100) && (distanciaPercorrida <= 200){
            tempo = 1.0
        }
        if(distanciaPercorrida > 200) && (distanciaPercorrida <= 300){
            tempo = 0.5
        }
        if(distanciaPercorrida > 300){
            tempo = 0.2
        }
        
        return tempo
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!autorizado){
            label.removeFromParent()
            objetoDummyMoveCena.isPaused = false
            imagemFundo.isPaused = false
            physicsWorld.speed = 1
            fant.physicsBody?.isDynamic = true
            pausa = false
            autorizado = true
            _ = Timer.scheduledTimer(timeInterval: retornaTempo(), target: self, selector: #selector(CenaJogo.sorteiaObjetos), userInfo: nil, repeats: false)
        }
        if !_acabou && autorizado && !estadoInvencivel{
            
            if !_comecou {
                fant.physicsBody = SKPhysicsBody(circleOfRadius: fant.size.height/2)
                fant.physicsBody?.isDynamic = true
                fant.physicsBody?.allowsRotation = false
                fant.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                fant.physicsBody?.applyImpulse(CGVector(dx: 0,dy: impulse)) //150 //60
                
                fant.physicsBody?.categoryBitMask = grupoFant
                fant.physicsBody?.contactTestBitMask = grupoCano
                fant.physicsBody?.collisionBitMask = grupoMarcadores
                
                textoInicio.isHidden = true
                scoreLabel.isHidden = false
                _comecou = true
                _ = Timer.scheduledTimer(timeInterval: retornaTempo(), target: self, selector: #selector(CenaJogo.sorteiaObjetos), userInfo: nil, repeats: false)
                _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(CenaJogo.contaDistancia), userInfo: nil, repeats: true)
                
            }else{
                fant.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                fant.physicsBody?.applyImpulse(CGVector(dx: 0,dy: impulse))
            }
            if(!pausa){
                self.run(somVoa)
            }
            
        }
        
        for touch: AnyObject in touches {
            let location: CGPoint! = touch.location(in: self)
            let nodeAtPoint : SKNode = self.atPoint(location)
            if (nodeAtPoint.name == "Botao Replay"){
                self.removeAllActions()
                let reveal = SKTransition.flipHorizontal(withDuration: 1)
                let scene = CenaJogo(size: self.size)
                self.view?.presentScene(scene, transition: reveal)
                self.run (somClica)
            }
            if(nodeAtPoint.name == "Botao Inicio"){
                self.removeAllActions()
                let reveal = SKTransition.doorsCloseVertical(withDuration: 1)
                let scene = MenuInicio(size: self.size)
                self.view?.presentScene(scene, transition: reveal)
                self.run (somClica)
            }
            
            if(nodeAtPoint.name == "Botao Pausa" && !_acabou) {
                objetoDummyMoveCena.isPaused = true
                imagemFundo.isPaused = true
                fant.physicsBody?.isDynamic = false
                physicsWorld.speed = 0
                self.botoesPausarJogo()
                pausa = true
                self.run (somClica)
            }
            
            if(nodeAtPoint.name == "Botao Voltar") {
               
                removeBotoesPausa()
                self.run (somClica)
                
                
                self.addChild(label)
                
                label.isHidden = false
                autorizado = false
                
            }
            
            if((nodeAtPoint.name == "Hud Morcego") && (!_acabou) && (!pausa)){
                if(numeroItemMorcego > 0){
                    numeroItemMorcego -= 1
                    morcegosLabel.text = "\(numeroItemMorcego)"
                    ficaInvencivelOn()
                    
                }
            }
            
            /*if((nodeAtPoint.name == "Hud Estrela") && (!_acabou)){
                if(numeroItemEstrelas > 0){
                    numeroItemEstrelas -= 1
                    estrelasLabel.text = "\(numeroItemEstrelas)"
                    ficaInvencivelOn();
                }
            }*/
        }
        
        
    }
    
    /*override func update (_ currentTime: CFTimeInterval){ //faz o passaro empinar para cima ou para baixo
     if _comecou {
     let num = felpudo.physicsBody!.velocity.dy as! CGFloat
     felpudo.zRotation = self.empinada (min: -1, max: 0.5, valor: num * 0.001)
     }
     }
     
     func empinada(min: CGFloat, max: CGFloat, valor: CGFloat) -> CGFloat {
     if (valor > max){
     return max
     }
     else if (valor < min){
     return min
     }
     else{
     return valor
     }
     }*/
    
    
    func didEnd(_ contact: SKPhysicsContact) { //evento para passar e pontuar
        
        if !_acabou {
            if contact.bodyA.categoryBitMask == grupoMarcadores || contact.bodyB.categoryBitMask == grupoMarcadores{
                if(contact.bodyA.node?.name == "vao"){
                    score += 1
                    contact.bodyA.node?.removeFromParent();
                    //self.run (somScore)
                    
                }
                scoreLabel.text = "\(score)"
            }
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == grupoMarcadores || contact.bodyB.categoryBitMask == grupoMarcadores{
            
        }
        
        if(contact.bodyA.node?.name == "cimaBaixo") || contact.bodyA.node?.name == "chaoTeto" {
            if !estadoInvencivel{
                if !_acabou {
                    _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CenaJogo.botoesGameOver), userInfo: nil, repeats: false)
                }
                _acabou = true
                objetoDummyMoveCena.speed = 0
                imagemFundo.speed = 0
                fant.physicsBody?.applyImpulse(CGVector(dx: -100, dy: 0))
                salvarRecordes()
                
                self.run (somHit)
                
                
            }
        }
        
        if(contact.bodyA.node?.name == "Morcego"){
            numeroItemMorcego += 1
            morcegosLabel.text = "\(numeroItemMorcego)"
          //  criaFumacinha(objeto: contact.bodyA.node!.parent!) --> criar asa
            contact.bodyA.node?.removeFromParent()
            self.run (somMorcego)
            
        }
        /*
        if(contact.bodyA.node?.name == "Estrela"){
            numeroItemEstrelas += 1
            estrelasLabel.text = "\(numeroItemEstrelas)"
            criaFumacinha(objeto: contact.bodyA.node!.parent!)
            contact.bodyA.node?.removeFromParent()
            self.run (somEstrela)
            
        }*/
    }
    
    /*func criaFumacinha (objeto:SKNode){
        
        let fumacinha = SKSpriteNode(imageNamed: "fumacinha")
        fumacinha.position = objeto.position
        fumacinha.run(SKAction.sequence([SKAction.scale(to: 3.5, duration: 0.15), SKAction.removeFromParent()]))
        fumacinha.run(SKAction.fadeAlpha(to: 0, duration: 015))
        fumacinha.texture!.filteringMode = .nearest
        fumacinha.zPosition = 20
        
        objetoDummyMoveCena.addChild(fumacinha)
    }*/
    
    @objc func contaDistancia(){
        
        if !_acabou && !pausa{
            
            distanciaPercorrida += 1
            distanciaLabel.text = "Distancia: \(distanciaPercorrida) m."
        }
    }
    
    @objc func botoesGameOver (){
        
        var botaoInicio:SKSpriteNode = SKSpriteNode()
        var botaoReplay:SKSpriteNode = SKSpriteNode()
        
        botaoInicio = SKSpriteNode(imageNamed: "botaoSair")
        botaoInicio.texture!.filteringMode = .nearest
        botaoInicio.setScale(2.5)
        botaoInicio.position = CGPoint(x: self.size.width/2, y: self.size.height/2-30)
        botaoInicio.name = "Botao Inicio"
        
        botaoReplay = SKSpriteNode(imageNamed: "botaoReplay")
        botaoReplay.texture!.filteringMode = .nearest
        botaoReplay.setScale(2.5)
        botaoReplay.position = CGPoint(x: self.size.width/2, y: self.size.height/2+50)
        botaoReplay.name = "Botao Replay"
        
        botaoInicio.position.x += 400
        botaoReplay.position.x += 400
        botaoInicio.zPosition = 12
        botaoReplay.zPosition = 12
        
        let acaoEntraBotao = SKAction.moveBy(x: -400, y: 0, duration: 0.5)
        
        botaoReplay.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), acaoEntraBotao]))
        botaoInicio.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), acaoEntraBotao]))
        
        self.addChild(botaoReplay)
        self.addChild(botaoInicio)
        
        self.run (somFimDeJogo)
        
    }
    
    func botoesPausarJogo (){

        
        botaoVoltar = SKSpriteNode (imageNamed: "botaoVoltar")
        botaoVoltar.texture!.filteringMode = .nearest
        botaoVoltar.setScale(2.5)
        botaoVoltar.position = CGPoint(x: self.size.width/2, y: self.size.height/2+40)
        botaoVoltar.name = "Botao Voltar"
        
        botaoSair = SKSpriteNode(imageNamed: "botaoSair")
        botaoSair.texture!.filteringMode = .nearest
        botaoSair.setScale(2.5)
        botaoSair.position = CGPoint(x: self.size.width/2, y: self.size.height/2-30)
        botaoSair.name = "Botao Inicio"
        
        botaoSair.position.x += 400
        botaoVoltar.position.x += 400
        botaoSair.zPosition = 12
        botaoVoltar.zPosition = 12
        
        let acaoEntraBotao = SKAction.moveBy(x: -400, y: 0, duration: 0.5)
        
        botaoVoltar.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), acaoEntraBotao]))
        botaoSair.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), acaoEntraBotao]))
        
        self.addChild(botaoVoltar)
        self.addChild(botaoSair)
        
        self.run (somClica)
        
        
    }
    
    func removeBotoesPausa (){
        let removeBotao = SKAction.moveBy(x: 500, y: 0, duration: 0.5)
        botaoVoltar.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), removeBotao]))
        botaoSair.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), removeBotao]))
    }
    
    func ficaInvencivelOn (){
        
        if !estadoInvencivel {
            estadoInvencivel = true
            _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(CenaJogo.ficaInvencivelOff), userInfo: nil, repeats: false)
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
            fant.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            apagaBotoesHud()
            
            self.backgroundColor = UIColor.white
            physicsWorld.speed = 3.5
            speed = 3.5
            criaObjetoMorcegoVirado(objeto: fant)
            timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(CenaJogo.contaDistancia), userInfo: nil, repeats: true)
            //criaParticulaInvencivel()
           // self.run (somInvencivel)
            
        }
    }
    
   @objc func ficaInvencivelOff (){
        
        if estadoInvencivel {
            estadoInvencivel = false
            fant.run(SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0.5), SKAction.wait(forDuration: 0.5), SKAction.run({ () -> Void in
            })]))
            acendeBotoesHud()
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            fant.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            fant.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
            physicsWorld.speed = 1
            speed = 1
            self.backgroundColor = UIColor.black
            morcegoMount.removeFromParent()
            timer.invalidate()
            
        }
    }
    
    
    /*func ficaInvisivelOn(){
        
        if !estadoInvisivel {
            estadoInvisivel = true
            _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(CenaJogo.ficaInvisivelOff), userInfo: nil, repeats: false)
            felpudo.run(SKAction.fadeAlpha(to: 0.25, duration: 0.5))
            apagaBotoesHud ()
            self.run (somInvisivelStart)
            
        }
    }
    
    func ficaInvisivelOff (){
        
        if estadoInvisivel {
            felpudo.run(SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0.5), SKAction.wait(forDuration: 0.5), SKAction.run({() -> Void in self.estadoInvisivel = false})]))
            acendeBotoesHud()
            
            self.run (somInvisivelEnd)
        }
    }*/
    
    func apagaBotoesHud (){
        
        hudMorcego.run(SKAction.fadeAlpha(to: 0.15, duration: 0.5))
        
        hudMorcego.run(SKAction.fadeAlpha(to: 0.15, duration: 0.5))
        
        
        hudMorcego.name = "xxx"
        morcegosLabel.name = "xxx"

    }
    
    func acendeBotoesHud (){
        
        hudMorcego.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        
        hudMorcego.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        
        hudMorcego.name = "Hud Morcego"
        hudMorcego.name = "Hud Morcego"

    }
    /*
    func criaParticulasPenas(){
        
        let pena:SKTexture = SKTexture(imageNamed: "pena")
        let emissorPenas:SKEmitterNode = SKEmitterNode()
        
        emissorPenas.particleTexture = pena
        emissorPenas.position = CGPoint(x: felpudo.position.x+20, y: felpudo.position.y+felpudo.size.height/2)
        emissorPenas.particleBirthRate = 100
        emissorPenas.numParticlesToEmit = 5;
        emissorPenas.particleLifetime = 1.3
        emissorPenas.particleTexture?.filteringMode = .nearest
        emissorPenas.xAcceleration = 0
        emissorPenas.yAcceleration = 0
        emissorPenas.particleSpeed = 100
        emissorPenas.particleSpeedRange = 200
        emissorPenas.particleRotationSpeed = -10
        emissorPenas.particleRotationRange = 4
        emissorPenas.emissionAngle = 3
        emissorPenas.emissionAngleRange = 3.14
        emissorPenas.particleColorAlphaSpeed = 0.1
        emissorPenas.particleColorAlphaRange = 1
        emissorPenas.particleAlphaSequence = SKKeyframeSequence(keyframeValues: [1,0], times: [0,1])
        emissorPenas.particleScaleSequence = SKKeyframeSequence(keyframeValues: [3, 0.5], times: [0,1])
        
        if estadoInvisivel || estadoInvencivel{
            
            emissorPenas.alpha = 0.15
        }
        self.addChild(emissorPenas)
        emissorPenas.run(SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.removeFromParent()]))
        self.run (somFelpudoVoa)
        
    }*/
    
    func criaParticulaMorcego (objeto : SKNode){
        
        let estrela:SKTexture = SKTexture(imageNamed: "estrela")
        let emissorEstrela:SKEmitterNode = SKEmitterNode()
        
        emissorEstrela.particleTexture = estrela
        emissorEstrela.particleBirthRate = 14
        emissorEstrela.numParticlesToEmit = 6000;
        emissorEstrela.particleLifetime = 0.55
        emissorEstrela.particleTexture?.filteringMode = .nearest
        emissorEstrela.xAcceleration = 0
        emissorEstrela.yAcceleration = 0
        emissorEstrela.particleSpeed = 90
        emissorEstrela.particleSpeedRange = 80
        emissorEstrela.particleRotationSpeed = 5
        emissorEstrela.particleRotationRange = 10
        emissorEstrela.emissionAngleRange = CGFloat(M_PI*2)
        emissorEstrela.particleAlphaSequence = SKKeyframeSequence(keyframeValues: [0, 1, 1, 0], times: [0, 0.15, 0.75, 1])
        emissorEstrela.particleScaleSequence = SKKeyframeSequence(keyframeValues: [0.85, 0.85, 0], times: [0, 0.75, 1])
        
        objeto.addChild(emissorEstrela)
        
        emissorEstrela.run(SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.removeFromParent()]))
        
    }
    
    func salvarRecordes () {
        
        if((UserDefaults.standard.integer(forKey: "Recorde Pontos")) < score){
            recordePontos = score
            UserDefaults.standard.set(recordePontos, forKey: "Recorde Pontos")
        }
        
        if ((UserDefaults.standard.integer(forKey: "Recorde Distancia")) < distanciaPercorrida){
            recordeDistancia = distanciaPercorrida
            UserDefaults.standard.set(recordeDistancia, forKey: "Recorde Distancia")
        }
        
        salvarJogo()
    }
    
    func salvarJogo() {
        UserDefaults.standard.set(numeroItemMorcego, forKey: "Numero Morcegos")
       // UserDefaults.standard.set(numeroItemSementes, forKey: "Numero Sementes")
        //UserDefaults.standard.set(numeroItemEstrelas, forKey: "Numero Estrelas")
        UserDefaults.standard.synchronize()
    }
    
    func carregarJogo() {
        
        recordePontos = UserDefaults.standard.integer(forKey: "Recorde Pontos")
        recordeDistancia = UserDefaults.standard.integer(forKey: "Recorde Distancia")
        numeroItemMorcego = UserDefaults.standard.integer(forKey: "Numero Morcegos")
       // numeroItemEstrelas = UserDefaults.standard.integer(forKey: "Numero Estrelas")
        //numeroItemSementes = UserDefaults.standard.integer(forKey: "Numero Sementes")
    }
    
    func retornaTxtPers (txt:String) {
        txtPers = txt
      
    }
    
}

