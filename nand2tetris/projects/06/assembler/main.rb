require "#{File.expand_path File.dirname(__FILE__)}/parser"

class Main
  attr_accessor :path_name

  def initialize(file_name)
    @path_name = ARGV[0] || file_name
    run
  end

  def run
    # overwrite old files
    File.open("#{File.join(File.dirname(path_name), File.basename(path_name, File.extname(path_name)))}.hack", "w+") do |f|
      parser = Parser.new(path_name)
      
      while parser.advance
        puts parser.command if parser.generate_machine_code.nil?
        f << "#{parser.generate_machine_code}\n"
      end
    end
  end
end

Main.new("/Users/edwardweng/Code/recurse_center/nand2tetris/projects/06/pong/PongL.asm")