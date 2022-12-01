const fs = require('fs')
const path = require('path')
let input = fs.readFileSync(path.resolve(__dirname, './inputs/day1.js'), 'utf8').split('\n')

const sumup = (depths, window = 1) => {
	lastDepth = Infinity
	return depths.reduce((result, depth, index) => {
		if (index > window - 2) {
			let depthWindow = Array
								.from({length:window},(v,k)=>k)
								.reduce((sum, i)=>sum+parseInt(depths[index-i], 10), 0)
			let newResult = result + (depthWindow > lastDepth ? 1 : 0)
			lastDepth = depthWindow
			return newResult
		}
		return result
	}, 0)
}

console.log(sumup(input))
console.log(sumup(input, 3))

// part 1: 1715
// part 2: 1739