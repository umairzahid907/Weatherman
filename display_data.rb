require 'colorize'

module Display_data
  # Display data for month
  def self.month(max, min, avg, month, year)
    puts "\n#{month} #{year}"
    puts "Highest Average: #{max}C"
    puts "Lowest Average: #{min}C"
    puts "Average Humidity: #{avg}%"
  end

  # Display for year
  def self.year(max_data, min_data, avg_data)
    puts "\nHighest: #{max_data[0]}C on #{max_data[1]} #{max_data[2]}"
    puts "Lowest: #{min_data[0]}C on #{min_data[1]} #{min_data[2]}"
    puts "Humid: #{avg_data[0]}% on #{avg_data[1]} #{avg_data[2]}"
  end

  # colorize output(min and max) on two lines
  def self.colorize(array_max, array_min, month, year)
    for i in (0..array_max.length-1)
      max_temp = array_max[i]
      min_temp = array_min[i]
      out_red = ('+' * max_temp).red
      out_blue = ('+' * min_temp).blue
      puts "\n%02d #{out_red} #{max_temp}C" % (i + 1)
      puts "%02d #{out_blue} #{min_temp}C" % (i + 1)

      # Display on same line for bonus task
      puts "\t Bonus task"
      puts "%02d #{out_blue}#{out_red} #{min_temp}C-#{max_temp}C" % (i + 1)
    end
  end

end
