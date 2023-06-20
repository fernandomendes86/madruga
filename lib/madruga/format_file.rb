module Madruga
  # Main class
  class FormatFile
    attr_accessor :file_path, :beginning_column

    def initialize(file_path, beginning_column)
      @file_path = file_path
      @beginning_column = beginning_column
    end

    def self.perform(file_path, beginning_column = 0)
      new(file_path, beginning_column).format_and_save
      "Formatted File"
    rescue StandardError
      "File not found or not save!"
    end

    def format_and_save
      temp_file = new_format_to_temp
      File.rename(temp_file.path, file_path)
      temp_file.close
    end

    def new_format_to_temp
      @temp_file = File.open("#{File.dirname(file_path)}/temp.txt", "w")
      File.foreach(file_path) do |line|
        remove_columns(line)
      end
      @temp_file
    end

    def remove_columns(line)
      text = line[beginning_column..-1].strip
      @temp_file.puts(text)
    end
  end
end