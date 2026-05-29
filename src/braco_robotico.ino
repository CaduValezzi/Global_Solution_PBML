#include <Servo.h>

const int PINO_SERVO_OMBRO = 9;
const int PINO_SERVO_GARRA = 10;
const int PINO_LED         = 13;

const int OMBRO_HOME  = 90;
const int OMBRO_UP    = 150;
const int OMBRO_DOWN  = 30;
const int GARRA_OPEN  = 90;
const int GARRA_CLOSE = 10;

Servo servoOmbro;
Servo servoGarra;
int anguloOmbro = OMBRO_HOME;
int anguloGarra = GARRA_OPEN;

// Move o servo do OMBRO suavemente ate o angulo alvo
void moverOmbro(int alvo) {
  int passo = (alvo > anguloOmbro) ? 1 : -1;
  while (anguloOmbro != alvo) {
    anguloOmbro += passo;
    servoOmbro.write(anguloOmbro);
    delay(15);
  }
}

// Move o servo da GARRA suavemente ate o angulo alvo
void moverGarra(int alvo) {
  int passo = (alvo > anguloGarra) ? 1 : -1;
  while (anguloGarra != alvo) {
    anguloGarra += passo;
    servoGarra.write(anguloGarra);
    delay(15);
  }
}

void piscaLED(int vezes) {
  for (int i = 0; i < vezes; i++) {
    digitalWrite(PINO_LED, LOW);
    delay(150);
    digitalWrite(PINO_LED, HIGH);
    delay(150);
  }
}

void setup() {
  Serial.begin(9600);
  pinMode(PINO_LED, OUTPUT);

  servoOmbro.attach(PINO_SERVO_OMBRO);
  servoGarra.attach(PINO_SERVO_GARRA);
  servoOmbro.write(OMBRO_HOME);
  servoGarra.write(GARRA_OPEN);

  piscaLED(3);
  digitalWrite(PINO_LED, HIGH);

  Serial.println("=================================");
  Serial.println(" BRACO ROBOTICO - Pronto!");
  Serial.println(" U=Sobe  D=Desce  O=Abre  C=Fecha");
  Serial.println(" H=Home  ?=Status");
  Serial.println("=================================");
}

void loop() {
  if (Serial.available() > 0) {
    char cmd = Serial.read();
    cmd = toupper(cmd);

    if (cmd == '\n' || cmd == '\r' || cmd == ' ') return;

    switch (cmd) {

      case 'U':
        Serial.println("[U] Subindo braco...");
        piscaLED(1);
        moverOmbro(OMBRO_UP);
        Serial.print("[OK] Ombro: ");
        Serial.print(anguloOmbro);
        Serial.println(" graus");
        break;

      case 'D':
        Serial.println("[D] Descendo braco...");
        piscaLED(1);
        moverOmbro(OMBRO_DOWN);
        Serial.print("[OK] Ombro: ");
        Serial.print(anguloOmbro);
        Serial.println(" graus");
        break;

      case 'O':
        Serial.println("[O] Abrindo garra...");
        piscaLED(1);
        moverGarra(GARRA_OPEN);
        Serial.print("[OK] Garra: ");
        Serial.print(anguloGarra);
        Serial.println(" graus");
        break;

      case 'C':
        Serial.println("[C] Fechando garra...");
        piscaLED(2);
        moverGarra(GARRA_CLOSE);
        Serial.print("[OK] Garra: ");
        Serial.print(anguloGarra);
        Serial.println(" graus - Amostra capturada!");
        break;

      case 'H':
        Serial.println("[H] Indo para HOME...");
        piscaLED(3);
        moverOmbro(OMBRO_HOME);
        moverGarra(GARRA_OPEN);
        Serial.println("[OK] HOME - ombro 90, garra 90");
        break;

      case '?':
        Serial.println("-------- STATUS --------");
        Serial.print("Ombro: ");
        Serial.print(anguloOmbro);
        Serial.println(" graus");
        Serial.print("Garra: ");
        Serial.print(anguloGarra);
        Serial.println(" graus");
        Serial.println("------------------------");
        break;

      default:
        Serial.print("[ERRO] Comando invalido: ");
        Serial.println(cmd);
        break;
    }

    digitalWrite(PINO_LED, HIGH);
    Serial.println();
  }
}
