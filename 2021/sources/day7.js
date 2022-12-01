const fs = require('fs')
const path = require('path')

let positions = fs.readFileSync(path.resolve(__dirname, '../inputs/day7.txt'), 'utf8')
	.split(',').map(p=>parseInt(p, 10)).sort((a,b)=>a>b?1:-1) 

let medianPosition = positions[Math.floor(positions.length/2)]
let medianCost = positions.reduce((sum, p)=>sum+Math.abs(medianPosition-p), 0)
console.log('part 1:', medianCost)

const gauss = (x) => (1+x)*x/2

let min = positions[0]
let max = positions[positions.length-1]
let costs = {}

Array(max-min).fill(0).forEach((v,index)=>costs[min+index] = 0)
Object.keys(costs).forEach(pos=>costs[pos]=positions.reduce((sum, p)=>sum+gauss(Math.abs(p-pos)), 0))
console.log('part 2:', costs[Object.keys(costs).sort((p1, p2)=>costs[p1] < costs[p2] ? -1 : 1)[0]])