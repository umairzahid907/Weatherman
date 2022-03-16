$LOAD_PATH << '.'
require "get_data"
require "display_data"

def split_data(month)
  month = month.split('-')
  month[1] = $months[month[1].to_i - 1]
  month.drop(0)
  return [month[1], month[2]]
end

$months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
]
avg_temp_index = 2
max_temp_index = 1
min_temp_index = 3
max_humid_index = 7
avg_humid_index = 8
# getting input from user
input = gets
input = input.chomp.split(' ')
path = input[2]

s_input = input[1].split('/')
year = s_input[0]
month = $months[s_input[1].to_i - 1]

case input[0]
when '-e'
  max_temp = []
  min_temp = []
  max_humid = []
  $months.each do |month|
    max_t = Get_data::max_data(year, month, path, max_temp_index)
    min_t = Get_data::max_data(year, month, path, min_temp_index)
    max_h = Get_data::max_data(year, month, path, max_humid_index)
    max_temp << max_t unless max_t.nil?
    min_temp << min_t unless min_t.nil?
    max_humid << max_h unless max_h.nil?
  end
  max_temp = max_temp.max_by { |a| a[0] }
  min_temp = min_temp.max_by { |a| a[0] }
  max_humid = max_humid.max_by { |a| a[0] }

  max_temp[1] = split_data(max_temp[1])
  min_temp[1] = split_data(min_temp[1])
  max_humid[1] = split_data(max_humid[1])

  Display_data::year(max_temp.flatten, min_temp.flatten, max_humid.flatten)

when '-a'
  avg_t = Get_data::array_data(year, month, path, avg_temp_index)
  max_avg = avg_t.max
  min_avg = avg_t.min
  avg_humid = Get_data::avg_data(year, month, path, avg_humid_index)
  Display_data::month(max_avg, min_avg, avg_humid, month, year)

when '-c'
  max_temp_array = Get_data::array_data(year, month, path, max_temp_index)
  min_temp_array = Get_data::array_data(year, month, path, min_temp_index)
  Display_data::colorize(max_temp_array, min_temp_array, month, year)
else
  puts 'Invalid input'
end
