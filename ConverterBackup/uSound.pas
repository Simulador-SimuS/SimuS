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

unit uSound;

interface
uses Windows, MMSystem;

procedure SoundPlay(Hz: Word; durMS: integer);

implementation

const
     soundSize = 11025;
var
     wavHdr: array [0..43] of byte = (
        $52, $49, $46, $46, $ff, $ff, $ff, $ff, $57, $41, $56, $45, $66, $6d, $74, $20,
        $10, $00, $00, $00, $01, $00, $01, $00, $11, $2b, $00, $00, $11, $2b, $00, $00,
        $01, $00, $08, $00, $64, $61, $74, $61, $ff, $ff, $ff, $ff);

type
    TSound = array [0.. sizeof (wavHdr) + soundSize-1] of byte;

var
    PSound: ^TSound;

procedure SoundPlay(Hz: Word; durMS: integer);
var l: longint;
    p, period: integer;
begin
    getMem (psound, sizeof (psound^)+2);  {1 second}
    if hz <> 0 then
        period := 11025 div hz
    else
        period := 11025;
    p := sizeof (wavHdr);
    l := 0;
    while p <= soundSize-period do
        begin
            fillchar (psound^[p], period div 2 + 1, $60);
            p := p + period div 2;
            fillchar (psound^[p], period-(period div 2)+1, $a0);
            p := sizeof (wavHdr) +
                 integer (longint(11025)* l div longint(hz));
            l := l + 1;
        end;
    psound^[p-1] := $80;
    l := p - sizeof (wavHdr);
    move (l, wavHdr[40], 4);
    l := l + 36;
    move (l, wavHdr[4], 4);
    move (wavHdr, psound^, sizeof (wavHdr));

{$ifdef Win32}
    sndPlaySound (pchar (psound), snd_async + snd_memory + snd_loop);
    sleep (durMS);
    sndPlaySound (NIL, snd_sync);
{$else}

    // Gabriel, complete isso

{$endif}

    freeMem (psound, sizeof (psound^)+2);  {1 second}
end;

end.
