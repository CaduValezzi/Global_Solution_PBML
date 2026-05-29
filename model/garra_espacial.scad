// ================================================================
// BRAÇO ROBÓTICO — GARRA ESPACIAL (Docking & Retrieval Grip)
// ================================================================
// Software : OpenSCAD
// Descrição: Garra robótica parametrizada para coleta de amostras
//            em ambiente de microgravidade (Indústria Espacial).
// ================================================================

// ── PARÂMETROS GLOBAIS ─────────────────────────────────────────

base_largura   = 40;
base_altura    = 8;
base_prof      = 35;

servo_comp     = 23;
servo_larg     = 12.5;
servo_alt      = 22;
servo_folga    = 0.5;

dedo_comp      = 38;
dedo_larg      = 8;
dedo_alt       = 6;
dedo_curva_r   = 5;
num_dedos      = 3;
abertura_max   = 30;

pino_diametro  = 3.2;
chanfro        = 1.5;

nervura_n      = 4;
nervura_alt    = 3;
nervura_larg   = 1.5;

// ── MÓDULOS ───────────────────────────────────────────────────

module base_montagem() {
    difference() {
        minkowski() {
            cube([base_largura - 2*chanfro,
                  base_altura  - 2*chanfro,
                  base_prof    - 2*chanfro]);
            sphere(r = chanfro, $fn = 16);
        }

        translate([(base_largura - servo_larg - servo_folga*2) / 2,
                    base_altura - servo_alt / 2,
                   (base_prof   - servo_comp - servo_folga*2) / 2])
            cube([servo_larg + servo_folga * 2,
                  servo_alt,
                  servo_comp + servo_folga * 2]);

        for (x = [5, base_largura - 5])
            for (z = [5, base_prof - 5])
                translate([x, -1, z])
                    rotate([-90, 0, 0])
                        cylinder(d = pino_diametro, h = base_altura + 2, $fn = 16);

        translate([base_largura/2 - 3, base_altura/2, base_prof - 6])
            cube([6, base_altura, 8]);
    }

    for (i = [0 : nervura_n - 1]) {
        translate([0,
                   base_altura,
                   (base_prof / (nervura_n + 1)) * (i + 1) - nervura_larg / 2])
            cube([base_largura, nervura_alt, nervura_larg]);
    }
}

module dedo_garra() {
    difference() {
        union() {
            cube([dedo_larg, dedo_alt, dedo_comp - dedo_curva_r]);

            translate([dedo_larg / 2, dedo_alt / 2, dedo_comp - dedo_curva_r])
                hull() {
                    sphere(r = dedo_alt / 2, $fn = 20);
                    translate([0, 0, dedo_curva_r * 0.6])
                        scale([1, 0.6, 1])
                            sphere(r = dedo_alt / 2.5, $fn = 20);
                }

            translate([0, 0, 0])
                linear_extrude(height = 3)
                    polygon(points = [
                        [0,      0],
                        [dedo_larg, 0],
                        [dedo_larg, dedo_alt],
                        [0,      dedo_alt],
                        [0,      dedo_alt + 4],
                        [dedo_larg, dedo_alt + 4]
                    ]);
        }

        translate([dedo_larg / 2, -1, 4])
            rotate([-90, 0, 0])
                cylinder(d = pino_diametro, h = dedo_alt + 2, $fn = 16);

        translate([dedo_larg * 0.2, -0.1, 10])
            cube([dedo_larg * 0.6, dedo_alt + 0.2, dedo_comp - 18]);
    }
}

module conjunto_garra() {
    angulo_passo = 360 / num_dedos;

    for (i = [0 : num_dedos - 1]) {
        rotate([0, 0, angulo_passo * i])
            translate([abertura_max / 2, -dedo_larg / 2, 0])
                dedo_garra();
    }

    difference() {
        cylinder(d = 14, h = 8, $fn = 32);
        translate([0, 0, -1])
            cylinder(d = 4.5, h = 10, $fn = 32);
        translate([2, -5, -1])
            cube([6, 10, 10]);
    }
}

module elo_braco(comprimento = 60) {
    difference() {
        hull() {
            cylinder(d = 16, h = 6, $fn = 32);
            translate([comprimento, 0, 0])
                cylinder(d = 16, h = 6, $fn = 32);
        }
        translate([0, 0, -1])
            cylinder(d = pino_diametro, h = 8, $fn = 16);
        translate([comprimento, 0, -1])
            cylinder(d = pino_diametro, h = 8, $fn = 16);
        translate([comprimento/2 - comprimento*0.3, -4, 1])
            cube([comprimento * 0.6, 8, 5]);
    }
}

// ── CENA PRINCIPAL — peças separadas lado a lado ──────────────

// Peça 1: Base de montagem (posição original)
translate([0, 0, 0])
    base_montagem();

// Peça 2: Conjunto da garra — afastado 60mm para o lado
translate([60, 0, 0])
    conjunto_garra();

// Peça 3: Elo do braço — afastado 110mm para o lado
translate([110, 0, 0])
    elo_braco(comprimento = 70);

