module Readfile
  def self.read_file(year, month, path)

    file_path = File.join path, path.split("/")[-1] + "_" + year + "_" + month.slice(0..2)
    filename = file_path + ".txt"
    if !File.exists?(filename)
      return nil
    else
      file = File.open(filename , "r")
      return file
    end
  end
end
