const fs = require('fs')
const path = require('path')

let lines = fs.readFileSync(path.resolve(__dirname, '../inputs/day10.txt'), 'utf8')
	.split('\n').map(line=>line.split(''))

let chunks

let points = {
	')': 3,
	']': 57,
	'}': 1197,
	'>': 25137,
	null: 0
}

let pairs = {'(':')','[':']','{':'}','<':'>'}
let incompleteLines = []
let score = lines.reduce((score, line) => {
	let stack = []
	let illegalCharacter = null
	let index = 0
	while(!illegalCharacter && index!==line.length) {
		let character = line[index]
		if ('([{<'.indexOf(character)>=0) {
			stack.push(character)
		} else {
			if (pairs[stack[stack.length-1]] !== character) {
				illegalCharacter=character
			}
			stack.pop()
		}
		index++
	}
	if (illegalCharacter===null) incompleteLines.push(stack.reverse().map(c=>pairs[c]))
	return score+points[illegalCharacter]
}, 0)
console.log('illegal syntax score', score)


points = { ')': 1,']': 2,'}': 3,'>': 4 }
scores = incompleteLines.map(completion=>
	completion.reduce((score, character)=> score*5 + points[character], 0)
).sort((scoreA, scoreB)=>scoreA<scoreB?-1:1)
console.log('missing syntax score', scores[Math.floor(scores.length/2)])

// 614634 too high