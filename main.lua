function love.load()
	isPlayerOnesTurn = true
	markThatWon = {}
	currentTicTacToePos = {}
	width = love.graphics.getWidth( )
	height = love.graphics.getHeight( )

	board = {}
	board[1] = {" "," "," "}
	board[2] = {" "," "," "}
	board[3] = {" "," "," "}
end

function love.draw()
    drawBardState()
    drawBoardLines()
    if hasWon() then
		love.graphics.setColor(255,255,255,255)
		if markThatWon == "X" then
			announcement = "Player 1 won the game"
		else
			announcement = "Player 2 won the game"
		end
		love.graphics.print(announcement, 100, 100)
	end
end

function hasWon()
	pc = {"X","O"}
	for i=1,2 do
		if smartHasWon(pc[i]) then
			markThatWon = pc[i]
			return true
		end
	end
	return false
end

function smartHasWon(mark)
	for j=1,3 do
		for k=1,3 do
			if k+1<4 and k+2<4 and board[j][k] == mark and board[j][k+1] == mark and board[j][k+2] == mark then	
				return true
			elseif j+1<4 and j+2<4 and board[j][k] == mark and board[j+1][k] == mark and board[j+2][k] == mark then
				return true
			elseif j-1>0 and k-1>0 and j+1<4 and k+1<4 and board[j-1][k-1] == mark and board[j][k] == mark and board[j+1][k+1] == mark then
				return true
			elseif j-1>0 and k-1>0 and j+1<4 and k+1<4 and board[j-1][k+1] == mark and board[j][k] == mark and board[j+1][k-1] == mark then
				return true
			end	
		end
	end
end

function love.mousereleased(x, y, button)
   if button == 1 then -- 1 is the mouse button
   		currentTicTacToePos = getTicTacToePos(x,y)
   		if not hasWon() and isLegalMove() then
   			doMove()
   		end
   end
end

function doMove()
	playerMark = "X"
	if not isPlayerOnesTurn then
		playerMark = "O"
	end
	board[currentTicTacToePos[1]][currentTicTacToePos[2]] = playerMark
	isPlayerOnesTurn = not isPlayerOnesTurn
end

function isLegalMove()
	return board[currentTicTacToePos[1]][currentTicTacToePos[2]] == " "
end	

function getTicTacToePos(x,y)
	ticTacToePos = {}
	if x <= width/3 then 
		ticTacToePos[1] = 1
	elseif x >= width/3 and x < width/3*2 then
		ticTacToePos[1] = 2
	elseif x >= width/3*2 then
		ticTacToePos[1] = 3
	end

	if y <= height/3 then
		ticTacToePos[2] = 1
	elseif y <= height/3*2 and y >= height/3 then
		ticTacToePos[2] = 2
	elseif y <= height and y>= height/3*2 then
		ticTacToePos[2] = 3
	end
	return ticTacToePos
end

function drawBardState()
    for i=1,3 do
		for j=1,3 do
			fillSquare(i,j,board[i][j])
		end
	end
end

function fillSquare(x,y,value)
	startX = (x-1)*width/3
	startY = (y-1)*height/3
	if value=="X" then
		love.graphics.setColor(80,180,80,255)
		love.graphics.rectangle("fill", startX, startY, width/3, height/3)
	elseif value=="O" then
		love.graphics.setColor(80,80,180,255)
		love.graphics.rectangle("fill", startX, startY, width/3, height/3)
	end
end

function drawBoardLines()
	love.graphics.setColor(180,80,80,255)
	love.graphics.line(width/3, 0, width/3, height)
	love.graphics.line(width/3*2, 0, width/3*2, height)

	love.graphics.line(0, height/3, width, height/3)
	love.graphics.line(0, height/3*2, width, height/3*2)
end

