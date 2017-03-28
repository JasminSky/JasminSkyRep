function _init()
 turn = 0
 player = 1
 err = false
 board = {
  x = 19,
  y = 19,
  w = 90,
  h = 90,
 	cells = {
 	 {0, 0, 0,},
 	 {0, 0, 0,},
 	 {0, 0, 0,},
 	},
  cw = 30,
  ch = 30,
  c = 5,
 }
 
 selection = {
 	x = 1,
 	y = 1,
 }
 
 cursor = {
	x = 19,
	y = 19,
	h = 48,
	w = 48,
	c = 7,
 }
 
 winner = 0
 draw=false
 drawcheck=0
 textwinner1 = false
 textwinner2 = false
end

function _update()
 --cursor bewegen
 if (winner == 0) then
  move()
 end
 
 --symbol platzieren
 --(oder neu starten)
 if btnp(4) then
  if (winner == 0) then
   place()
  else
   _init()
  end
 end

end

--[[
 diese funktion bewegt den
 cursor ueber das spielfeld
]]--
function move()
 if btnp(0) and cursor.x>19 then 
	cursor.x = cursor.x-30 
	cursor.w = cursor.w-30
	selection.x = selection.x-1
 end
 if btnp(1) and cursor.x<60 then 
	cursor.x = cursor.x+30 
	cursor.w = cursor.w+30 
	selection.x = selection.x+1
 end
 if btnp(2) and cursor.y>19 then
	cursor.y = cursor.y-30
	cursor.h = cursor.h-30
	selection.y = selection.y-1
 end
 if btnp(3) and cursor.y<60 then 
	cursor.y = cursor.y+30
	cursor.h = cursor.h+30
	selection.y = selection.y+1
 end 
end

--[[
 diese funktion soll pruefen
 ob das aktuelle feld leer ist
 und das symbol des jeweiligen
 spielers platzieren
]]--
function place()
 if board.cells[selection.x][selection.y]==0 then
	if player==1 then
		 player=2
	else
		player=1
	end
	board.cells[selection.x][selection.y]=player
	err=false
	drawcheck += 1
	checkboard()
 else
	err=true
 end
end

--[[
 diese funktion soll den
 status des spielfelds
 ueberprufen, d.h.in allen
 zeilen und spalten nach
 gleichen symbolen suchen
 und ggf. einen sieger finden
]]--
function checkboard()

--[[
Wincheck für Player 1
]]
 if board.cells[1][1]==1 and board.cells[1][2]==1 and board.cells[1][3]==1 then
	textwinner1=true
	winner=1
 end
 
 if board.cells[2][1]==1 and board.cells[2][2]==1 and board.cells[2][3]==1 then
	textwinner1=true
	winner=1
 end
 
 if board.cells[3][1]==1 and board.cells[3][2]==1 and board.cells[3][3]==1 then
	textwinner1=true
	winner=1
 end
 
 if board.cells[1][1]==1 and board.cells[2][1]==1 and board.cells[3][1]==1 then
	textwinner1=true
	winner=1
 end
 
 if board.cells[1][2]==1 and board.cells[2][2]==1 and board.cells[3][2]==1 then
	textwinner1=true
	winner=1
 end
 
 if board.cells[1][3]==1 and board.cells[2][3]==1 and board.cells[3][3]==1 then
	textwinner1=true
	winner=1
 end
 
 if board.cells[1][1]==1 and board.cells[2][2]==1 and board.cells[3][3]==1 then
	textwinner1=true
	winner=1
 end
 
 if board.cells[1][3]==1 and board.cells[2][2]==1 and board.cells[3][1]==1 then
	textwinner1=true
	winner=1
 end
 
--[[
Wincheck für Player 2
]]
 
 if board.cells[1][1]==2 and board.cells[1][2]==2 and board.cells[1][3]==2 then
	textwinner2=true
	winner=1
 end
 
 if board.cells[2][1]==2 and board.cells[2][2]==2 and board.cells[2][3]==2 then
	textwinner2=true
	winner=1
 end
 
 if board.cells[3][1]==2 and board.cells[3][2]==2 and board.cells[3][3]==2 then
	textwinner2=true
	winner=1
 end
 
 if board.cells[1][1]==2 and board.cells[2][1]==2 and board.cells[3][1]==2 then
	textwinner2=true
	winner=1
 end
 
 if board.cells[1][2]==2 and board.cells[2][2]==2 and board.cells[3][2]==2 then
	textwinner2=true
	winner=1
 end
 
 if board.cells[1][3]==2 and board.cells[2][3]==2 and board.cells[3][3]==2 then
	textwinner2=true
	winner=1
 end
 
 if board.cells[1][1]==2 and board.cells[2][2]==2 and board.cells[3][3]==2 then
	textwinner2=true
	winner=1
 end
 
 if board.cells[1][3]==2 and board.cells[2][2]==2 and board.cells[3][1]==2 then
	textwinner2=true
	winner=1
 end
  
 if textwinner1==false and textwinner2==false and drawcheck==9 then
	draw=true
	winner=1
 end
 
end

function _draw()
cls()

 -- spielfeld zeichnen
 for y=1, 3 do
  for x=1, 3 do
   xpos = board.x + ((x-1) * board.cw)
   ypos = board.y + ((y-1) * board.ch)
   
 	 rect(xpos,
 	      ypos,
 	      xpos + board.cw - 1,
 	      ypos + board.ch - 1,
 	      board.c)
	if board.cells[x][y]==1 then
		circ(xpos+board.cw/2, ypos+board.ch/2, 10, 8)
	end
	if board.cells[x][y]==2 then
		circfill(xpos+board.cw/2, ypos+board.ch/2, 10, 12)
	end
  end
 end
 
 if err==true then
	print("feld bereits belegt!", 19, 10, 8)
 end
 
 if textwinner1==true then
	print("player 2 gewinnt!", 19, 10, 11)
 end
 
 if textwinner2==true then
	print("player 1 gewinnt!", 19, 10, 11)
 end
 
 if draw==true then
	print("Unentschieden", 19, 10, 10)
 end
 rect(cursor.x, cursor.y, cursor.w, cursor.h, cursor.c)

end