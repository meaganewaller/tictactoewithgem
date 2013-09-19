require 'spec_helper'
require 'ttt'
require 'console_ui'

describe ConsoleUI do
  let(:console) { ConsoleUI }
  let(:ttt) { TTT.new }
  before(:each) { ttt }
  before(:each) { console.stub(:puts) }

  context "#render_board" do
    it "renders a blank board" do
      console.render_board(ttt).should == " 1 | 2 | 3 \n" +
                                          "---+---+---\n" +
                                          " 4 | 5 | 6 \n" +
                                          "---+---+---\n" +
                                          " 7 | 8 | 9 \n"
    end

    it "renders a board with marks on it" do
      test_ttt = TTT.new(%w(x o x
                            - - -
                            x o -))
      console.render_board(test_ttt).should == " x | o | x \n" +
                                               "---+---+---\n" +
                                               " 4 | 5 | 6 \n" +
                                               "---+---+---\n" +
                                               " x | o | 9 \n"
    end
  end

  context "#ask_for_move" do
    it "asks the user for their move" do
      console.stub(:gets => '1')
      console.ask_for_move(ttt).should == 0
    end

    it "handles invalid input" do
      console.stub(:gets).and_return('0', 'r', '1')
      console.ask_for_move(ttt).should == 0
    end

    it "handles choosing a taken space" do
      test = TTT.new(%w(x - -
                        - - -
                        - - -))
      console.stub(:gets).and_return("1", "4")
      console.ask_for_move(test).should == 3
    end
  end
  

  context "#play_again?" do
    it "returns true if they select 'y'" do
      console.stub(:gets => 'y')
      console.play_again?.should be_true
    end

    it "returns false if they select 'n'" do
      console.stub(:gets => 'n')
      console.play_again?.should be_false
    end

    it "handles bad input" do
      console.stub(:gets).and_return('t', 'f', 'y')
      console.play_again?.should be_true
    end
  end
end
