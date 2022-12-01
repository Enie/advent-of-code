const fs = require('fs')
const path = require('path')

let octopi = fs.readFileSync(path.resolve(__dirname, '../inputs/day11.txt'), 'utf8')
	.split('\n').map(line=>line.split('').map(level=>parseInt(level, 10)))

const flash = (location, map) => {
	let {x, y} = location
	for (offsetY=Math.max(y-1, 0);offsetY<=Math.min(y+1,9);offsetY++) {
		for (offsetX=Math.max(x-1, 0);offsetX<=Math.min(x+1,9);offsetX++) {
			if (!(offsetX==x&&offsetY==y)) {
				map[offsetY][offsetX] = map[offsetY][offsetX]==10?10:map[offsetY][offsetX]+1
			}
		}
	}
}

const printOctopi = () => console.log(octopi.map(line=>line.map(n=>n.toString(16)).join('')).join('\n'), '\n')

let flashesCount = 0
const step = (i) => {
	let someOctopusDidFlash = false
	octopi = octopi.map(line=>line.map(level=>level+1))
	
	let repeat = 0
	do {
		// console.log(repeat++)
		someOctopusDidFlash=false
		for(let y = 0; y<10; y++) {
			for(let x = 0; x<10; x++) {
				if (octopi[y][x] == 10) {
					octopi[y][x] += 1
					someOctopusDidFlash = true
					flashesCount++
					flash({x,y}, octopi)
				}
			}
		}
	} while (someOctopusDidFlash)

	for (let x = 0 ; x < 10; x++) {
		for (let y = 0 ; y < 10; y++) {
			if (octopi[y][x] > 9)
				octopi[y][x] = 0
		}
	}

	let sum = octopi.reduce((sum,line)=>sum + line.reduce((sum,level)=>sum+level,0), 0)
	if (sum===0) {
		printOctopi()
		console.log('flash', i)
	}
}

Array.from({length: 100}, (v,i)=>step(i));
console.log(flashesCount) // 1793 flashes after 100 steps
// first synchronized flash after step 247