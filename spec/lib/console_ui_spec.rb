require 'spec_helper'
require 'mocks/mock_board'
require 'ui'

describe UI do
  it "displays the board" do
    board = MockBoard.new
    described_class.print_board(board)
    board.spaces.should be_true
  end

  context "ending the game" do
    it "has a winner - X" do
      described_class.display_result("X")
      described_class.messages[:message].should == "The Winner is X"
    end
  end
end
