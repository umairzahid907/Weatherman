require_relative 'Readfile'
require_relative 'Display'
module For_year
  def self.for_year(year, months, path)
    max_temp = -Float::INFINITY
    min_temp = Float::INFINITY
    max_humid = -Float::INFINITY
    max_temp_day = nil
    min_temp_day = nil
    max_humid_day = nil

    months.each do |month|
      include Readfile
      file = Readfile.read_file(year, month, path)
      if !file.nil?
        file.readlines.drop(1).each do |line|
          sline = line.split(",")
          # because max temp is stored at index 2 in file
          if (!sline[1].nil?) && (max_temp < sline[1].to_i)
            max_temp = sline[1].to_i
            max_temp_day = sline[0]
          end
          # lowest temp is stored at index 3 in file
          if (!sline[3].nil?) && (min_temp > sline[3].to_i)
            min_temp = sline[3].to_i
            min_temp_day = sline[0]
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
      include Display
      Display::Year.display([max_temp, max_temp_day],
        [min_temp, min_temp_day],
        [max_humid, max_humid_day],
        months)
    else
      puts "\nData related to year #{year} does not exist in given location."
    end
  end
end
