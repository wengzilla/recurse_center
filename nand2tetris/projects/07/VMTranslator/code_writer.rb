class CodeWriter
  FALSE = 0
  TRUE = -1
  UNARY_OPERATORS = {:not => "!", :neg => "-"}
  ARITHMETIC_OPERATORS = {:and => "&", :or => "|", :add => "+", :sub => "-"}

  attr_accessor :stack_pointer, :file, :write_counter

  def initialize(file)
    @file = file
    @stack_pointer = StackPointer.new
    @write_counter = 0
    set_up_stack_pointer
  end

  def set_file_name(file_name)
    # no-op for now
  end

  def set_up_stack_pointer
    file << stack_pointer.initialize_sp
    file << "\n"
  end

  def write_arithmetic(command)
    file << send(command.to_sym)
    file << "\n"
    self.write_counter += 1
  end

  def write_push_pop(command, segment, index)
    if segment == "constant"
      file << push_constant_on_stack(index)
    else
      if command == "push"
        file << push_on_stack(segment, index)
      elsif command == "pop"
        file << pop_off_stack(segment, index)
      end
    end
    file << "\n"
  end

  def close
    file.close
  end

  private

  def push_on_stack(segment, index)
    [
      stack_pointer.set_address(segment, index),
      "D = M",
      stack_pointer.push
    ].join("\n")
  end

  def pop_off_stack(segment, index)
    [
      stack_pointer.pop,
      stack_pointer.set_address(segment, index),
      "M = D"
    ].join("\n")
  end

  [:eq, :lt, :gt].each do |name|
    define_method name do
      comparison_operator(name)
    end
  end

  [:neg, :not].each do |name|
    define_method name do
      unary_operator(name)
    end
  end

  [:and, :or, :add, :sub].each do |name|
    define_method name do
      arithmetic_operator(name)
    end
  end

  def unary_operator(name)
    [
      "#{stack_pointer.pop}",
      "D = #{UNARY_OPERATORS[name]}M",
      "#{stack_pointer.push}"
    ].join("\n")
  end

  def arithmetic_operator(name)
    [
      fetch_args_from_stack,
      "D = M #{ARITHMETIC_OPERATORS[name]} D",
      "#{stack_pointer.push}"
    ].join("\n")
  end

  def comparison_operator(name)
    [
      fetch_args_from_stack,
      "D = M - D",
      "@IF_TRUE_#{write_counter}",
      "D; J#{name.upcase}",
      "D = #{FALSE}",
      "@END_#{write_counter}",
      "0; JMP",
      "(IF_TRUE_#{write_counter})",
      "D = #{TRUE}",
      "(END_#{write_counter})",
      "#{stack_pointer.push}"
    ].join("\n")
  end

  def fetch_args_from_stack # places one arg in D, and then another arg in M
    [
      "#{stack_pointer.pop}",
      "D = M",
      "#{stack_pointer.pop}"
    ].join("\n")
  end

  def push_constant_on_stack(value)
    [
      "@#{value}",
      "D = A",
      "#{stack_pointer.push}"
    ].join("\n")
  end

  class StackPointer
    INITIAL_ADDRESS = 256
    SEGMENT_MAP = {"local" => "@LCL", "argument" => "@ARG", "this" => "@THIS", "that" => "@THAT", "temp" => 5, "static" => 16, "pointer" => 3}
    ADDRESS_MAP = {"temp" => "@5", "static" => "@16", "pointer" => "@3"}

    attr_accessor :address

    def initialize
      @address = INITIAL_ADDRESS
    end

    def initialize_sp
      [
        "@#{address}",
        "D = A",
        "@SP",
        "M = D"
      ].join("\n")
    end

    def pop
      [
        "@SP",
        "M = M - 1",
        "A = M"
      ].join("\n")
    end

    def push
      # make sure D is set before calling print_push
      [
        "@SP",
        "M = M + 1",
        "A = M - 1",
        "M = D"
      ].join("\n")
    end

    def set_address(segment, index)
      [
        "#{SEGMENT_MAP}"
      ]
    end

    def add_zero(index)
      if index == 0
        "A = M"
      else
        "A = M + #{index}"
      end
    end
  end
end