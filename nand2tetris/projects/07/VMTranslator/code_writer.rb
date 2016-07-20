class CodeWriter
  attr_accessor :stack_pointer, :file

  def initialize(file)
    @file = file
    @stack_pointer = StackPointer.new
  end

  def set_file_name(file_name)
    # no-op for now
  end

  def write_arithmetic(command)
    if command == "add"
      file << add_or_subtract("+")
    elsif command == "sub"
      file << add_or_subtract("-")
    end
    file << "\n"
  end

  def write_push_pop(command_symbol, segment, index)
    if segment == "constant"
      file << push_constant(index)
    end
    file << "\n"
  end

  def close
    file.close
  end

  private

  def push_constant(value)
    [
      "@#{value}",
      "D = A",
      "#{stack_pointer.push}",
      "M = D"
    ].join("\n")
  end

  def add_or_subtract(symbol)
    [
      "#{stack_pointer.pop}",
      "D = M",
      "#{stack_pointer.pop}",
      "M = D #{symbol} M",
    ].join("\n")
  end

  class StackPointer
    INITIAL_ADDRESS = 256
    attr_accessor :address

    def initialize
      @address = INITIAL_ADDRESS
    end

    def print
      [
        "@#{address}"
      ].join("\n")
    end

    def pop
      self.address -= 1
      print
    end

    def push
      print.tap do
        self.address += 1
      end
    end
  end
end