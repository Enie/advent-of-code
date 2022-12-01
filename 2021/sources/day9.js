const fs = require('fs')
const path = require('path')

let heightMap = fs.readFileSync(path.resolve(__dirname, '../inputs/day9.txt'), 'utf8')
	.split('\n').map(y=>y.split('').map(height=>parseInt(height, 10)))

let mapWidth = heightMap[0].length
let mapHeight = heightMap.length

let lowPoints = []
let riskLevel = heightMap.reduce((sum, line, y)=>{
	return sum+line.reduce((sum, height, x)=>{
		let left = x > 0 ? heightMap[y][x-1] : Infinity
		let up = y > 0 ? heightMap[y-1][x] : Infinity
		let right = x < mapWidth-1 ? heightMap[y][x+1] : Infinity
		let down = y < mapHeight-1 ? heightMap[y+1][x] : Infinity
		let isLowPoint = height < left && height < up && height < right && height < down
		if (isLowPoint) lowPoints.push({x, y})
		return sum + (isLowPoint ? height+1 : 0)
	}, 0)
}, 0)
console.log(riskLevel) // 444

const climbBasin = (basin, location, map) => {
	let {x, y} = location
	if (x<0 || y<0 || x>=mapWidth || y>=mapHeight || map[y][x] === 9) return
	if (basin.find(l=>location.x==l.x&&location.y==l.y)) return
	else basin.push(location)
	climbBasin(basin, {x:x-1, y:y}, map)
	climbBasin(basin, {x:x, y:y-1}, map)
	climbBasin(basin, {x:x+1, y:y}, map)
	climbBasin(basin, {x:x, y:y+1}, map)
}

let basins = lowPoints.map(location => {
	let basin = []
	climbBasin(basin, location, heightMap)
	return basin
}).sort((basinA, basinB) => basinA.length < basinB.length ? 1 : -1 )
console.log(basins[0].length*basins[1].length*basins[2].length)
