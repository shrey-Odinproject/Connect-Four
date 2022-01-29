# frozen_string_literal:true

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def win?
    check_rows || check_columns || check_diagonals
  end

  def full?
    (grid.flatten - [nil]).length == 42
  end

  def edit_grid(col, sym)
    depth = 5
    while depth >= 0
      if grid[depth][col].nil?
        grid[depth][col] = sym
        return
      else
        depth -= 1
      end
    end

    puts 'Overflow !!!'
  end

  def show
    print ' 0  1  2  3  4  5  6 '
    puts
    grid.each do |row|
      row.each do |elm|
        print " #{elm} "
      end
      puts
    end
  end

  def full_column?(input)
    @grid[0][input] != nil
  end

  private

  def consecutive_4?(array)
    # we pass different arrays to it to check if they have 4 consecutive symbols
    array.each_cons(4).any? do |sub_arr|
      all_equal?(sub_arr)
    end
  end

  def all_equal?(arr)
    arr.uniq.size <= 1 && arr.uniq != [nil]
    # win cond is true as all elm are nil so 4 consecutive nils happens
    # everywhere and we dont want that so we dont conisder nil
  end

  def check_rows
    grid.any? do |row|
      consecutive_4?(row)
    end
  end

  def check_columns
    grid.transpose.any? do |col|
      consecutive_4?(col)
    end
  end

  def check_diagonals
    # pd go frm botttom to top
    pd1 = [grid[3][0], grid[2][1], grid[1][2], grid[0][3]]
    pd2 = [grid[4][0], grid[3][1], grid[2][2], grid[1][3], grid[0][4]]
    pd3 = [grid[5][0], grid[4][1], grid[3][2], grid[2][3], grid[1][4], grid[0][5]]
    pd4 = [grid[5][1], grid[4][2], grid[3][3], grid[2][4], grid[1][5], grid[0][6]]
    pd5 = [grid[5][2], grid[4][3], grid[3][4], grid[2][5], grid[1][6]]
    pd6 = [grid[5][3], grid[4][4], grid[3][5], grid[2][6]]
    # sd go from top to bottom
    sd1 = [grid[2][0], grid[3][1], grid[4][2], grid[5][3]]
    sd2 = [grid[1][0], grid[2][1], grid[3][2], grid[4][3], grid[5][4]]
    sd3 = [grid[0][0], grid[1][1], grid[2][2], grid[3][3], grid[4][4], grid[5][5]]
    sd4 = [grid[0][1], grid[1][2], grid[2][3], grid[3][4], grid[4][5], grid[5][6]]
    sd5 = [grid[0][2], grid[1][3], grid[2][4], grid[3][5], grid[4][6]]
    sd6 = [grid[0][3], grid[1][4], grid[2][5], grid[3][6]]

    d = [pd1, pd2, pd3, pd4, pd5, pd6, sd1, sd2, sd3, sd4, sd5, sd6]

    d.any? do |dia|
      consecutive_4?(dia)
    end
  end
end
