unit DN.Preview;

interface

uses
  Classes,
  Types,
  System.UITypes,
  Controls,
  Graphics,
  DN.Package.Intf;

type
  TPreview = class(TCustomControl)
  private
    FPackage: IDNPackage;
    FSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    property Package: IDNPackage read FPackage write FPackage;
    property Selected: Boolean read FSelected write SetSelected;
    property OnClick;
  end;

implementation

{ TPreview }

constructor TPreview.Create(AOwner: TComponent);
begin
  inherited;
  Width := 192;
  Height := 120+40;
end;

destructor TPreview.Destroy;
begin

  inherited;
end;

procedure TPreview.Paint;
begin
  inherited;
  if Assigned(FPackage) then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect(Canvas.ClipRect);
    if Assigned(FPackage.Picture.Graphic) then
    begin
      Canvas.Draw(0, 0, FPackage.Picture.Graphic);
    end;
    Canvas.Font.Style := [TFontStyle.fsBold];
    Canvas.TextOut(5, 122, FPackage.Name);
    Canvas.Font.Style := [];
    Canvas.TextOut(5, 140, FPackage.Author);
    Canvas.Brush.Style := bsClear;
    if Selected then
    begin
      Canvas.Pen.Color := clBlue;
      Canvas.Pen.Width := 2;
    end
    else
    begin
      Canvas.Pen.Color := clNone;
      Canvas.Pen.Width := 1;
    end;
    Canvas.Rectangle(0, 0, Width, Height);
  end;
end;

procedure TPreview.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
  begin
    FSelected := Value;
    Invalidate;
  end;
end;

end.