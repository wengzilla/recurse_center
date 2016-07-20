class Parser
  attr_accessor :file, :current_line_idx, :current_line, :symbol_table

  ARITHMETIC_COMMANDS = ["add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not"]

  def initialize(path_name)
    @file = File.open(path_name)
    @current_line = nil
  end

  def advance
    self.current_line = cleaned_next_line
    if current_line && (comment? || white_space?)
      advance
    end
    current_line
  end

  def command_type
    if ARITHMETIC_COMMANDS.include?(command)
      :arithmetic
    elsif command == "push"
      :push
    elsif command == "pop"
      :pop
    end
  end

  def command
    tokenized_line[0]
  end

  def arg1
    tokenized_line[1] || tokenized_line[0]
  end

  def arg2
    tokenized_line[2]
  end


  private

  def tokenized_line
    current_line.split(/ /)
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
end