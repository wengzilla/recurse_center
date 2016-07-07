require './grid'

# https://www.hackerrank.com/challenges/connected-cell-in-a-grid

# 1. Figure out which cells have 1s and put them into a unchecked list
# 2. Run a DFS/BFS from a cell with a 1 and move connected cells from unchecked list to group
# 3. Find largest group

class ConnectionSearcher
  attr_accessor :groups, :grid

  def initialize(grid, num_rows, num_cols)
    @grid = Grid.new(grid, num_rows, num_cols)
    @groups = []
    find_groups
  end

  def find_largest_region
    groups.map{ |group| group.length }.max
  end

  private

  def find_groups
    unchecked_list = grid.one_cells

    while unchecked_list.length > 0
      stack = [unchecked_list.first] # take first element off of unchecked list and put it onto the stack
      current_group = []

      while stack.length > 0
        current_node = stack.pop
        current_group << unchecked_list.delete(current_node)
        stack += grid.neighboring_cells(current_node).select{ |cell| unchecked_list.index(cell) }
      end
      self.groups << current_group.compact
    end
  end
end

m = STDIN.gets.to_i # number of rows
n = STDIN.gets.to_i # number of columns

grid = []
(0...m).each do |row_idx|
  grid += STDIN.gets.chomp.split(" ")
end

puts ConnectionSearcher.new(grid, m, n).find_largest_region