//
//    Copyright 2016 Gabriel P. Silva and Jos� Antonio S. Borges
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
//    Este arquivo � parte do programa simulador SimuS.
//
//    SimuS � um software livre; voc� pode redistribu�-lo e/ou
//    modific�-lo dentro dos termos da Licen�a P�blica Geral GNU como
//    publicada pela Funda��o do Software Livre (FSF); na vers�o 3 da
//    Licen�a, ou (na sua opini�o) qualquer vers�o.
//
//    Este programa � distribu�do na esperan�a de que possa ser �til,
//    mas SEM NENHUMA GARANTIA; sem uma garantia impl�cita de ADEQUA��O
//    a qualquer MERCADO ou APLICA��O EM PARTICULAR. Veja a
//    Licen�a P�blica Geral GNU para maiores detalhes.
//
//    Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral GNU junto
//    com este programa, se n�o, veja em <http://www.gnu.org/licenses/>.
//

unit utrap;

interface
uses forms, windows, uvars, uConsole, uSound, sysutils;

procedure execTrap (var ACC: int8; operandReg: int16);

implementation
uses uSimula;

procedure execTrap (var ACC: int8; operandReg: int16);
(* var c: byte;*)
var s: string;
    i, ncarac, tempo: integer;
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
                  {retorna em ACC o n�mero de letras lidas, o CR n�o vem}
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

               // nota: ACC volta com o n�mero de letras escritas, ou zero, se problemas
               // caracteres especiais: CR, LF, FF
           end;

        5: begin
               // temporiza��o.  tempo em mil�simos de segundos
               tempo := pegaMemoria(operandReg, 16);
               sleep (tempo);
           end;

        6: begin
               // gerar tom:  frequ�ncia, dura��o em ms  --> bloqueante
               freq  := pegaMemoria(operandReg, 16);
               durMS := pegaMemoria(operandReg+2, 16);
               soundPlay (freq, durMS);
           end;

        7: begin
               // retorna n�mero pseudo aleat�rio entre 0-99
               ACC := random (100);
           end;

        8: begin
               // semente aleatoria
               randSeed := pegaMemoria(operandReg, 8);
           end;
    end;
    application.processMessages;
end;

end.
