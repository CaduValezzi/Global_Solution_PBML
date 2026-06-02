# Braço Robótico de Coleta de Amostras — Docking & Retrieval

## Identificação

**Projeto:** Braço Robótico de Coleta de Amostras (Docking & Retrieval)


**Integrantes:**

- RM551059 | Cassio Valezzi
- RM98215 | Gabriel Antony Cadima Ciziks
- ⁠RM98169 | Lucca Sabatini Tambellini
- RM98209 | Victor Nuzzi

---

## Acesso ao Simulador

🔗 [Link público do circuito no Tinkercad](https://www.tinkercad.com/things/03MCpQksuJ4-smashing-bruticus)

---

## Guia de Operação

Para operar o braço, abra o **Monitor Serial** na Arduino IDE (ou no Tinkercad), configure para **9600 baud** e digite os comandos abaixo:

| Comando | Ação no braço robótico                                        |
| ------- | ----------------------------------------------------------------- |
| `U`   | Sobe o braço — servo do ombro vai para 150°                    |
| `D`   | Desce o braço — servo do ombro vai para 30°                    |
| `O`   | Abre a garra — servo da garra vai para 90°                      |
| `C`   | Fecha a garra (captura a amostra) — servo da garra vai para 10° |
| `H`   | Retorna ao HOME — ombro 90° e garra 90°                        |
| `?`   | Exibe os ângulos atuais dos dois servos                          |

**Sequência de captura de amostra:**

1. `H` → posição inicial
2. `O` → abre a garra
3. `D` → desce até a amostra
4. `C` → fecha a garra (captura)
5. `U` → sobe com a amostra

---

## Software de Modelagem 3D

As peças foram modeladas no **OpenSCAD** (versão gratuita e open-source).

Download: https://openscad.org/downloads.html

---
## Estrutura do Repositório

```
braco-robotico/
├── src/
│   └── braco_robotico.ino
├── model/
│   ├── garra_espacial.scad
├── images/
│   ├── circuito_simulado.png
│   └── modelo_3d_render.png
└── README.md
```
---

## Especificações Técnicas

**Tensão da fonte de bancada:** 5V 

**Pinagem do Arduino Uno:**

| Pino | Componente        | Função                                                   |
| ---- | ----------------- | ---------------------------------------------------------- |
| 9    | Servo 1 (ombro)   | Controla subida e descida do braço — comandos U e D      |
| 10   | Servo 2 (garra)   | Controla abertura e fechamento da garra — comandos O e C  |
| 13   | LED de status     | Pisca a cada comando recebido, aceso indica sistema pronto |
| GND  | GND da protoboard | Referência comum entre Arduino e fonte                    |


---
## Montagem Física da Garra
 
### Peças para imprimir
 
São 3 peças separadas. Para exportar cada uma no OpenSCAD, comente as outras duas com `//` na seção CENA PRINCIPAL, pressione **F6** e vá em **File → Export → Export as STL**.
 
| Peça | Tempo estimado | Material |
|------|----------------|----------|
| `base_montagem()` | ~1h | PLA |
| `conjunto_garra()` | ~45min | PLA |
| `elo_braco()` | ~30min | PLA |
 
### Materiais necessários
 
- 2x parafuso M3 x 10mm + porca M3 (pinos de articulação dos dedos)
- 4x parafuso M3 x 8mm (fixação da base)
- 1x servo SG90
### Passo a passo
 
**1. Encaixar o servo na base**
O servo SG90 entra no alojamento retangular da `base_montagem` pelo topo. Deve encaixar firme com a folga de 0.5mm. Se apertar, lixe levemente as paredes do alojamento.
 
**2. Prender o hub no eixo do servo**
O `conjunto_garra` tem um hub com furo em formato D que encaixa diretamente no eixo do servo SG90. Empurra firme — o formato D trava a rotação sem precisar de parafuso.
 
**3. Articular os dedos**
Cada dedo tem um furo de 3.2mm na base. Passa um parafuso M3 por esse furo e aperta com a porca do outro lado. Não aperte demais — o dedo precisa girar levemente para abrir e fechar.
 
**4. Fixar o elo**
O `elo_braco` conecta a base ao segundo servo (ombro). Os furos nas extremidades encaixam com parafuso M3.
 
### Lógica de funcionamento
 
```
Servo do ombro (pino 9)
    └── gira o elo_braco → sobe e desce o braço inteiro
 
Servo da garra (pino 10)
    └── gira o conjunto_garra → abre e fecha os 3 dedos
```
 
---