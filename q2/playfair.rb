STDOUT.sync = true

class Playfair
	def initialize(key, cipher)
		@cipher = cipher
		createKeyTable(key)
		@pairs = @cipher.scan(/.{2}/)
	end

	def decryptText 
		string = ""
		@pairs.each do |pair|
			string += translatePair(pair)
		end
		return string
	end

	def translatePair(pairing)
		posChar1 = lookupCharacterPosition(pairing[0])
		posChar2 = lookupCharacterPosition(pairing[1])

		if(posChar1[0] == posChar2[0])
			if(posChar1[1] == posChar2[1])
				puts "ERROR"
				exit
			end
			return pairRowShift(pairing)
		elsif(posChar1[1] == posChar2[1])
			return pairColShift(pairing)
		else
			return pairRectShift(pairing)
		end
	end

	def pairRowShift(pairing)
		posChar1 = lookupCharacterPosition(pairing[0])
		posChar2 = lookupCharacterPosition(pairing[1])

		return @keyTable[posChar1[0]][(posChar1[1] - 1)%5] + @keyTable[posChar2[0]][(posChar2[1] - 1)%5]
	end

	def pairColShift(pairing)
		posChar1 = lookupCharacterPosition(pairing[0])
		posChar2 = lookupCharacterPosition(pairing[1])

		return @keyTable[(posChar1[0] - 1)%5][posChar1[1]] + @keyTable[(posChar2[0] - 1)%5][posChar2[1]]
	end

	def pairRectShift(pairing)
		posChar1 = lookupCharacterPosition(pairing[0])
		posChar2 = lookupCharacterPosition(pairing[1])

		return @keyTable[posChar1[0]][posChar2[1]] + @keyTable[posChar2[0]][posChar1[1]]
	end

	def lookupCharacterPosition(char)
		for i in 0..4
			for j in 0..4
				if(char == @keyTable[i][j])
					return [i,j]
				end
			end
		end
	end

	def replaceTable(table)
		@keyTable = table
	end

	def changeKeyTable
		randNum = rand(0..50)
		case randNum
		when 0
			diagFlip
		when 1
			vertFlip
		when 2
			horzFlip
		when 3
			rowSwap
		when 4
			colSwap
		else
			letterSwap
		end
	end

	def diagFlip
		for i in 0..4
			for j in i..4
				char1 = @keyTable[i][j]
				char2 = @keyTable[j][i]
				@keyTable[j][i] = char1
				@keyTable[i][j] = char2
			end
		end
	end

	def vertFlip
		for j in 0..4
			for i in 0..1
				if(i == 0)
					char1 = @keyTable[0][j]
					char2 = @keyTable[4][j]
					@keyTable[4][j] = char1
					@keyTable[0][j] = char2
				elsif(i == 1)
					char1 = @keyTable[1][j]
					char2 = @keyTable[3][j]
					@keyTable[3][j] = char1
					@keyTable[1][j] = char2
				end
			end
		end
	end

	def horzFlip
		for i in 0..4
			@keyTable[i] = @keyTable[i].reverse
		end
	end

	def rowSwap
		randRow1 = rand(0..4)
		randRow2 = rand(0..4)
		while(randRow1 == randRow2)
			randRow2 = rand(0..4)
		end

		rowOne = @keyTable[randRow1]
		rowTwo = @keyTable[randRow2]

		@keyTable[randRow2] = rowOne
		@keyTable[randRow1] = rowTwo
 	end

	def colSwap
		randCol1 = rand(0..4)
		randCol2 = rand(0..4)
		while(randCol1 == randCol2)
			randCol2 = rand(0..4)
		end

		for i in 0..4
			char1 = @keyTable[i][randCol1]
			char2 = @keyTable[i][randCol2]

			@keyTable[i][randCol1] = char2
			@keyTable[i][randCol2] = char1 
		end
 	end

 	def letterSwap
 		char1 = [rand(0..4), rand(0..4)]
 		char2 = [rand(0..4), rand(0..4)]
 		while(char1 == char2)
 			char2 = [rand(0..4), rand(0..4)]
 		end

 		tempChar1 = @keyTable[char1[0]][char1[1]]
 		tempChar2 = @keyTable[char2[0]][char2[1]]

 		@keyTable[char2[0]][char2[1]] = tempChar1
 		@keyTable[char1[0]][char1[1]] = tempChar2
 	end

	def createKeyTable(key)
		tempKey = key.dup
		tempKey.split
		keyLength = tempKey.length
		count = 0
		puts "Creating Key Table"

		@keyTable = Array.new(5){Array.new(5)}
		letters = [*('A'..'Z')] -['J']

		for i in 0..4 
			for j in 0..4
				if(count < keyLength)
					@keyTable[i][j] = tempKey[count]
					letters = letters - [tempKey[count]]
					count += 1
				else
					@keyTable[i][j] = letters[0]
					letters = letters - [letters[0]]
				end
			end
		end
	end

	def printKeyTable
		for i in 0..4
			for j in 0..4
				print @keyTable[i][j] + " "
			end
			puts ""
		end
	end

	attr_reader :keyTable
end


#file = File.read("cipher2.txt")
#playfair = Playfair.new("ABC", file)
#playfair.diagFlip
#playfair.vertFlip
#playfair.horzFlip
#playfair.rowSwap
#playfair.colSwap
#playfair.letterSwap
#puts playfair.pairRowShift("AC")
#puts playfair.pairColShift("AC")
#puts playfair.pairRectShift("RY")
#playfair.printKeyTable