program main;


uses
  SysUtils;






function verifyDraw(var board: TArray<TArray<Integer>>): Boolean;
var
  i, j : Integer;

begin
  Result := True;
  for i := Low(Board) to High(Board) do
  begin
    for j := Low(Board[i]) to High(Board[i]) do
    begin
      if board[i][j] = 0 then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;





function checkLine(var board: TArray<TArray<Integer>>): Boolean;
var
  win : Boolean;
  i, j, temp : Integer;

begin

  for i := Low(board) to High(board) do
  begin

    temp := 0;
    win := False;

    for j := Low(board[i]) to High(board[i]) do
    begin

      if board[i][j] = 0 then
        break

      else if temp = 0 then
        temp := board[i][j]

      else if board[i][j] <> temp then
      begin

        win := False;
        break;

      end

      else if j = High(board[i]) then
        win := True;

    end;

    if win then
      break;

  end;

  Result := win;

end;





function checkColumn(var board: TArray<TArray<Integer>>): Boolean;
var
  win : Boolean;
  i, j, temp : Integer;

begin

  for i := Low(board) to High(board) do
  begin

    temp := 0;
    win := False;

    for j := Low(board[i]) to High(board[i]) do
    begin

      if board[j][i] = 0 then
        break

      else if temp = 0 then
        temp := board[j][i]

      else if board[j][i] <> temp then
      begin

        win := False;
        break;

      end

      else if j = High(board[j]) then
        win := True;

    end;

    if win then
      break;

  end;

  Result := win;

end;





function checkFirstDiagonal(var board: TArray<TArray<Integer>>): Boolean;
var
  win: Boolean;
  i, temp : Integer;

begin

  temp := 0;
  win := False;

  for i := Low(board) to High(board) do
  begin

    if board[i][i] = 0 then
      break

    else if temp = 0 then
      temp := board[i][i]

    else if board[i][i] <> temp then
    begin
      win := False;
      break;
    end

    else if i = High(board) then
      win := True;

  end;

  Result := win;

end;





function checkSecondDiagonal(var board: TArray<TArray<Integer>>): Boolean;
var
  win: Boolean;
  i, temp : Integer;

begin

  temp := 0;
  win := False;

  for i := Low(board) to High(board) do
  begin

    if board[i][High(board) - i] = 0 then
      break

    else if temp = 0 then
      temp := board[i][High(board) - i]

    else if board[i][High(board) - i] <> temp then
    begin
      win := False;
      break;
    end

    else if i = High(board) then
      win := True;

  end;

  Result := win;

end;





function verifyWinner(var board: TArray<TArray<Integer>>): Boolean;
begin
  Result := checkLine(board) or checkColumn(board) or checkFirstDiagonal(board) or checkSecondDiagonal(board);
end;





procedure changePlayer(var player: Integer);
begin
 player := (player + 1) mod 2;
end;





procedure printBoard(var board : TArray<TArray<Integer>>);
var
  i, j : Integer;

begin

  WriteLn;

  for i := Low(board) to High(board) do
  begin

    for j := Low(board[i]) to High(board[i]) do
    begin

      if board[i][j] = 0 then
        Write('*')
      else if board[i][j] = 1 then
        Write('X')
      else if board[i][j] = 2 then
        Write('O');

      if j <> High(board[i]) then
        Write(' | ')
      else
        WriteLn;

    end;
    if i <> High(board) then
      WriteLn('----------');
  end;

  WriteLn;
end;





procedure fillBoard(var board : TArray<TArray<Integer>>; player, line, column : Integer);
begin
  case player of
    0: board[line][column] := 1;
    1: board[line][column] := 2;
  end;
end;





procedure readInput(var board : TArray<TArray<Integer>>; player : Integer);
var
  line, column : Integer;

begin
  Writeln('Player ', player + 1, ' turn:' + #10#13);

  write('Input the line (0, 1, 2): ');
  read(line);

  write('Input the column (0, 1, 2): ');
  read(column);

  if board[line][column] = 0 then
    begin
      fillBoard(board, player, line, column);
    end
  else
    begin
      Writeln(#10#13 + 'INPUT A VALID POSITION!!!' + #10#13);
      readInput(board, player)
    end;

end;





var
  board : TArray<TArray<Integer>> = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];

  player : Integer = 0;

begin

  printBoard(board);

  while True do
  begin

    readInput(board, player);
    printBoard(board);

    if verifyWinner(board) then
      begin
        Writeln('PLAYER ', player + 1, ' WON THE GAME!!!');
        break
      end

    else if verifyDraw(board) then
      begin
        WriteLn('ITs A DRAW!!!');
        break;
      end

    else
      changePlayer(player);

  end;

  readln;
end.