module Get_data
  # Funtion to read the file
  def self.read_file(year, month, path)
    file_path = File.join path, path.split('/')[-1] + '_' + year + '_' + month.slice(0..2)
    filename = file_path + '.txt'
    if !File.exists?(filename)
      return nil
    else
      file = File.open(filename , 'r')
      return file
    end
  end
  # Function to get array of data from specific index
  def self.array_data(year, month, path, index)
    array = []
    file = read_file(year, month, path)

    if !file.nil?
      file.readlines.drop(1).each do |line|
        s_line = line.split(',')
        if (!s_line[index].nil? && s_line[index].count("a-zA-Z") == 0)
          array << s_line[index].to_i
        end
      end
      return array
    else
      return nil
    end
  end
  # Funtion to get max data from a specific index
  def self.max_data(year, month, path, index)
    max_data = -Float::INFINITY
    day = nil
    file = read_file(year, month, path)

    if !file.nil?
      file.readlines.drop(1).each do |line|
        s_line = line.split(',')
        data = s_line[index].to_i
        if (!s_line[index].nil?) && (max_data < data)
          max_data = data
          day = s_line[0]
        end
      end
      return [max_data, day]
    else
      return nil
    end
  end
  # Function to get avg data from index
  def self.avg_data(year, month, path, index)
    array = array_data(year, month, path, index)
    data = array.inject(0){|sum,x| sum + x }
    return data/array.length
  end
end
