object JvTipsFrm: TJvTipsFrm
  Left = 461
  Top = 304
  BorderStyle = bsToolWindow
  Caption = ' '
  ClientHeight = 252
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 16
    Top = 8
    Width = 361
    Height = 185
    Pen.Style = psInsideFrame
  end
  object Shape2: TShape
    Left = 16
    Top = 8
    Width = 73
    Height = 185
    Brush.Color = clGray
  end
  object Shape3: TShape
    Left = 88
    Top = 48
    Width = 289
    Height = 1
    Brush.Color = clBlack
    Pen.Width = 10
  end
  object TitleLabel: TLabel
    Left = 96
    Top = 16
    Width = 141
    Height = 22
    Caption = 'Did you know...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Image1: TImage
    Left = 32
    Top = 24
    Width = 41
    Height = 43
    AutoSize = True
    Center = True
    Picture.Data = {
      07544269746D61707E040000424D7E0400000000000076000000280000002900
      00002B0000000100040000000000080400000000000000000000100000001000
      0000000000000000BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00888888888888888888888888888888888888888880000000888888888888
      8888888888888888888888888888800000008888888888888888888888888888
      8888888888888000000088888888888888888888888888888888888888888000
      0000888888888888888888888888888888888888888880000000888888888888
      8888888888888888888888888888800000008888888888888888888888888888
      8888888888888000000088888888888888888888888888888888888888888000
      0000888888888888888888808888888888888888888880000000888888888888
      8888880E0888888888888888888880000000888888888888888880EFE0888888
      8888888888888000000088888888888888880EFFFE0888888888888888888000
      00008888888888888880EFFFFFE0888888888888888880000000888888888888
      880EFFFFFFFE08888888888888888000000088888888888880EFFF000FFFE088
      888888888888800000008888888888880EFFF00000FFFE088888888888888000
      0000888888888880EFFF88F7700FFFE08888888888888000000088888888880E
      FFFF8F00070FFFFE088888888888800000008888888880EFFFF880F77000FFFF
      E0888888888880000000888888880EFFFFF8FF000770FFFFFE08888888888000
      00008888888888EFFFF800333000FFFFE088888888888000000088888888888E
      FFF033BBB330FFFE08888888888880000000888888888888EF03BBBBBBB30FE0
      888888888888800000008888888888888E03BBFBFBF30E088888888888888000
      0000888888888888803BBB808BBB308888888888888880000000888888888888
      03BBFB000BFBF308888888888888800000008888888888880BBBBF808FBBB308
      88888888888880000000888888888883BBFBFBFBFBFBFB308888888888888000
      0000888888888883BBBFBFB0BFBFBB3088888888888880000000888888888883
      FBFFFFF0FBFBFB3088888888888880000000888888888883BFFFFF808FBFBB30
      88888888888880000000888888888883BFFFFF000BFBFB308888888888888000
      00008888888888883FFFFF000FBFBB0888888888888880000000888888888888
      3BFFFF000BFBFB088888888888888000000088888888888883BFFF808FBBB088
      88888888888880000000888888888888883BFBFBFBFB38888888888888888000
      000088888888888888833BBBBB33888888888888888880000000888888888888
      8888833333888888888888888888800000008888888888888888888888888888
      8888888888888000000088888888888888888888888888888888888888888000
      0000888888888888888888888888888888888888888880000000888888888888
      8888888888888888888888888888800000008888888888888888888888888888
      88888888888880000000}
  end
  object ShowCheck: TCheckBox
    Left = 18
    Top = 220
    Width = 121
    Height = 17
    Caption = 'Show tips on start'
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object NextTipBtn: TButton
    Left = 216
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Next Tip'
    Default = True
    TabOrder = 1
    OnClick = NextTipBtnClick
  end
  object CancelBtn: TButton
    Left = 296
    Top = 216
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 2
    OnClick = CancelBtnClick
  end
  object TipWindow: TMemo
    Left = 98
    Top = 57
    Width = 265
    Height = 125
    BorderStyle = bsNone
    TabOrder = 3
  end
end