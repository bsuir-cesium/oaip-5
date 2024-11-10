program lab5;

uses
  SysUtils;

const
  n = 2000;

type
  TMAS = array [0 .. n - 1] of integer;

procedure GenerateRandomArray(var arr: TMAS);
var
  i: integer;
begin
    for i := 0 to n - 1 do
    begin
        arr[i] := Random(200);
    end;
end;

procedure PrintArray(var arr: TMAS);
var
  i: integer;
begin
    for i := 0 to n - 1 do
    begin
        write(arr[i], ' ');
    end;
    writeln;
end;

procedure PuzyrekModSort(var arr: TMAS);
var
  i, j, k, temp: integer;
begin
  i := 1;
  while i <= n do
  begin
    k := n;
    j := n;
    while j >= i do
    begin
      if arr[j - 1] > arr[j] then
      begin
        temp := arr[j - 1];
        arr[j - 1] := arr[j];
        arr[j] := temp;
        k := j;
      end;
      j := j - 1;
    end;
    i := K +1;
  end;
end;

procedure ShakeSort(var arr: TMAS);
var firstIndex, lastIndex, i, temp: integer;
begin
  firstIndex := 0;
  lastIndex := n - 1;

  while firstIndex < lastIndex do
  begin
    for i:= firstIndex to lastIndex-1 do
      if arr[i] > arr[i+1] then
      begin
        {обмен элементов}
        temp := arr[i];
        arr[i] := arr[i+1];
        arr[i+1] := temp;
      end;

    for i:= lastIndex downto firstIndex+1 do
      if arr[i] < arr[i-1] then
      begin
        {обмен элементов}
        temp := arr[i];
        arr[i] := arr[i-1];
        arr[i-1] := temp;
      end;

    firstIndex := firstIndex + 1;
    lastIndex := lastIndex - 1;
  end;
end;

var
  originalArray, arr1, arr2: TMAS;
begin
  GenerateRandomArray(originalArray);

  arr1 := originalArray;
  arr2 := originalArray;

  PuzyrekModSort(arr1);
  ShakeSort(arr2);

  PrintArray(arr1);
  writeln('------------------------------------------------------------------------');
  PrintArray(arr2);

  readln;
end.