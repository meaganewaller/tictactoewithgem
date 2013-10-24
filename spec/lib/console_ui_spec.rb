require 'spec_helper'
require 'mocks/mock_board'
require 'ui'

describe UI do
  it "displays the board" do
    board = MockBoard.new
    described_class.print_board(board)
    board.spaces.should be_true
  end
end
