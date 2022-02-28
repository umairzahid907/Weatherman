require_relative 'For_year'
require_relative 'For_month'
require_relative 'Colorize_output'
months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
]

input = gets
input = input.chomp.split(" ")
path = input[2]

s_input = input[1].split("/")
year = s_input[0]

if input[0] == '-e'
  include For_year
  For_year.for_year(year, months, path)
elsif input[0] == '-a'
  month = months[s_input[1].to_i-1]
  include For_month
  For_month.for_month(year, month, path, months)
elsif input[0] == '-c'
  month = months[s_input[1].to_i-1]
  include Colorize_output
  Colorize_output.simple(year, month, path)
  puts "\n \t BONUS TASK"
  Colorize_output.bonus(year, month, path)
else
  puts "Invalid input"
end
