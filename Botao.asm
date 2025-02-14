.ORG 0x0000
RJMP main

.ORG 0x001
RJMP EXT_INT0


main:
LDI r16,0b00000100
OUT DDRD,r16 ;CONFIGURA PD0 COMO SA�DA (LED) E PD1 COMO ENTRADA (BOT�O)
LDI r16,0b11111111
OUT PortD,r16 ;INICIALIZA O LED COMO INICIALMENTE DESLIGADO
NOP

loop:
SBIS PinD,PD7 ;SE O PD1 RECEBER CORRENTE (BOT�O PRESSIONADO), PULA A PR�XIMA INSTRU��O
RJMP loop

soltar:
SBIC PinD,PD7 ;SE O PD1 N�O RECEBER CORRENTE (BOT�O SOLTO), PULA A PR�XIMA INSTRU��O
RJMP soltar ;SE N�O, VOLTA AO SOLTAR
RCALL atraso
SBIC PortD,PD2 ;SE O PD0 N�O RECEBER CORRENTE (LED APAGADO), PULA A PR�XIMA INSTRU��O
RJMP liga ;SE N�O, CHAMA ROTINA PARA DESLIGAR O LED
SBI PortD,PD2 ;LIGA LED
RJMP loop

liga:
CBI PortD,PD2 ;DESLIGA LED
RJMP loop

atraso:
DEC r3
BRNE atraso
DEC r2
BRNE atraso
RET