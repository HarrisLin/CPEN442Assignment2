#!usr/bin/ruby -w

puts "hello world"

file = File.read("cipher.txt")

distribution = Hash.new

for letter in 'A'..'Z' do
	distribution[letter] = 0
end 

array = file.split("")
array.pop

array.each do |i|
	num = distribution[i]
	num += 1
	distribution[i] = num
end

puts distribution
puts ""

string = file.gsub(/[A]/, 'c')
string = string.gsub(/[B]/, 'g')
string = string.gsub(/[C]/, 'l')
string = string.gsub(/[D]/, 'n')
string = string.gsub(/[E]/, 'i')
#string = string.gsub(/[F]/, '')
string = string.gsub(/[G]/, 'x')
string = string.gsub(/[H]/, 'k')
string = string.gsub(/[I]/, 'w')
string = string.gsub(/[J]/, 'p')

#string = string.gsub(/[L]/, '')
string = string.gsub(/[M]/, 'u')
string = string.gsub(/[N]/, 'r')
string = string.gsub(/[O]/, 'h')
string = string.gsub(/[P]/, 'm')
string = string.gsub(/[Q]/, 'a')
string = string.gsub(/[R]/, 'e')
#string = string.gsub(/[S]/, '')
string = string.gsub(/[T]/, 'd')
string = string.gsub(/[U]/, 's')
string = string.gsub(/[V]/, 't')
string = string.gsub(/[W]/, 'b')
string = string.gsub(/[X]/, 'f')
string = string.gsub(/[Y]/, 'v')
string = string.gsub(/[Z]/, 'y')


string = string.gsub(/[K]/, 'o')
puts string
