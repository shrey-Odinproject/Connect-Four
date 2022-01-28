require './lib/game'
require_relative '../lib/board'
require './lib/player'

describe Game do
  subject(:game) {described_class.new}
  describe '#setup_player' do
    context 'when creating player 1' do
      it 'returns an instance of Player' do
        name='shrey'
        symbol="\u26bd"
        allow(game).to receive(:puts)
        allow(game).to receive(:display_ask_player_name).with(1)
        allow(game).to receive(:gets).and_return(name)
        expect(Player).to receive(:new).with(name,symbol)
        game.setup_player(1)
      end
    end
  end
end