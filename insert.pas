program insert;

{ Mit Insert Sort einsortierte einfach verkettete Liste - Murilo Escher Pagotto Ronchi }

uses crt;

type
  zListEl = ^ListEl;
  ListEl = record
    wert: integer;
    next: zListEl;
  end;

procedure pushEl(var anker: zListEl; zahl: integer);
var aux: zListEl;
begin
  new(aux);
  aux^.wert := zahl;
  aux^.next := anker;
  anker := aux;
end;

procedure isort(var anker: zListEl; zahl: integer);
begin
  if (anker = NIL) or (zahl < anker^.wert) then
    pushEl(anker, zahl)
  else
    isort(anker^.next, zahl);
end;

procedure genListe(var anker: zListEl; max_size, max_wert: integer);
var i: integer;
begin
  for i := 1 to max_size do
    isort(anker, random(max_wert));
end;

function zaehleElemente(z: zListEl) : integer;
begin
  if z = NIL then
    zaehleElemente := 0
  else
    zaehleElemente := zaehleElemente(z^.next) + 1;
end;

function istDrin(z: zListEl; zahl: integer) : boolean;
begin
  if z = NIL then
    istDrin := false
  else if z^.wert = zahl then
    istDrin := true
  else
    istDrin := istDrin(z^.next, zahl);
end;

procedure ausgabe(z: zListEl);
begin
  if zaehleElemente(z) = 0 then
    writeln('Die Liste ist leer.')
  else
    begin
      write(z^.wert);
      if z^.next <> NIL then
        begin
          write(' - ');
          ausgabe(z^.next);
        end
      else
        writeln;
    end;
end;

procedure entferneElement(var anker: zListEl; zahl: integer);
var aux: zListEl;
begin
  if anker^.wert = zahl then
    begin
      aux := anker;
      anker := anker^.next;
      dispose(aux);
    end
  else
    entferneElement(anker^.next, zahl);
end;

var
  max_size, max_wert, random_zahl: integer;
  anker: zListEl;

begin
  clrscr;
  randomize;

  new(anker);
  anker := NIL;

  max_size := random(5) + 5;
  max_wert := random(10) + 10;

  genListe(anker, max_size, max_wert);

  ausgabe(anker);

  repeat
    random_zahl := random(max_wert);
  until istDrin(anker, random_zahl) = true;

  writeln('Das zu löschende Element ist ', random_zahl);

  if istDrin(anker, random_zahl) = true then
    entferneElement(anker, random_zahl);

  ausgabe(anker);

  dispose(anker);
end.
