class UI
  attr_reader :messages
  def self.messages
    @messages ||= {}
  end

  def self.print_board(board)
    messages[:board] = board.spaces
  end

end
