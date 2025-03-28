program lab5;

{$mode DELPHI}

uses
  SysUtils;

const
  n = 2000;

type
  TInteger = integer;
  TMAS = array [0 .. n - 1] of TInteger;

var
  originalArray, arrayPuzyrek, arrayShake, arrayQuick: TMAS;
  comparisonsPuzyrek, comparisonsShake, comparisonsQuick, transpositionsPuzyrek,
  transpositionsShake, transpositionsQuick: TInteger;

procedure GenerateRandomArray(var arr: TMAS);
var
  i: TInteger;
begin
  for i := 0 to n - 1 do
  begin
    arr[i] := Random(2000);
  end;
end;

procedure PrintArray(var arr: TMAS);
var
  i: TInteger;
begin
  for i := 0 to n - 1 do
  begin
    write(arr[i], ' ');
  end;
  writeln;
end;

procedure PuzyrekModSort(var arr: TMAS; const n: TInteger;
  var comparisons, transpositions: TInteger); { Пузырёк с границей }
var
  i, j, temp, lastSwap: TInteger;
begin
  comparisons := 0;
  transpositions := 0;
  i := 1;
  while i <= n - 1 do
  begin
    lastSwap := n - 1;
    j := n - 1;

    while j >= i do
    begin
      if arr[j - 1] > arr[j] then
      begin
        temp := arr[j - 1];
        arr[j - 1] := arr[j];
        arr[j] := temp;
        lastSwap := j;
        Inc(transpositions);
      end;
      Inc(comparisons);
      j := j - 1;
    end;

    i := lastSwap + 1;
  end;
end;

procedure QuickSort(var arr: TMAS; const n: TInteger; var comparisons, transpositions: TInteger);

  procedure QuickSortRecursive(LowIdx, HighIdx: TInteger);
  var
    I, J: TInteger;
    Pivot, Temp: TInteger;
  begin
    I := LowIdx;
    J := HighIdx;
    Pivot := Arr[(LowIdx + HighIdx) div 2];

    repeat
      while Arr[I] < Pivot do 
      begin
        Inc(I);
        Inc(comparisons);
      end;
      while Arr[J] > Pivot do
      begin
        Dec(J);
        Inc(comparisons);
      end;

      if I <= J then
      begin
        Temp := Arr[I];
        Arr[I] := Arr[J];
        Arr[J] := Temp;
        Inc(I);
        Dec(J);
        Inc(transpositions);
      end;
    until I > J;

    if LowIdx < J then QuickSortRecursive(LowIdx, J);
    if I < HighIdx then QuickSortRecursive(I, HighIdx);
  end;

begin
  comparisons := 0;
  transpositions := 0;
  QuickSortRecursive(0, n - 1);
end;

procedure ShakeSort(var arr: TMAS; const n: TInteger;
  var comparisons, transpositions: TInteger);
var
  left, right, i, temp, lastSwap: TInteger;
begin
  comparisons := 0;
  transpositions := 0;
  left := 0;
  right := n - 1;
  lastSwap := 0;

  while right > left do
  begin
    for i := left to right - 1 do
    begin
      if (arr[i] > arr[i + 1]) then
      begin
        temp := arr[i];
        arr[i] := arr[i + 1];
        arr[i + 1] := temp;

        lastSwap := i;
        Inc(transpositions);
      end;
      Inc(comparisons);
    end;
    right := lastSwap;

    for i := right downto left + 1 do
    begin
      if (arr[i] < arr[i - 1]) then
      begin
        temp := arr[i];
        arr[i] := arr[i - 1];
        arr[i - 1] := temp;

        lastSwap := i;
        Inc(transpositions);
      end;
      Inc(comparisons);
    end;
    left := lastSwap;

  end;
end;

procedure ReverseArray(var arr: TMAS; len, count: TInteger);
var
  i, temp: TInteger;
begin
  i := 0;
  while (i <= len - 1) and (count > 0) do
  begin
    temp := arr[len - i - 1];
    arr[len - i - 1] := arr[i];
    arr[i] := temp;
    i := i + 1;
    count := count - 1;
  end;

end;

begin
  GenerateRandomArray(originalArray);
  arrayPuzyrek := originalArray;
  arrayShake := originalArray;
  arrayQuick := originalArray;

  writeln('_____________________________________________________________________________________________________________________');
  writeln('|             |                                 |                                 |                                 |');
  writeln('|             |        Улучшенный пузырек       |        Шейкерная сортировка     |         Быстрая сортировка      |');
  writeln('| Тип массива |_________________________________|_________________________________|_________________________________|');
  writeln('|             |    Сравнения   |  Перестановки  |    Сравнения   |  Перестановки  |    Сравнения   |  Перестановки  |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  PuzyrekModSort(arrayPuzyrek, 10, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 10, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 10, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   10 эл.    |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|   неотсорт  |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  PuzyrekModSort(arrayPuzyrek, 10, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 10, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 10, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   10 эл.    |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|   отсорт    |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  ReverseArray(arrayPuzyrek, n, 10);
  ReverseArray(arrayShake, n, 10);
  ReverseArray(arrayQuick, n, 10);

  PuzyrekModSort(arrayPuzyrek, 10, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 10, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 10, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   10 эл.    |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|  обр. пор.  |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  arrayPuzyrek := originalArray;
  arrayShake := originalArray;
  arrayQuick := originalArray;
  PuzyrekModSort(arrayPuzyrek, 100, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 100, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 100, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   100 эл.   |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|   неотсорт  |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  PuzyrekModSort(arrayPuzyrek, 100, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 100, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 100, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   100 эл.   |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|   отсорт    |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  ReverseArray(arrayPuzyrek, n, 100);
  ReverseArray(arrayShake, n, 100);
  ReverseArray(arrayQuick, n, 100);

  PuzyrekModSort(arrayPuzyrek, 100, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 100, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 100, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   100 эл.   |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|  обр. пор.  |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  arrayPuzyrek := originalArray;
  arrayShake := originalArray;
  arrayQuick := originalArray;
  PuzyrekModSort(arrayPuzyrek, 2000, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 2000, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 2000, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   2000 эл.  |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|   неотсорт  |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  PuzyrekModSort(arrayPuzyrek, 2000, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 2000, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 2000, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   2000 эл.  |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|   отсорт    |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');

  ReverseArray(arrayPuzyrek, n, 1000);
  ReverseArray(arrayShake, n, 1000);
  ReverseArray(arrayQuick, n, 1000);

  PuzyrekModSort(arrayPuzyrek, 2000, comparisonsPuzyrek, transpositionsPuzyrek);
  ShakeSort(arrayShake, 2000, comparisonsShake, transpositionsShake);
  QuickSort(arrayQuick, 2000, comparisonsQuick, transpositionsQuick);

  writeln('|             |                |                |                |                |                |                |');
  writeln('|   2000 эл.  |  ', comparisonsPuzyrek:12, '  |  ', transpositionsPuzyrek:12, '  |  ', comparisonsShake:12, '  |  ', transpositionsShake:12, '  |  ', comparisonsQuick:12, '  |  ', transpositionsQuick:12, '  |');
  writeln('|  обр. пор.  |                |                |                |                |                |                |');
  writeln('|_____________|________________|________________|________________|________________|________________|________________|');
  readln;

end.