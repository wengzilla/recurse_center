class Grid
  attr_accessor :grid, :num_rows, :num_cols

  def initialize(grid, num_rows, num_cols)
    @grid = grid
    @num_rows = num_rows
    @num_cols = num_cols
  end

  def one_cells
    grid.map.with_index { |cell, idx| cell == "1" ? idx : nil }.compact
  end

  def neighboring_cells(cell)
    neighbors = []
    
    unless is_top?(cell)
      neighbors << cell - num_cols - 1 unless is_left?(cell)
      neighbors << cell - num_cols
      neighbors << cell - num_cols + 1 unless is_right?(cell)
    end

    neighbors << cell - 1 unless is_left?(cell)
    neighbors << cell + 1 unless is_right?(cell)

    unless is_bottom?(cell)
      neighbors << cell + num_cols - 1 unless is_left?(cell)
      neighbors << cell + num_cols
      neighbors << cell + num_cols + 1 unless is_right?(cell)
    end

    neighbors
  end

  private

  def is_top?(cell)
    cell / num_cols == 0
  end

  def is_left?(cell)
    cell % num_cols == 0
  end

  def is_bottom?(cell)
    cell / num_cols == num_rows - 1
  end

  def is_right?(cell)
    cell % num_cols == num_cols - 1
  end
end