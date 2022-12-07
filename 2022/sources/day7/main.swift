import Foundation

class Path {
	var name: String = "", parent: Folder?
}
class Folder: Path {
	var children: [Path] = []
	var size: Int {
		if _size == nil {
			_size = children.reduce(0) {
				$0 + ((($1 as? File)?.size ?? ($1 as? Folder)?.size)!)
			}
		}
		return _size!
	}
	private var _size: Int?
	
	func folders(max: Int, folders: inout [Folder]) {
		if self.size <= max {folders.append(self)}
		children
			.filter{$0 is Folder}
			.map{$0 as! Folder}
			.forEach { current in
				current.folders(max: max, folders: &folders)
			}
	}
	func folders(min: Int, folders: inout [Folder]) {
		if self.size >= min {folders.append(self)}
		children
			.filter{$0 is Folder}
			.map{$0 as! Folder}
			.forEach { current in
				current.folders(min: min, folders: &folders)
			}
	}
	init(name: String, parent: Folder?, children: [Path]) {
		self.children = children
		super.init()
		self.name = name; self.parent = parent
	}
}
class File: Path {
	var size: Int
	init(name: String, parent: Folder?, size: Int) {
		self.size = size
		super.init()
		self.name = name
		self.parent = parent
	}
}

public func day7() {
	let commands = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day7.txt")
		.components(separatedBy: "$ ")
		.dropFirst(1)
	
	var currentFolder: Folder?
	
	commands
		.forEach { inoutOutputPair in
			var output: [String] = inoutOutputPair.components(separatedBy: .newlines).filter{ $0 != "" }
			let input: [String] = output.removeFirst().components(separatedBy: .whitespaces)
			let functionCall = input[0]
			
			if functionCall == "cd" {
				let folder = currentFolder?.children.first { $0.name == input[1] } as? Folder
				currentFolder = input[1] == ".."
				? currentFolder!.parent
				: folder ?? Folder(name: input[1], parent: currentFolder, children: [])
			} else if functionCall == "ls" {
				currentFolder!.children = output.map { line in
					let tokens = line.components(separatedBy: .whitespaces)
					if tokens[0] == "dir" {
						return Folder(name: tokens[1], parent: currentFolder, children: [])
					} else {
						return File(name: tokens[1], parent: currentFolder, size: Int(tokens[0])!)
					}
				}
			}
		}

	while currentFolder!.name != "/" {
		currentFolder = currentFolder!.parent
	}

	var smallFolders:[Folder] = []
	currentFolder!.folders(max: 100000, folders: &smallFolders)
	print("sum of folders with size under 100k: \(smallFolders.reduce(0) {$0 + $1.size})")


	let neededSpace = 30_000_000 - (70_000_000 - currentFolder!.size)
	var largeFolders:[Folder] = []
	currentFolder!.folders(min: neededSpace, folders: &largeFolders)

	let folderToDelete = largeFolders
		.sorted{ $0.size < $1.size }
		.first!
	print("the smallest folder that is large enough is \(folderToDelete.name) \(folderToDelete.size)")
}

day7()


// part 1: 1086293
// part 2: 366028
