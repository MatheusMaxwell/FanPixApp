//
//  MenuInicio.swift
//  FanPixApp
//
//  Created by Matheus Maxwell Meireles on 02/06/17.
//  Copyright © 2017 maxnewsoftware. All rights reserved.
//

import SpriteKit

class MenuInicio: SKScene {
    
   // var recordePontos:Int = UserDefaults.standard.integer(forKey: "Recorde Pontos")
    var recordeDistancia:Int = UserDefaults.standard.integer(forKey: "Recorde Distancia")
    
    var somClica = SKAction.playSoundFileNamed("somClick.mp3", waitForCompletion: false)
    
    override func didMove(to view: SKView) { //comeco do app
        self.backgroundColor = UIColor.lightGray // cor da entrada do app = cinza claro
        
        
        let imagemFundo = SKSpriteNode(imageNamed: "fundoInicio.png") //instancia o objeto imagem
        let botaoIniciar = SKSpriteNode(imageNamed: "botaoIniciar")
        let botaoPersonagens = SKSpriteNode(imageNamed: "botaoPersonagens")
       // let botaoLoja = SKSpriteNode(imageNamed: "botaoLoja")
       // let botaoSobre = SKSpriteNode(imageNamed: "botaoSobre")
        
        
        imagemFundo.size.width = self.size.width+5 //largura da imagem = largura da scene
        imagemFundo.size.height = self.size.height+10 //altura da imagem = altura da scene
        imagemFundo.texture?.filteringMode = .nearest //tira o borrao da imagem
        
        botaoIniciar.texture?.filteringMode = .nearest
        botaoPersonagens.texture?.filteringMode = .nearest
        //botaoLoja.texture?.filteringMode = .nearest
        //botaoSobre.texture?.filteringMode = .nearest
        
        imagemFundo.position = CGPoint(x:self.size.width/2, y:self.size.height/2) //posicao da imagem
        
        botaoIniciar.position.y = 0
        botaoPersonagens.position.y = -40
        //botaoLoja.position.y = -120
        //botaoSobre.position.y = -170
        
        botaoIniciar.position.x = 400
        botaoPersonagens.position.x = 400
        //botaoLoja.position.x = 400
        //botaoSobre.position.x = 400
        
        botaoIniciar.setScale(2)
        botaoPersonagens.setScale(2)
        //botaoLoja.setScale(2)
        //botaoSobre.setScale(2)
        
        botaoIniciar.zPosition = 1 //coloca a imagem a frente da imagem de fundo
        botaoPersonagens.zPosition = 1
        //botaoLoja.zPosition = 1
        //botaoSobre.zPosition = 1
        
        botaoIniciar.alpha = 0.2
        botaoPersonagens.alpha = 0.2
        //botaoLoja.alpha = 0.2
        //botaoSobre.alpha = 0.2
        
        let animacaoEntra = SKAction.moveTo(x: 0, duration: 0.75)
        let animacaoAlpha = SKAction.fadeAlpha(by: 1, duration: 0.25)
        
        botaoIniciar.run(animacaoEntra) //entra com o botao
        botaoIniciar.run(animacaoAlpha) //faz o botao aparecer
        botaoIniciar.run(SKAction.sequence([animacaoEntra, animacaoAlpha]))
        botaoPersonagens.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), animacaoEntra, animacaoAlpha]))
        //botaoLoja.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), animacaoEntra, animacaoAlpha]))
       // botaoSobre.run(SKAction.sequence([SKAction.wait(forDuration: 1.5), animacaoEntra, animacaoAlpha]))
        
        botaoIniciar.name = "Botao Iniciar"
        botaoPersonagens.name = "Botao Personagens"
        //botaoLoja.name = "Botao Loja"
        //botaoSobre.name = "Botao Sobre"
        
        self.addChild(imagemFundo) //adiciona imagem ao fundo da scene
        imagemFundo.addChild(botaoIniciar) // adiciona imagem do botao direto na imagem do fundo, para n ter que alterar na altura e largura de                             sua posicao
        imagemFundo.addChild(botaoPersonagens)
       // imagemFundo.addChild(botaoLoja)
       // imagemFundo.addChild(botaoSobre)
        
        
        let labelRecordes = SKLabelNode(fontNamed: "True Crimes")
        
        labelRecordes.fontSize = 17
        labelRecordes.text = "Recorde: \(recordeDistancia) metros"
        labelRecordes.position = CGPoint(x: self.size.width/2, y: self.size.height - 20)
        labelRecordes.zPosition = 2
        
        self.addChild(labelRecordes)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let posicaoTocada: CGPoint! = touch.location(in: self)
            let objetoTocado : SKNode = self.atPoint(posicaoTocada)
            
            if (objetoTocado.name == "Botao Iniciar"){
                let transicao = SKTransition.crossFade(withDuration: 1)
                let cena = CenaJogo(size: self.size)
                self.view?.presentScene(cena, transition:transicao)
                self.run (somClica)
            }
            if (objetoTocado.name == "Botao Personagens"){
                let transicao = SKTransition.crossFade(withDuration: 1)
                let cena = MenuPersonagens(size: self.size)
                self.view?.presentScene(cena, transition:transicao)
                self.run (somClica)
            }
            /*
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

}
