class Player

  attr_reader :name
  def initialize name
    @name = name
  end
  # player input for row and column
  def input_row_column
    puts "Input row and Column Seprated by spaces:press q to quit"
    input1 = gets.chomp
    if input1 == "q"
      return input1
    end
    input = input1.split(" ")
    player_row = input[0].to_i - 1
    player_col = input[1].to_i - 1
    unless(row_col_validated(player_row, player_col)) # row column is invalid then raise Exception
      raise(InvalidRowColumnError,"Exception:Invalid row or column")
    end
    #player is trying to modify the System generated grid
    raise(SystemGridError, "Exception:System generated grid") if Sudoku.is_system_grid?(player_row, player_col)
    return player_row, player_col
  rescue InvalidRowColumnError => e
    puts e.message
    retry
  rescue SystemGridError => e1
    puts e1.message
    retry
  end

  def input_value                    # input the value at grid
    puts "input value if you want To erase press 0 or any String"
    value = gets.chomp.to_i
    raise(InvalidValue, "Exception: Value Invalid") unless(value.between?(0, 9))
    return value
  rescue InvalidValue => e
    puts e.message
    retry
  end

  private

  def row_col_validated(player_row, player_col)
    return (player_row.between?(0, 8) && player_col.between?(0, 8)) ? true : false
  end
end
