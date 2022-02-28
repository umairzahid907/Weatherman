require_relative 'Readfile'
require_relative 'Display'

module For_month
  def self.for_month(year, month, path, months)
    max_avg_temp = -Float::INFINITY
    min_avg_temp = Float::INFINITY
    avg_humid = 0
    count = 0
    month = months[month.to_i-1].to_s

    file = Readfile.read_file(year, month, path)
    if !file.nil?
      file.readlines.drop(1).each do |line|
        sline = line.split(",")
        if (!sline[2].nil?) && (max_avg_temp < sline[2].to_i)
          max_avg_temp = sline[2].to_i
        end

        if (!sline[4].nil?) && (min_avg_temp > sline[4].to_i)
          min_avg_temp = sline[4].to_i
        end
        if !sline[8].nil?
          avg_humid = avg_humid + sline[8].to_i
          count += 1
        end
      end
      include Display
      Display::Month.display(max_avg_temp, min_avg_temp, avg_humid, year, month)
    end
  end
end
