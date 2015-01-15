require './exception.rb'
require './user.rb'
class Sudoku
  # Hash for storing the blank spaces
  @@hash = Hash.new
  #initializes Game
  def initialize
  @sudoku = [[2, 8, " ", " ", 9, 7, 3, " ", " "],
                    [4 , " ", 7, " ", 3, " ", 8, " ", " "],
                    [" ", 3, 5, " ", " ",8, " ", " ", 6],
                    [" ", " ", " ", " ", 1, 3, " ", 8, " "],
                    [8 , " ", 1, " ", " ", " ", 5," ", 7],
                    [" ", 5, " ", 7, 8, " ", " ", " ", " "],
                    [3, " ", " ", 8, " ", " ", 7, 2, " "],
                    [" ", " ", 8, " ", 2, " ", 4, " ", 3],
                    [" ", " ", 4, 3, 7, " ", " ",5, 8]]
    @sudoku.each_index do |row|
      @sudoku[row].each_index do |col|
        @@hash["#{ row } #{ col }"] = "" if(@sudoku[row][col] == " ")
      end
    end
  end

  def play(user)
    while(true)
      display_sudoku
      user_value = user.input_row_column
      break if user_value.eql? "q"
      row,col = user_value
      value = user.input_value
      if validate(row, col, value)
        update_sudoku(row, col, value)
      else
        puts 'Wrong Value'
      end
    end
    if(sudoku_not_filled?)
      puts "Thank you have a nice day"
    else
      puts "You have completed the game"
    end
  end

  def self.is_system_grid?(user_row, user_col)    # checks whether user is modifying system generated grid value
    return !(@@hash.key? "#{user_row} #{user_col}")
  end

  #Checks whether game  completed
  def sudoku_not_filled?
    flg = false
    @sudoku.each do |row|
      flg = true if row.count(" ") != 0
    end
    flg
  end

  private

  def update_sudoku(row, col, value)
    @sudoku[row][col] = value
  end

  def display_sudoku
    @sudoku.each_index do |row|
          @sudoku[row].each_index do |col|
        print @sudoku[row][col]
        print "|" if col % 3 == 2
        print "  "
      end
      puts
      puts "-----------------------------" if row % 3 == 2
    end
  end

  def row_wise_repeat(row, col, value)
    if @sudoku[row].include? value
      true
    else
      false
    end
  end

  def col_wise_repeat(row, col, value)
   if @sudoku.transpose[col].include? value
     true
   else
     false
   end
  end

  def block_wise_repeat(row, col, value)
    row_str = row - row % 3
    col_str = col - col % 3
    ((@sudoku[row_str][col_str,3].include? value) || (@sudoku.transpose[row_str][col_str,3].include? value)) ?  true : false
  end

  def validate(row, col, value)
    (!row_wise_repeat(row,col,value) && !col_wise_repeat(row,col,value) && !block_wise_repeat(row,col,value)) ? true : false
  end
end
=begin
  def generate_sudoku

    array1d = [1,2,3,4,5,6,7,8,9]
    1..3
    (0..3).each do |row|
      array2d[row+inr] =  array1d.rotate!(3)
    end
  =end


=begin
class Start_game
  def initialize()
    sudoku = Sudoku.new
    user = User.new
    sudoku.play(user)
  end
end
Start_game.new
=end

sudoku = Sudoku.new
user = User.new
sudoku.play(user)

puts "playing second  time:"
sudoku1 = Sudoku.new
sudoku1.play(user)
