const fs = require('fs')
const path = require('path')
let fishies = fs.readFileSync(path.resolve(__dirname, '../inputs/day6.txt'), 'utf8')
	.split(',')

// part 1
for (let day = 0; day < 80; day++) {
	fishies.forEach ((fish, index) => {
		if (fish === 0) {
			fishies[index] = 6
			fishies.push(8)
		} else {
			fishies[index] -= 1
		}
	})
}
console.log(fishies.length) // 385391

// part 2
let fishies2 = fs.readFileSync(path.resolve(__dirname, '../inputs/day6.txt'), 'utf8')
	.split(',').map(n=>parseInt(n, 10))

let prolificacyMap = {255:1, 254:1, 253:1, 252:1, 251:1, 250:1, 249:1, 248:1, 247:1}
const prolificacy = (day) => {
	let prolificacy = 1
	for (let futureDay = day+9; futureDay < 255; futureDay += 7) {
		prolificacy += prolificacyMap[futureDay]
	}
	return prolificacy
}

const fillProlificacyMap = (map) => {
	for (let day = 246; day > -10; day--) {
		prolificacyMap[day] = prolificacy(day)
	}
}

fillProlificacyMap(prolificacyMap)

let swarmCount =  fishies2.reduce((sum, fish)=>{
	return sum+prolificacyMap[fish-10]
}, 0)

console.log(swarmCount) // 1728611055389