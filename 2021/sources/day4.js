const fs = require('fs')
const path = require('path')
let input = fs.readFileSync(path.resolve(__dirname, '../inputs/day4.txt'), 'utf8').split('\n\n')

let drawnNumbers = input.shift().split(',').map(n=>parseInt(n, 10))
let boards = input.map(boardInput => 
	boardInput.split('\n').map(row =>
		row.split(' ')
			.map(number=> parseInt(number.trim(), 10))
			.filter(number => !isNaN(number))
	)
)

const checkRows = (board) => board.reduce((bingo, row) => bingo || 0 == row.reduce((sum, number) => sum + number, 0), false)
const checkColumns = (board) => [0,1,2,3,4].reduce((bingo, column) => bingo || 0 == board.reduce((sum, row) => sum + row[column], 0), false)

let winningBoard = null
let loosingNumber = null
let loosingBoard = null

drawnNumbers.forEach(drawnNumber => {
	boards = boards.map((board, index) => {
		board = board.map(row => row.map(number => number===drawnNumber ? 0 : number))
		if (checkRows(board) || checkColumns(board)) {
			if (!winningBoard) {
				winningBoard = board.reduce((sum, row) => sum + row.reduce((sum, number) => sum + number, 0), 0)
				console.log("BINGO", winningBoard*drawnNumber)
			}
			loosingNumber = drawnNumber
			loosingBoard = board.reduce((sum, row) => sum + row.reduce((sum, number) => sum + number, 0), 0)
			board = [[1000]]
		}
		return board
	})
})

console.log("BONGO", loosingNumber, loosingBoard, loosingBoard*loosingNumber)
