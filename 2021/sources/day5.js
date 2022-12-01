const fs = require('fs')
const path = require('path')
let input = fs.readFileSync(path.resolve(__dirname, '../inputs/day5.txt'), 'utf8')
	.split('\n')
	.map(line => {
		let points = line
					.split(' -> ')
					.map(point => ({
						x: parseInt(point.split(',')[0]),
						y: parseInt(point.split(',')[1])
					}))
		return {start: points[0], end: points[1]}
	})

const countVulcanos = (grid, min) => grid.reduce((sum, line)=>{
		return sum+line.reduce((sum, field)=>{
			return sum + (field >= min ? 1 : 0)
		}, 0)
	}, 0)

// part 1
let perpendicularLines = input.filter(line => line.start.x === line.end.x || line.start.y === line.end.y)
let grid = new Array(1000).fill([]).map(line=>new Array(1000).fill(0))

perpendicularLines.forEach(line => {
	if (line.start.y == line.end.y) {
		let direction = line.end.x - line.start.x > 0 ? 1 : -1
		for (let i = 0 ;i <= Math.abs(line.end.x - line.start.x); i++) {
			let x = i * direction + line.start.x,
				y = line.start.y
			grid[y][x] += 1
		}
	} else if (line.start.x == line.end.x) {
		let direction = line.end.y - line.start.y > 0 ? 1 : -1
		for (let i = 0 ; i <= Math.abs(line.end.y - line.start.y); i++) {
			let y = i * direction + line.start.y,
				x = line.start.x
			grid[y][x] += 1
		}
	}
})



console.log(countVulcanos(grid, 2))

// part 2
grid = new Array(1000).fill([]).map(line=>new Array(1000).fill(0))
input.forEach(line => {
	let directionX = line.end.x == line.start.x ? 0 : line.end.x - line.start.x > 0 ? 1 : -1
	let directionY = line.end.y == line.start.y ? 0 : line.end.y - line.start.y > 0 ? 1 : -1
	let distance = Math.max(Math.abs(line.end.x - line.start.x), Math.abs(line.end.y - line.start.y))
	for (let i = 0 ;i <= distance; i++) {
		let x = i * directionX + line.start.x,
			y = i * directionY + line.start.y
		grid[y][x] += 1
	}
})

console.log(countVulcanos(grid, 2))

// part 1: 4745
// part 2: 18442