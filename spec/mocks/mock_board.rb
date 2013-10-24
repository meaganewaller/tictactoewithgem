class MockBoard
  attr_reader :board_displayed, :spaces

  def print_board
    @board_displayed = true
  end

  def spaces
    @spaces = true
  end
end
