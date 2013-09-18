require 'spec_helper'
require 'game'
require 'ttt'
require 'timeout'

describe Game do
  let(:game) { Game.new }
  before(:each) { game.stub(:puts) }
  before(:each) { game.stub(:print) }
  context "#render_board" do
    it "renders a blank board" do
      game.render_board.should == " 1 | 2 | 3 \n" +
                                  "---+---+---\n" +
                                  " 4 | 5 | 6 \n" +
                                  "---+---+---\n" +
                                  " 7 | 8 | 9 \n"
    end
  end

  context "#move" do
    it "makes a move" do
      game.move(0)
      game.ttt.board[0].should == 'x'
      game.ttt.turn.should == 'o'
    end
  end

  context "#ask_for_move" do
    it "prompts user for their move" do
      game.stub(:gets => '1')
      game.ask_for_move.should == 0
    end

    it "handles invalid input" do
      game.stub(:gets).and_return("0", "r", "1")
      game.ask_for_move.should == 0
    end

    it "handles choosing taken space" do
      game.move(0)
      game.stub(:gets).and_return("1", "4")
      game.ask_for_move.should == 3
    end
  end


  context "#play_again?" do
    it "returns true if user selects 'y'" do
      game.stub(:gets).and_return('y')
      game.play_again?.should be_true 
    end

    it "returns false if user selects 'n'" do
      game.stub(:gets).and_return('n')
      game.play_again?.should be_false
    end

    it "handles bad input" do
      game.stub(:gets).and_return('g', 'n')
      game.play_again?.should be_false
    end
  end

  context "#computer_move" do
    it "finds the best move for the computer when 'o'" do
      game.ttt = TTT.new(%w(x x -
                            o o -
                            - - -), "o")
      game.computer_move.should == 5 
    end

    it "finds the best move for the computer when 'x'" do
      game.ttt = TTT.new(%w(x x -
                            o o -
                            - - -), 'x')
      game.computer_move.should == 2  
    end
  end

  context "#over?" do
    it "knows when the game isn't over" do
      game.over?.should be_false
    end

    it "knows when the game is over due to 'x' winning" do
      game.ttt = TTT.new(%w(x x x
                            - - -
                            - - -))
      game.over?.should be_true
    end

    it "knows when the game is over due to 'o' winning" do
      game.ttt = TTT.new(%w(o o o
                            - - -
                            - - -))
      game.over?.should be_true
    end

    it "knows when the game is over due to a tie" do
      game.ttt = TTT.new(%w(x o x
                            o x o
                            o x o))
      game.over?.should be_true
    end
  end
end
