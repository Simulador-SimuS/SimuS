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

unit uAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label2: TLabel;
    Image1: TImage;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
    close;
end;

end.
 
