require 'colorize'
require_relative 'Readfile'

module Colorize_output
  def self.simple(year, month, path)
    include Readfile
    max_temp = 0
    lowest_temp = 0
    file = Readfile.read_file(year, month, path)

    if !file.nil?
      puts "\n#{year} #{month}"
      file.readlines.drop(1).each_with_index do |line, index|
        sline = line.split(",")
        max_temp = sline[1]
        lowest_temp = sline[3]
        str_out_red = ("+"*max_temp.to_i).red
        str_out_blue = ("+"*lowest_temp.to_i).blue
        puts "\n%02d #{str_out_red} #{max_temp}C" % (index + 1) if !max_temp.empty?
        puts "%02d #{str_out_blue} #{lowest_temp}C" % (index + 1) if !lowest_temp.empty?
      end
    end
  end

  def self.bonus(year, month, path)
    include Readfile
    max_temp = 0
    min_temp = 0
    file = Readfile.read_file(year, month, path)
    if !file.nil?
      puts "\n#{year} #{month}"
      file.readlines.drop(1).each_with_index do |line, index|
        sline = line.split(",")
        max_temp = sline[1]
        min_temp = sline[3]
        str_out_red = ("+"*max_temp.to_i).red
        str_out_blue = ("+"*min_temp.to_i).blue
        if !max_temp.empty? && !min_temp.empty?
          puts "%02d #{str_out_blue}#{str_out_red} #{min_temp}C-#{max_temp}C" % (index + 1)
        end
      end
    end
  end
end
