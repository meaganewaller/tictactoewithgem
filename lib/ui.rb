class UI
  attr_reader :messages
  def self.messages
    @messages ||= {}
  end

  def self.print_board(board)
    messages[:board] = board.spaces
  end

  def self.display_result(result)
    if result == "X" || result == "O"
      messages[:message] = "The Winner is #{result}"
    end
  end

end
