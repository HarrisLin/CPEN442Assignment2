STDOUT.sync = true
class Score
	def initialize
		@lookupHash = Hash.new
		@total = 0
		loadQuadgrams
	end

	def loadQuadgrams
		File.open("english_quadgrams.txt", "r").each_line do |line|
			info = line.split(" ")
			@lookupHash[info[0]] = info[1]
			@total += info[1].to_i
		end
	end

	def scoreString(string)
		@finalScore = 0.0
		@quadScore = 0.0
		tetgrams = findTetgrams(string)
		tetgrams.each do |quad|
			if @lookupHash.has_key?(quad)
				num = @lookupHash[quad].to_f/@total.to_f
				@quadScore = Math.log(num)
			else
				num = 0.01/@total.to_f
				@quadScore = Math.log(num)
			end
			@finalScore += @quadScore
		end

		return @finalScore
	end

	def findTetgrams(string)
		@tetgrams = Array.new
		for i in 0..(string.length - 4)
			temp = string.dup
			@tetgrams.push(temp[i.. i + 3])
		end
		return @tetgrams
	end

	attr_reader :tetgrams
	attr_reader :total
end

#score = Score.new
#array = score.findTetgrams("ATTACKONDDUCKS")
#puts score.scoreString("AAAA")
#puts score.tetgrams
#puts score.total