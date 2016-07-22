require "#{File.expand_path File.dirname(__FILE__)}/parser"
require "#{File.expand_path File.dirname(__FILE__)}/code_writer"

class Main
  attr_accessor :path_name, :parser, :symbol_table

  def initialize(file_name = nil)
    @path_name = file_name
    run
  end

  def run
    parser = Parser.new(path_name)
    code_writer = CodeWriter.new(output_file)

    while parser.advance
      if [:arithmetic].include?(parser.command_type)
        code_writer.write_arithmetic(parser.command)
      elsif [:push, :pop].include?(parser.command_type)
        code_writer.write_push_pop(parser.command, parser.arg1, parser.arg2)
      end
    end

    code_writer.close
  end

  def output_file
    @file ||= File.open("#{File.join(File.dirname(path_name), File.basename(path_name, File.extname(path_name)))}.asm", "w+")
  end
end

Main.new(ARGV[0])