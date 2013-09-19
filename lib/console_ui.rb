require 'ttt'

class ConsoleUI
  def self.render_board(ttt)
    space = ttt.board.map.with_index { |s, index| s == "-" ? index + 1 : s }
    " #{space[0]} | #{space[1]} | #{space[2]} \n" +
    "---+---+---\n" +
    " #{space[3]} | #{space[4]} | #{space[5]} \n" +
    "---+---+---\n" +
    " #{space[6]} | #{space[7]} | #{space[8]} \n"
  end

  def self.display_board(ttt)
    system('clear')
    puts render_board(ttt)
  end

  def self.ask_for_move(ttt)
    puts "Where would you like to move? "
    choice = gets.chomp
    if ttt.available_spaces.include?(choice.to_i - 1)
      choice.to_i - 1
    else
      ask_for_move(ttt)
    end
  end

  def self.play_again?
    puts "Would you like to play again? (y/n): "
    choice = gets.chomp
    if choice == 'y'
      return true
    elsif choice == 'n'
      return false
    else
      play_again?
    end
  end
end

