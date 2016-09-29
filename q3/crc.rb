require 'zlib'
require 'securerandom'

mapping = Hash.new

random_string = SecureRandom.hex
crc = Zlib::crc32(random_string)
attempts = 0

while (true) do
	random_string = SecureRandom.hex
	crc = Zlib::crc32(random_string)
	attempts += 1
	if(mapping[crc] != nil)
		break
	end
	mapping[crc] = random_string
end

puts "First string: " + mapping[crc]
puts "First CRC: " + crc.to_s

puts "Second string: " + random_string
puts "Second CRC: " + Zlib::crc32(random_string).to_s

puts "# of attempts: " + attempts.to_s