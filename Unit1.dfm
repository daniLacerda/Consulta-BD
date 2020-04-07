object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 388
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sbtnAbrirConsulta: TSpeedButton
    Left = 16
    Top = 16
    Width = 405
    Height = 25
    Caption = 'Abrir Consulta'
    OnClick = sbtnAbrirConsultaClick
  end
  object edtId_autores: TEdit
    Left = 16
    Top = 92
    Width = 38
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object edtNome_autores: TEdit
    Left = 60
    Top = 92
    Width = 361
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object pnlOperacoes: TPanel
    Left = 16
    Top = 47
    Width = 405
    Height = 39
    TabOrder = 2
    object sbtnAnterior: TSpeedButton
      Left = 8
      Top = 6
      Width = 52
      Height = 26
      Caption = 'Anterior'
      OnClick = sbtnAnteriorClick
    end
    object btnAlterar: TSpeedButton
      Left = 254
      Top = 6
      Width = 47
      Height = 26
      Caption = 'Alterar'
      OnClick = btnAlterarClick
    end
    object btnExcluir: TSpeedButton
      Left = 348
      Top = 6
      Width = 47
      Height = 26
      Caption = 'Excluir'
      OnClick = btnExcluirClick
    end
    object btnIncluir: TSpeedButton
      Left = 301
      Top = 6
      Width = 47
      Height = 26
      Caption = 'Incluir'
      OnClick = btnIncluirClick
    end
    object btnProximo: TButton
      Left = 61
      Top = 6
      Width = 49
      Height = 26
      Caption = 'Proximo'
      TabOrder = 0
      OnClick = btnProximoClick
    end
  end
  object pnlConfirmar: TPanel
    Left = 16
    Top = 335
    Width = 405
    Height = 36
    TabOrder = 3
    object btnSalvar: TSpeedButton
      Left = 306
      Top = 9
      Width = 89
      Height = 21
      Caption = 'Salvar'
      OnClick = btnSalvarClick
    end
    object btnCancelar: TSpeedButton
      Left = 214
      Top = 9
      Width = 89
      Height = 21
      Caption = 'Cancelar'
    end
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 119
    Width = 405
    Height = 210
    Ctl3D = True
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=estiladmin'
      'Password=e1s4t7i2l8'
      'Database=dblivraria'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 188
    Top = 53
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM dblivraria.autores')
    Left = 153
    Top = 51
    object FDQuery1id_autores: TFDAutoIncField
      DisplayWidth = 8
      FieldName = 'id_autores'
      Origin = 'id_autores'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1nome_autores: TStringField
      DisplayWidth = 30
      FieldName = 'nome_autores'
      Origin = 'nome_autores'
      Size = 30
    end
    object FDQuery1hora_log: TTimeField
      DisplayWidth = 10
      FieldName = 'hora_log'
      Origin = 'hora_log'
    end
    object FDQuery1data_log: TDateField
      DisplayWidth = 10
      FieldName = 'data_log'
      Origin = 'data_log'
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 62
    Top = 335
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 21
    Top = 337
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 221
    Top = 53
  end
end
