require 'zlib'
require 'securerandom'

studentNumMD5 = 'd334c797050bfe3d8a9233f49cb27e07'

studentCRC = Zlib::crc32(studentNumMD5)

attempts = 0

while (true) do
	random_string = SecureRandom.hex
	crc = Zlib::crc32(random_string)
	attempts += 1
	if((attempts % 100000) == 0)
		puts attempts
	end
	if(crc == studentCRC)
		break
	end
end

puts "The Student MD5 Hash: " + studentNumMD5
puts "The Student CRC: " + studentCRC.to_s
puts "The random string: " + random_string
puts "The crc: " + crc.to_s

puts "# of attempts: " + attempts.to_s

#d0145cbd4cc598012d35cc94c8117ca1