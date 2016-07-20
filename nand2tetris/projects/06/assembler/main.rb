require "#{File.expand_path File.dirname(__FILE__)}/parser"
require "#{File.expand_path File.dirname(__FILE__)}/symbol_table"

# Main.new("/Users/edwardweng/Code/recurse_center/nand2tetris/projects/06/pong/Pong.asm")
# Code can also be run via the command line `ruby main.rb FILENAME`

class Main
  attr_accessor :path_name, :parser, :symbol_table

  def initialize(file_name=nil)
    @path_name = ARGV[0] || file_name
    @symbol_table = SymbolTable.new

    populate_symbol_table
    run
  end

  def populate_symbol_table
    parser = Parser.new(path_name)

    while parser.advance
      if parser.l_command?
        symbol_table.add_entry(parser.symbol, parser.current_line_idx)
      end
    end
  end

  def run
    parser = Parser.new(path_name, symbol_table)
    # overwrite old files
    File.open("#{File.join(File.dirname(path_name), File.basename(path_name, File.extname(path_name)))}.hack", "w+") do |f|
      while parser.advance
        f << "#{parser.generate_machine_code}\n" if parser.generate_machine_code
      end
    end
  end
end