module Display
  module Year
    def self.display(max_temp, min_temp, max_humid, months)
      s_day = max_temp[1].split("-")
      month = months[s_day[1].to_i-1]
      day = s_day[2]
      puts "\nHighest: #{max_temp[0]}C on #{month} #{day}"
      s_day = min_temp[1].split("-")
      month = months[s_day[1].to_i-1]
      day = s_day[2]
      puts "Lowest: #{min_temp[0]}C on #{month} #{day}"
      s_day = max_humid[1].split("-")
      month = months[s_day[1].to_i-1]
      day = s_day[2]
      puts "Humid: #{max_humid[0]}% on #{month} #{day}"
    end
  end

  module Month
    def self.display(max_avg_temp, min_avg_temp, avg_humid, year, month)
      puts "\n#{month} #{year}"
      puts "Highest Average: #{max_avg_temp}C"
      puts "Lowest Average: #{min_avg_temp}C"
      puts "Average Humidity: #{avg_humid}%"
    end
  end
end
