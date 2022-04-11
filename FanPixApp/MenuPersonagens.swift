//
//  MenuPersonagens.swift
//  FanPixApp
//
//  Created by Matheus Maxwell Meireles on 12/08/17.
//  Copyright © 2017 maxnewsoftware. All rights reserved.
//

//
//  MenuInicio.swift
//  FanPixApp
//
//  Created by Matheus Maxwell Meireles on 02/06/17.
//  Copyright © 2017 maxnewsoftware. All rights reserved.
//

import SpriteKit

class MenuPersonagens: SKScene {
    
    var txt = ""
    var somClica = SKAction.playSoundFileNamed("somClick.mp3", waitForCompletion: false)
    
    override func didMove(to view: SKView) { //comeco do app
        self.backgroundColor = UIColor.lightGray // cor da entrada do app = cinza claro
        
        
        let imagemFundo = SKSpriteNode(imageNamed: "fundo_1") //instancia o objeto imagem
        let botaoFant = SKSpriteNode(imageNamed: "fantasminhaParado")
        // let botaoRanking = SKSpriteNode(imageNamed: "botaoRanking")
        // let botaoLoja = SKSpriteNode(imageNamed: "botaoLoja")
        // let botaoSobre = SKSpriteNode(imageNamed: "botaoSobre")
        
        
        imagemFundo.size.width = self.size.width+5 //largura da imagem = largura da scene
        imagemFundo.size.height = self.size.height+10 //altura da imagem = altura da scene
        imagemFundo.texture?.filteringMode = .nearest //tira o borrao da imagem
        
        botaoFant.texture?.filteringMode = .nearest
        // botaoRanking.texture?.filteringMode = .nearest
        //botaoLoja.texture?.filteringMode = .nearest
        //botaoSobre.texture?.filteringMode = .nearest
        
        imagemFundo.position = CGPoint(x:self.size.width/2, y:self.size.height/2) //posicao da imagem
        
        botaoFant.position.y = 0
        // botaoRanking.position.y = -70
        //botaoLoja.position.y = -120
        //botaoSobre.position.y = -170
        
        botaoFant.position.x = 400
        //botaoRanking.position.x = 400
        //botaoLoja.position.x = 400
        //botaoSobre.position.x = 400
        
        botaoFant.setScale(0.6)
        //botaoRanking.setScale(2)
        //botaoLoja.setScale(2)
        //botaoSobre.setScale(2)
        
        botaoFant.zPosition = 1 //coloca a imagem a frente da imagem de fundo
        //botaoRanking.zPosition = 1
        //botaoLoja.zPosition = 1
        //botaoSobre.zPosition = 1
        
        botaoFant.alpha = 0.2
        //botaoRanking.alpha = 0.2
        //botaoLoja.alpha = 0.2
        //botaoSobre.alpha = 0.2
        
        let animacaoEntra = SKAction.moveTo(x: 0, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(by: 1, duration: 0.25)
        
        botaoFant.run(animacaoEntra) //entra com o botao
        botaoFant.run(animacaoAlpha) //faz o botao aparecer
        botaoFant.run(SKAction.sequence([animacaoEntra, animacaoAlpha]))
        //botaoRanking.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), animacaoEntra, animacaoAlpha]))
        //botaoLoja.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), animacaoEntra, animacaoAlpha]))
        // botaoSobre.run(SKAction.sequence([SKAction.wait(forDuration: 1.5), animacaoEntra, animacaoAlpha]))
        
        botaoFant.name = "Botao Fant"
        //botaoRanking.name = "Botao Ranking"
        //botaoLoja.name = "Botao Loja"
        //botaoSobre.name = "Botao Sobre"
        
        self.addChild(imagemFundo) //adiciona imagem ao fundo da scene
        imagemFundo.addChild(botaoFant) // adiciona imagem do botao direto na imagem do fundo, para n ter que alterar na altura e largura de                             sua posicao
        // imagemFundo.addChild(botaoRanking)
        // imagemFundo.addChild(botaoLoja)
        // imagemFundo.addChild(botaoSobre)
        
        
        let labelTxt = SKLabelNode(fontNamed: "True Crimes")
        
        labelTxt.fontSize = 22
        labelTxt.text = "Selecione o personagem."
        labelTxt.position = CGPoint(x: self.size.width/2, y: self.size.height - 40)
        labelTxt.zPosition = 2
        
        self.addChild(labelTxt)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let posicaoTocada: CGPoint! = touch.location(in: self)
            let objetoTocado : SKNode = self.atPoint(posicaoTocada)
            
            if (objetoTocado.name == "Botao Fant"){
                let transicao = SKTransition.crossFade(withDuration: 1)
                let cena = CenaJogo(size: self.size)
                self.view?.presentScene(cena, transition:transicao)
                
                self.run (somClica)
            }
            /*if (objetoTocado.name == "Botao Ranking"){
             print("tocou ranking")
             self.run (somClica)
             }
             if (objetoTocado.name == "Botao Loja"){
             let transicao = SKTransition.reveal(with: .right, duration: 0.5)
             let cena = CenaLoja(size: self.size)
             self.view?.presentScene(cena, transition:transicao)
             self.run (somClica)
             
             }
             if (objetoTocado.name == "Botao Sobre"){
             print("tocou sobre")
             self.run (somClica)
             
             }*/
        }
        
    }
    
    public func retornaTxt (txt:String) ->String{
        return txt
    }
    
    
}

