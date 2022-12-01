const fs = require('fs')
const path = require('path')

let entries = fs.readFileSync(path.resolve(__dirname, '../inputs/day8.txt'), 'utf8')
	.split('\n')

let uniqueSignalPatterns = []
let outputValues = []
entries.forEach(entry => {
	let [uniqueSignalPattern, outputValue] = entry.split(' | ')
	uniqueSignalPatterns.push(uniqueSignalPattern.split(' '))
	outputValues.push(outputValue.split(' '))
})

// part 1
let count = outputValues.reduce((sum, values) => sum + values.reduce((sum, value) => sum + ([2, 3, 4, 7].includes(value.length) ? 1:0), 0), 0)
console.log(count) // 521


function isSuperset(set, subset) {
    for (let elem of subset) {
        if (!set.has(elem)) {
            return false
        }
    }
    return true
}

function difference(setA, setB) {
    let _difference = new Set(setA)
    for (let elem of setB) {
        _difference.delete(elem)
    }
    return _difference
}

function symmetricDifference(setA, setB) {
    let _difference = new Set(setA)
    for (let elem of setB) {
        if (_difference.has(elem)) {
            _difference.delete(elem)
        } else {
            _difference.add(elem)
        }
    }
    return _difference
}

function equals(setA, setB) {
	return symmetricDifference(setA, setB).size === 0
}

class Digit {
	valueFor(set) {
		let value = Object.keys(this).find(key=>symmetricDifference(this[key], set).size===0)
		switch (value) {
			case 'zero': return '0'
			case 'one': return '1'
			case 'two': return '2'
			case 'three': return '3'
			case 'four': return '4'
			case 'five': return '5'
			case 'six': return '6'
			case 'seven': return '7'
			case 'eight': return '8'
			case 'nine': return '9'
		}
	}
}

const decypher = (signals) => {
	let fiveSegmentDigits = signals.filter(signal=>signal.length == 5).map(signal=>new Set(signal.split('')))
	let sixSegmentDigits = signals.filter(signal=>signal.length == 6).map(signal=>new Set(signal.split('')))
	
	let digits = new Digit()

	digits.one = new Set(signals.find(signal=>signal.length == 2).split('')),
	digits.four = new Set(signals.find(signal=>signal.length == 4).split('')),
	digits.seven = new Set(signals.find(signal=>signal.length == 3).split('')),
	digits.eight = new Set(signals.find(signal=>signal.length == 7).split('')),
	digits.three = new Set(fiveSegmentDigits.find(digit=>isSuperset(digit, digits.one)))
	digits.six = new Set(sixSegmentDigits.find(digit=>!isSuperset(digit, digits.one)))
	digits.nine = new Set(sixSegmentDigits.find(digit=>isSuperset(digit, digits.three)))
	digits.zero = new Set(sixSegmentDigits.find(digit=>!equals(digit,digits.nine)&&!equals(digit,digits.six)))
	digits.five = new Set(fiveSegmentDigits.find(digit=>!equals(digit,digits.three)&&difference(digit, digits.six).size===0))
	digits.two = new Set(fiveSegmentDigits.find(digit=>!equals(digit,digits.three)&&!equals(digit,digits.five)))

	return digits
}

const decypheredNumber = (uniqueSignals, values) => {
	let digits = decypher(uniqueSignals)

	let decypheredValue = values.map(v=>digits.valueFor(new Set(v.split(''))))

	return decypheredValue.map(v=>`${v}`).join('')
}

let sum = 0
for (let i = 0; i < uniqueSignalPatterns.length; i++) {
// for (let i = 0; i < 2; i++) {
	sum += parseInt(decypheredNumber(uniqueSignalPatterns[i], outputValues[i]), 10)
}

console.log(sum)
