//
//    Copyright 2016 Gabriel P. Silva and José Antonio S. Borges
//
//    This file is part of simulator SimuS.
//
//    SimuS  is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    SimuS is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with SimuS.  If not, see <http://www.gnu.org/licenses/>.
//
//    Este arquivo é parte do programa simulador SimuS.
//
//    SimuS é um software livre; você pode redistribuí-lo e/ou
//    modificá-lo dentro dos termos da Licença Pública Geral GNU como
//    publicada pela Fundação do Software Livre (FSF); na versão 3 da
//    Licença, ou (na sua opinião) qualquer versão.
//
//    Este programa é distribuído na esperança de que possa ser útil,
//    mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO
//    a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
//    Licença Pública Geral GNU para maiores detalhes.
//
//    Você deve ter recebido uma cópia da Licença Pública Geral GNU junto
//    com este programa, se não, veja em <http://www.gnu.org/licenses/>.
//

unit utrap;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
uses
{$IFnDEF FPC}
  windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  forms, uvars, uConsole, uSound, sysutils, Unix, BaseUnix, h2wiringpi;

procedure execTrap (var ACC: int8; operandReg: int16);

implementation
uses uSimula;

procedure execTrap (var ACC: int8; operandReg: int16);
(* var c: byte;*)
var s: string;
    i, ncarac, tempo: integer;
    pino, valor, modo: integer;
    freq, durMS: integer;
begin
    application.processMessages;




    case ACC of
        1: begin {leitura de um caractere da console}
               ACC := ord(formConsole.memoChar);
           end;

        2: begin  {escreve caractere apontado por operandReg na console}
                  {ACC retorna a letra escrita}
               formConsole.memoWrite(chr(memoria[operandReg]));
               ACC := memoria[operandReg];
           end;

        3: begin  {leitura de linha terminada por CR da console}
                  {estrutura do buffer:  ncarac (8 bits), buffer[256]}
                  {retorna em ACC o número de letras lidas, o CR não vem}
               ncarac := pegaMemoria(operandReg, 8);
               s := formConsole.memoRead (ncarac);
               for i := 1 to length(s) do
                    memoria[(operandReg+i) and $ffff] := ord(s[i]);
               ACC := length(s);
           end;

        4: begin   {escreve linha na console, buffer termina por null}
               s := '';
               i := 0;
               while memoria[operandReg+i] <> $0 do
                   begin
                       formConsole.memoWrite(chr(pegaMemoria(operandReg+i, 8)));
                       i := i + 1;
                   end;
               ACC := i;

               // nota: ACC volta com o número de letras escritas, ou zero, se problemas
               // caracteres especiais: CR, LF, FF
           end;

        5: begin
               // temporização.  tempo em milésimos de segundos
               tempo := pegaMemoria(operandReg, 16);
               sleep (tempo);
           end;

        6: begin
               // gerar tom:  frequência, duração em ms  --> bloqueante
               freq  := pegaMemoria(operandReg, 16);
               durMS := pegaMemoria(operandReg+2, 16);
               soundPlay (freq, durMS);
           end;

        7: begin
               // retorna número pseudo aleatório entre 0-99
               ACC := random (100);
           end;

        8: begin
               // semente aleatoria
               randSeed := pegaMemoria(operandReg, 8);
           end;

        100: begin   //inicializa wiringPi Lib
                 wiringPiSetup();
        end;

        101: begin
               pino := pegaMemoria(operandReg, 8);
               modo := PegaMemoria(operandReg+1, 8);
               pinMode(pino,modo);
               {
               INPUT = 0
               OUTPUT = 1
               PWM = 2
                              }

             end;
        102: begin
                  pino := pegaMemoria(operandReg, 8);
                  valor := pegaMemoria(operandReg+1, 8) and 1;
                  digitalWrite(pino,valor)
        	   end;

(*
        101: begin
               pino := pegaMemoria(operandReg, 8);
               fpsystem('echo "' + intToStr(pino) + '" > /sys/class/gpio/export');
               case pegaMemoria(operandReg+1, 8) mod 5 of
                  0: fpsystem('echo "in"  > /sys/class/gpio/gpio' + intToStr(pino) + '/direction');
                  1: fpsystem('echo "out" > /sys/class/gpio/gpio' + intToStr(pino) + '/direction');
                  2: ;
                  3: fpsystem('echo "pwm" > /sys/class/gpio/gpio' + intToStr(pino) + '/direction');
                  4: fpsystem('echo "' + intToStr(pino) + '" > /sys/class/gpio/unexport');
               end;
             end;
        102: begin
                  pino := pegaMemoria(operandReg, 8);
                  valor := pegaMemoria(operandReg+1, 8) and 1;
                  fpsystem('echo "' + intToStr(valor)+ '" > /sys/class/gpio/gpio' + intToStr(pino) + '/value');
             end;
*)

(*
            fileDesc := fpopen('/sys/class/gpio/gpio17/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
      LogMemo.Lines.Add(IntToStr(gReturnCode));
    finally
      gReturnCode := fpclose(fileDesc);
*)



    end;
    application.processMessages;
end;

end.
