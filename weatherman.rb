require 'colorize'

def read_file(year, month, path)

  file_path = File.join path, path.split("/")[-1] + "_" + year + "_" + month.slice(0..2)
  filename = file_path + ".txt"
  if !File.exists?(filename)
    return nil
  else
    file = File.open(filename , "r")
    return file
  end
end


def max_data(year, path)

  max_temp = -$infinity
  lowest_temp = $infinity
  max_humid = -$infinity
  max_temp_day = nil
  lowest_temp_day = nil
  max_humid_day = nil

  $months.each do |month|
    file = read_file(year, month, path)
    if !file.nil?
      file.readlines.drop(1).each do |line|
        sline = line.split(",")
        # because max temp is stored at index 2 in file
        if (!sline[1].nil?) && (max_temp < sline[1].to_i)
          max_temp = sline[1].to_i
          max_temp_day = sline[0]
        end
        # lowest temp is stored at index 3 in file
        if (!sline[3].nil?) && (lowest_temp > sline[3].to_i)
          lowest_temp = sline[3].to_i
          lowest_temp_day = sline[0]
        end
        # max humidity is stored at
        if (!sline[7].nil?) && (max_humid < sline[7].to_i)
          max_humid = sline[7].to_i
          max_humid_day = sline[0]
        end
      end
    end
  end

  if !max_temp_day.nil?
    s_day = max_temp_day.split("-")
    month = $months[s_day[1].to_i-1]
    day = s_day[2]
    puts "\nHighest: #{max_temp}C on #{month} #{day}"
    s_day = lowest_temp_day.split("-")
    month = $months[s_day[1].to_i-1]
    day = s_day[2]
    puts "Lowest: #{lowest_temp}C on #{month} #{day}"
    s_day = max_humid_day.split("-")
    month = $months[s_day[1].to_i-1]
    day = s_day[2]
    puts "Humid: #{max_humid}% on #{month} #{day}"
  else
    puts "\nData related to year #{year} does not exist in given location."
  end
end


def avg_data(year, month, path)
  max_avg_temp = -$infinity
  lowest_avg_temp = $infinity
  avg_humid = 0
  count = 0
  month = $months[month.to_i-1].to_s

  file = read_file(year, month, path)
  if !file.nil?
    file.readlines.drop(1).each do |line|
      sline = line.split(",")
      if (!sline[2].nil?) && (max_avg_temp < sline[2].to_i)
        max_avg_temp = sline[2].to_i
      end

      if (!sline[4].nil?) && (lowest_avg_temp > sline[4].to_i)
        lowest_avg_temp = sline[4].to_i
      end
      if !sline[8].nil?
        avg_humid = avg_humid + sline[8].to_i
        count += 1
      end
    end
  end
  avg_humid = avg_humid/count
  puts "\n#{month} #{year}"
  puts "Highest Average: #{max_avg_temp}C"
  puts "Lowest Average: #{lowest_avg_temp}C"
  puts "Average Humidity: #{avg_humid}%"
end


def colorize_output(year, month, path)
  max_temp = 0
  lowest_temp = 0
  month = $months[month.to_i-1].to_s

  file = read_file(year, month, path)
  if !file.nil?
    puts "\n#{year} #{month}"
    file.readlines.drop(1).each_with_index do |line, index|
      sline = line.split(",")
      max_temp = sline[1]
      lowest_temp = sline[3]
      str_out_red = ("+"*max_temp.to_i).red
      str_out_blue = ("+"*lowest_temp.to_i).blue

      puts "\n%02d #{str_out_red} #{max_temp}C" % (index + 1) if !max_temp.nil?
      puts "%02d #{str_out_blue} #{lowest_temp}C" % (index + 1) if !lowest_temp.nil?
      # printing on same line for bonus task
      if !max_temp.nil? && !lowest_temp.nil?
        puts "\tor"
        puts "%02d #{str_out_blue}#{str_out_red} #{lowest_temp}C-#{max_temp}C" % (index + 1)
      end
    end
  end
end



$infinity = Float::INFINITY #global_variable
#global_months data
$months = [
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

max_data(input[1], path) if input[0] == "-e"

s_input = input[1].split("/")
year = s_input[0]
month = s_input[1]

avg_data(year, month, path) if input[0] == "-a"
colorize_output(year, month, path) if input[0] == "-c"
