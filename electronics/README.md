## encoder signals gaps at irregular intervals
encoder phasing how to detect
veirfy chassis ground and signal ground
https://magellancircuits.com/what-is-difference-between-signal-ground-chassis-ground-and-earth-ground/

voltage drop from power supply to servo driver

#  servoeixo
### “Servo axis is hunting around its setpoint. Chassis ground and signal ground.”
 “O eixo do servo está oscilando/caçando ao redor do seu ponto de ajuste. Terra de chassis e terra de sinal.”

🔧 Como isolar a falha – passo a passo técnico
A oscilação (“hunting”) ao redor do setpoint normalmente indica ruído elétrico, problemas de referência de terra, ganhos mal ajustados ou instabilidade no loop de controle.
Como você mencionou terra de chassi e terra de sinal, a prioridade é verificar se há diferença de potencial ou acoplamento de ruído entre esses dois referenciais.
1. integridade de aterramento (principal suspeito)
*  Meça a diferença entre Signal GND e Chassis GND

*  Use um multímetro no modo AC e depois DC. 
Diferencial > 20–50 mV já pode causar ruído em drives sensíveis. Isso indica corrente parasita ou acoplamento de ruído correndo entre os dois terras. Isso é exatamente o tipo de perturbação que faz um servo “caçar” em torno do setpoint.
Se a medição é praticamente zero, o problema provavelmente não está no aterramento, permitindo seguir para outras hipóteses (ganho P alto, encoder ruidoso, setpoint instável etc.).


2. Desacople terras para teste
(Objetivo: descobrir se o ruído vem do chassis)
Teste A — Isolar temporariamente o GND de sinal do GND de chassis

Verifique se o drive permite separação física de ambos.
Se ao separar o ruído reduz → interferência está entrando pelo terra do chassis.

Teste B — Reconectar com único ponto de referência

Aterramento tipo “estrela” em um ponto só.
https://magellancircuits.com/what-is-difference-between-signal-ground-chassis-ground-and-earth-ground/

3.Inspecione cabos, blindagens e roteamento


4. Verifique potenciais fontes de ruído
Faça testes desligando temporariamente:

inversores próximos,
fontes chaveadas,
motores de alta corrente no mesmo painel.

Se o hunting parar → ruído eletromagnético externo.
5. Avalie parâmetros de controle

 6. Teste final: comando em malha aberta

Desconecte temporariamente o sinal de referência (setpoint).
Coloque o drive em modo jog ou torque only (se permitido).

Se o motor ficar estável:

a origem da oscilação está no sinal de comando ou no aterramento.

Se continuar instável:

problema interno no drive, encoder ou parâmetros.

A importância da qualidade das fontes e tensões de referência para estabilidade de sistemas. 
A necessidade de uma única referência coerente de GND e tratamento correto de sinais sensíveis para evitar instabilidade em circuitos e sistemas digitais/analógicos.
A ênfase em checar alimentação, conexões e caminhos de retorno antes do diagnóstico de falhas, pois pequenas diferenças podem causar comportamento anormal do circuito

verify incorrect shielding


https://resources.pcb.cadence.com/blog/2024-electrical-schematic-design-checklist
https://www.tek.com/en/documents/application-note/getting-started-power-rail-measurements-application-note
https://embeddedprep.com/power-on-checks-and-voltage-rails/
https://electronicmanufacturingservice.org/schematic-review-checklist/
https://www.circuitbasics.com/how-to-troubleshoot-and-repair/
https://www.schemalyzer.com/en/blog/schematic-review/checklists/schematic-review-checklist


## circuito de alta impedância de entrada
1. Não carrega o sensor (baixa interação com a fonte do sinal)

A principal vantagem: minimiza a corrente que o condicionador “puxa” da fonte, preservando a forma real do sinal.
Ideal para sensores sensíveis
. Reduz erros por divisão resistiva

.Permite cabos longos ou fontes de sinal fracas
.Fontes com alta impedância interna (p.ex. sensores químicos, foto-detectores) só funcionam corretamente quando “olham” para um circuito de entrada bem leve (high-Z).
. Melhora precisão em sinais de muito baixa corrente
.Em medições onde a corrente disponível é microampere ou nanoampere, alta impedância é essencial para não distorcer o sinal.

Maior suscetibilidade a offsets e correntes de fuga. Como a entrada trabalha com correntes minúsculas, efeitos como: correntes de polarização, correntes de fuga em PCB;
Necessidade de proteção especial. Entradas de alta impedância são vulneráveis a: ESD (descarga eletrostática);
Usado quando o sinal tem baixa corrente disponível ou precisa ser mantido sem distorções

### estabilizadores

| Categoria               | Exemplos                        | Uso típico                                                                                   |
|-------------------------|----------------------------------|-----------------------------------------------------------------------------------------------|
| Optoacopladores digitais | fototransistor, photo‑TRIAC      | Acionamento de alta tensão, isolamento entre MCU e carga [1](https://magellancircuits.com/what-is-best-placement-for-decoupling-capacitors-near-an-ics-power-pins/) |
| Optoacopladores lineares | HCNR201 / HCNR200                | Amplificação isolada de sinais analógicos de alta tensão [2](https://iwdfsolutions.com/decoupling-capacitor-placement-in-pcb-design/) |
| Isoladores digitais      | ADuM, ISO7741                    | Comunicação MCU ↔ potência com sincronismo e alta velocidade [3](https://www.protoexpress.com/blog/decoupling-capacitor-placement-guidelines-pcb-design/) |
| Gate drivers isolados    | drivers isolados para IGBT/MOSFET | Comutação de semicondutores de alta tensão com segurança [3](https://www.protoexpress.com/blog/decoupling-capacitor-placement-guidelines-pcb-design/) |
| Amplificadores isolados  | isolation amplifiers             | Medição de tensão e corrente em sistemas HV, instrumentação [4](https://www.allpcb.com/blog/pcb-knowledge/the-ultimate-guide-to-power-plane-decoupling-capacitors-placement-and-strategies.html) |

## circuito híbrido 
O circuito híbrido consegue manter a forma de onda senoidal mesmo sob cargas indutivas, capacitivas e não lineares?
Em testes com carga eletrônica dinâmica, a fonte apresenta estabilidade ou há instabilidade/oscilações no loop de realimentação?
O estágio linear está garantindo o controle preciso da amplitude, enquanto o estágio de potência está garantindo a energia necessária sem distorção?
Há correção ativa de distorção (THD compensada pelo estágio linear)?
O sistema mantém sincronismo de fase estável ao alimentar mais de um medidor simultaneamente?

O dissipador e o sistema de ventilação conseguem manter a temperatura dos transistores de potência dentro dos limites durante operação contínua em 300 V?
Há diferença significativa de aquecimento entre operação linear e operação em modo híbrido (PWM/Classe K/Classe D)?
Os sensores térmicos estão posicionados próximos aos pontos críticos (MOSFETs, IGBTs, reguladores e indutores)?
Há desligamento automático ou derating quando a temperatura de junção ultrapassa o limite seguro?
A eficiência do estágio híbrido melhora significativamente em tensões elevadas comparada ao modo 100% linear?

A fonte está atendendo às normas de segurança para equipamentos de alta tensão usados em calibração de medidores (ex.: IEC, NBR metrológica)?
O isolamento galvânico entre controle baixo‑nível (microcontrolador, DSP) e o estágio de potência está atendendo aos requisitos de kV e distâncias de isolamento (clearance/creepage)?
A fonte possui detecção de fuga, sobrecorrente e sobretensão, com desligamento rápido?
Há varistores/TVS, fusíveis dedicados e relés de isolamento adequadamente dimensionados?
O aterramento de segurança (PE) e o retorno de referência AC estão devidamente segregados?

 # Sobre diagnósticos e falhas

Há sinais de clipping nos picos ao operar próximo dos 300 V?
O estágio híbrido apresenta ruído de comutação perceptível na forma de onda (ex.: resíduos de PWM)?
Em cargas capacitivas, o loop de realimentação apresenta overshoot ou undershoot?
Há flutuações de tensão quando o ventilador de resfriamento muda de velocidade (interferência interna)?
A fonte registra eventos de falha (OC, OV, OT) e mantém logs para análise?

# books

1. The Art of Electronics – Paul Horowitz & Winfield Hill

Considerado a “bíblia” da eletrônica.
Explica profundamente fontes de alimentação, polaridade, valores de componentes, modos de falha e boas práticas de leitura e criação de esquemáticos.
Excelente para entender por que você verifica power rails, valores e conexões antes de diagnosticar.


2. Troubleshooting Analog Circuits – Robert A. Pease

Um dos maiores especialistas da história em diagnóstico de falhas analógicas.
Enfatiza inspeção, análise sistemática e erros comuns em esquemáticos que confundem diagnósticos.
Muito útil para criar um raciocínio estruturado de análise.


3. Electronic Troubleshooting and Repair Handbook – Homer L. Davidson

Focado no diagnóstico de falhas em circuitos eletrônicos reais.
Ensina como interpretar esquemáticos, localizar pontos de teste e seguir sinais pelo circuito.
Muito usado por técnicos e engenheiros de campo.


4. Practical Electronics for Inventors – Paul Scherz & Simon Monk

Um dos melhores livros modernos para entender componentes, pinagens, simbologia e práticas corretas de projeto.
Ajuda a interpretar esquemáticos e reconhecer incoerências antes de assumir que há falha no circuito.


5. Practical Troubleshooting of Electronic Circuits for Engineers and Technicians – IDC Technologies

Livro estruturado para ensinar troubleshooting passo a passo.
Cobre: análise de falhas, modos de falha de componentes, leitura de esquemas e ferramentas de diagnóstico.
Este aparece nas buscas, embora apenas o sumário esteja disponível. [books.idc-online.com]


6. Electronic Device and Circuit Theory – Robert Boylestad & Louis Nashelsky

Livro clássico usado em universidades.
Ensina a compreender profundamente o funcionamento dos blocos do esquemático, essencial antes de diagnosticar defeitos.


7. Power Supply Cookbook – Marty Brown

Excelente para quem quer entender profundamente fontes de alimentação.
Ensina como validar power rails e checar possíveis falhas relacionadas à alimentação — um dos três itens principais antes do diagnóstico.
