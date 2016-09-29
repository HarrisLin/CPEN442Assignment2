require_relative 'playfair'
require_relative 'scoring'

class Break
	def initialize
		@count = 0
		@cipher = File.read("cipher2.txt")
		@temp = 10 + 0.087*(@cipher.length - 84)
		@key = makeKey
		@playfair = Playfair.new(@key, @cipher)
		@scoring = Score.new
		@parentScore = -(Float::INFINITY)
		@childScore = -(Float::INFINITY)
		solve
	end

	def solve
		while(true)
			plaintext = @playfair.decryptText
			@childScore = @scoring.scoreString(plaintext)

			if @childScore >= @parentScore
				@parentScore = @childScore
				@bestKeyTable = @playfair.keyTable
			else
				random_num = rand()
				probability = 1.0/(Math::E**(@parentScore - @childScore)/@temp)
				if probability >= random_num
					@parentScore = @childScore
					@bestKeyTable = @playfair.keyTable
				else
					@playfair.replaceTable(@bestKeyTable)
				end
			end

			if((@count % 200) == 0)
				puts "current key"
				puts @bestKeyTable
				puts "plain text"
				puts @playfair.decryptText
				puts "Current score"
				puts @parentScore
			end 
			@playfair.changeKeyTable
			@count += 1
			if(@count == 50000)
				break
			end
		end
	end

	def makeKey
		key = ""
		letters = "ABCDEFGHIKLMNOPQRSTUVWXYZ"
		while !letters.empty?
			random = rand(0..(letters.length-1))
			key << letters.slice!(random)
		end
		return key
	end
end

Solver = Break.new