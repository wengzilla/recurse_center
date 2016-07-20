class SymbolTable
  attr_accessor :symbol_table, :variable_counter
  STARTING_POSITION = 16 # magic number specified by Hack specs

  def initialize
    @symbol_table = {
      "SP" => 0,
      "LCL" => 1,
      "ARG" => 2,
      "THIS" => 3,
      "THAT" => 4,
      "SCREEN" => 16384,
      "KBD" => 24576
    }
    add_registers
    @variable_counter = STARTING_POSITION
  end

  def add_entry(symbol, address)
    symbol_table[symbol] = address
  end

  def add_variable(symbol)
    add_entry(symbol, variable_counter)
    self.variable_counter += 1
    get_address(symbol)
  end

  def contains?(symbol)
    symbol_table.has_key?(symbol)
  end

  def get_address(symbol)
    symbol_table[symbol]
  end

  private

  def add_registers
    (0..15).each do |i|
      add_entry("R#{i}", i)
    end
  end
end