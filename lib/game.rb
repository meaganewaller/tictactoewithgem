require 'ttt'

class Game
  attr_accessor :ttt
  def initialize
    @ttt = TTT.new
  end

  def play
    puts render_board
    move = ask_for_move
    @ttt.make_move(move) 
    while !over? && move
      puts render_board
      puts "Computer Thinking..."
      @ttt.make_move(computer_move)
      puts render_board
      move = ask_for_move if !over?
      @ttt.make_move(move)
      puts render_board
    end
    Game.new.play if play_again?
    move
  end

  def render_board
    space = @ttt.board.map.with_index { |s, index| s == "-" ? index + 1 : s }
    " #{space[0]} | #{space[1]} | #{space[2]} \n" +
    "---+---+---\n" +
    " #{space[3]} | #{space[4]} | #{space[5]} \n" +
    "---+---+---\n" +
    " #{space[6]} | #{space[7]} | #{space[8]} \n"
  end

  def move(space)
    @ttt.make_move(space)
  end

  def ask_for_move
    print "Where would you like to move?: "
    choice = gets.chomp
    if @ttt.available_spaces.include?(choice.to_i - 1)
      choice.to_i - 1
    else
      ask_for_move
    end
  end

  def play_again?
    print "Would you like to play again? (y/n): "
    choice = gets.chomp
    if choice == 'y'
      true
    elsif choice =='n'
      false
    else
      play_again?
    end
  end

  def computer_move
    @ttt.best_move
  end

  def over?
    return true if @ttt.winning_player?('x') || 
                   @ttt.winning_player?('o') || 
                   @ttt.count_empty_spaces == 0
  end
end
