unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TModo = (modoInclusao, modoAlteracao, modoLeitura);
  TForm1 = class(TForm)
    edtId_autores: TEdit;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    edtNome_autores: TEdit;
    sbtnAbrirConsulta: TSpeedButton;
    pnlOperacoes: TPanel;
    sbtnAnterior: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    btnExcluir: TSpeedButton;
    pnlConfirmar: TPanel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    DBGrid1: TDBGrid;
    btnProximo: TButton;
    FDQuery1id_autores: TFDAutoIncField;
    FDQuery1nome_autores: TStringField;
    FDQuery1hora_log: TTimeField;
    FDQuery1data_log: TDateField;
    DataSource1: TDataSource;
    procedure sbtnAbrirConsultaClick(Sender: TObject);
    procedure sbtnAnteriorClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
  private
    { Private declarations }
    FModo:TModo;
    procedure ConsultaLinhas;
    procedure HabilitarTela(AHabilitado:boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.ConsultaLinhas;
begin
  edtId_autores.Text := FDQuery1.FieldByName('id_autores').AsString;
  edtNome_autores.Text :=  FDQuery1.FieldByName('nome_autores').AsString;
end;

procedure TForm1.btnAlterarClick(Sender: TObject);
begin
  HabilitarTela(True);
  edtId_autores.ReadOnly:=True;
  FModo := modoAlteracao;
end;

procedure TForm1.btnCancelarClick(Sender: TObject);
begin
  ConsultaLinhas;
  HabilitarTela(False);
  FModo:=modoLeitura;
end;
//----- Botão de excluir comando sql
procedure TForm1.btnExcluirClick(Sender: TObject);
begin
  if FDConnection1.ExecSQL('DELETE FROM autores WHERE id_autores='+QuotedStr(edtId_autores.Text))>0 then
  begin
    ShowMessage('Excluido com sucesso');
    HabilitarTela(False);
    FDQuery1.Refresh;
    ConsultaLinhas;
  end;

end;

procedure TForm1.btnIncluirClick(Sender: TObject);
begin
  HabilitarTela(True);
  FModo := modoInclusao;
end;

procedure TForm1.btnSalvarClick(Sender: TObject);
var
  _dt:TDateTime;
begin
  if FModo=modoLeitura then
    Exit;

  if FModo=modoInclusao then
  begin
    FDQuery1.Append;
    FDQuery1.FieldByName('nome_autores').Value := edtNome_autores.Text;
    //FDQuery1.FieldByName('hora_log').Value := (Time);
    //FDQuery1.FieldByName('data_log').Value := (Date);
  end
  else
  begin
    FDQuery1.Edit;
  end;
  FDQuery1.FieldByName('nome_autores').Value := edtNome_autores.Text;
  FDQuery1.FieldByName('hora_log').Value := (Time);
  FDQuery1.FieldByName('data_log').Value := (Date);
  FDQuery1.Post;

  HabilitarTela(False);
  FModo:=modoLeitura;
end;

procedure TForm1.btnProximoClick(Sender: TObject);
begin
  FDQuery1.Next;
  ConsultaLinhas;
end;

procedure TForm1.HabilitarTela(AHabilitado: boolean);
begin
  pnlOperacoes.Enabled := not AHabilitado;
  pnlConfirmar.Enabled := AHabilitado;
  edtId_autores.ReadOnly := False;
  edtNome_autores.ReadOnly := False;
end;

procedure TForm1.sbtnAnteriorClick(Sender: TObject);
begin
  FDQuery1.Prior;
  ConsultaLinhas;
end;

procedure TForm1.sbtnAbrirConsultaClick(Sender: TObject);
begin
  FDQuery1.Active:=Active;
  FDQuery1.SQL.Text :=
    'SELECT id_autores, nome_autores, hora_log, data_log FROM autores';

  try
    FDQuery1.Open;
  except on E: Exception do
    raise Exception.Create('Falha ao abrir consulta de autores. '+E.Message);
  end;
  FDQuery1.FetchAll;
  FModo := modoLeitura;

  FDQuery1.First;

  ConsultaLinhas;
  HabilitarTela(False);
end;

end.
