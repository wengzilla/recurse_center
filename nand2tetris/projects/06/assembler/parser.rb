require "#{File.expand_path File.dirname(__FILE__)}/code"

class Parser
  attr_accessor :file, :current_line_idx, :current_line, :symbol_table

  def initialize(path_name, symbol_table = {})
    @file = File.open(path_name)
    @current_line_idx = 0
    @symbol_table = symbol_table
  end

  def advance
    self.current_line = cleaned_next_line
    if current_line && (comment? || white_space?)
      advance
    elsif current_line && (a_command? || c_command?)
      self.current_line_idx += 1
    end
    current_line
  end

  def generate_machine_code
    if a_command?
      translate_a_command
    elsif c_command?
      translate_c_command
    end
  end

  def l_command?
    current_line[0] == "("
  end

  def rewind
    file.rewind
  end

  def symbol
    if l_command?
      current_line.gsub(/[\(\)]/,"")
    elsif a_command?
      current_line.gsub(/@/, "")
    end
  end

  private

  def translate_a_command
    if memory_address?
      symbol.to_i.to_s(2).rjust(16, "0")
    else
      translate_symbol.to_s(2).rjust(16, "0")
    end
  end

  def translate_symbol
    if symbol_table.contains?(symbol)
      symbol_table.get_address(symbol)
    else
      symbol_table.add_variable(symbol)
    end
  end

  def translate_c_command
    "111#{Code.comp(comp)}#{Code.dest(dest)}#{Code.jump(jump)}"
  end

  def cleaned_next_line
    line = file.gets
    line.chomp.gsub("\W", "") if line
  end

  def comment?
    # returns true/false if current_line is comment
    !!current_line.match("^\/\/")
  end

  def white_space?
    # returns true/false if current_line is blank
    current_line.length.zero?
  end

  def comp
    if dest
      match = current_line.match("=([^;]+);*")
    else
      match = current_line.match("^([^;]+);*")
    end
    match[1].to_s unless match.nil?
  end

  def dest
    match = current_line.match("^([^;]+)=+")
    match[1].to_s unless match.nil?
  end

  def jump
    match = current_line.match(";(.*)$")
    match[1].to_s unless match.nil?
  end

  def a_command?
    current_line[0] == "@"
  end

  def c_command?
    !a_command? && !l_command?
  end

  def memory_address?
    !!current_line.match(/^@[0-9]+$/)
  end
end