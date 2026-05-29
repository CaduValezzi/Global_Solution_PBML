# Braço Robótico de Coleta de Amostras — Docking & Retrieval

## Identificação

**Projeto:** Braço Robótico de Coleta de Amostras (Docking & Retrieval)  
**Integrantes:**
- [Nome Completo 1]
- [Nome Completo 2]
- [Nome Completo 3]
- [Nome Completo 4]
- [Nome Completo 5]

---

## Acesso ao Simulador

🔗 [Link público do circuito no Tinkercad](https://www.tinkercad.com/things/SEU-LINK-AQUI)

> Substitua o link acima pelo link público do seu projeto após publicar no Tinkercad.

---

## Guia de Operação

Para operar o braço, abra o **Monitor Serial** na Arduino IDE (ou no Tinkercad), configure para **9600 baud** e digite os comandos abaixo:

| Comando | Ação no braço robótico |
|---------|------------------------|
| `U` | Sobe o braço — servo do ombro vai para 150° |
| `D` | Desce o braço — servo do ombro vai para 30° |
| `O` | Abre a garra — servo da garra vai para 90° |
| `C` | Fecha a garra (captura a amostra) — servo da garra vai para 10° |
| `H` | Retorna ao HOME — ombro 90° e garra 90° |
| `?` | Exibe os ângulos atuais dos dois servos |

**Sequência de captura de amostra:**
1. `H` → posição inicial
2. `O` → abre a garra
3. `D` → desce até a amostra
4. `C` → fecha a garra (captura)
5. `U` → sobe com a amostra

---

## Software de Modelagem 3D

As peças foram modeladas no **OpenSCAD** (versão gratuita e open-source).  
Arquivo nativo: `modelos-3d/garra_espacial.scad`  
Arquivo de exportação: `modelos-3d/garra_espacial.stl`

Download: https://openscad.org/downloads.html

---

## Especificações Técnicas

**Tensão da fonte de bancada:** 5V (configurada no simulador Tinkercad)

**Pinagem do Arduino Uno:**

| Pino | Componente | Função |
|------|------------|--------|
| 9 | Servo 1 (ombro) | Controla subida e descida do braço — comandos U e D |
| 10 | Servo 2 (garra) | Controla abertura e fechamento da garra — comandos O e C |
| 13 | LED de status | Pisca a cada comando recebido, aceso indica sistema pronto |
| GND | GND da protoboard | Referência comum entre Arduino e fonte |

> Os servomotores são alimentados pela fonte de bancada (5V), **não** pelo pino 5V do Arduino, para evitar sobrecarga na placa.

---

## Estrutura do Repositório

```
braco-robotico/
├── firmware/
│   └── braco_robotico.ino
├── modelos-3d/
│   ├── garra_espacial.scad
│   └── garra_espacial.stl
├── imagens/
│   ├── circuito_simulado.png
│   └── modelo_3d_render.png
└── README.md
```
