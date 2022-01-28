require './lib/game'
require_relative '../lib/board'
require './lib/player'

describe Game do
  subject(:game) { described_class.new }

  describe '#setup_player' do
    context 'when creating player 1' do
      it 'returns an instance of Player' do
        name = 'shrey'
        symbol = "\u26bd"
        allow(game).to receive(:puts)
        allow(game).to receive(:display_ask_player_name).with(1)
        allow(game).to receive(:gets).and_return(name)
        expect(Player).to receive(:new).with(name, symbol)
        game.setup_player(1, symbol)
      end
    end
  end

  describe '#give_valid_input' do
    context 'when entering a valid input' do
      it 'returns input' do
        name = 'shrey'
        symbol = "\u26bd"
        valid = '3'
        allow(game).to receive(:ask_player_input).with(name, symbol).and_return(valid)
        tst = game.give_valid_input(name, symbol)
        expect(tst).to eq(valid.to_i)
      end
    end

    context 'when entering 2 invalid and then 1 valid input' do
      it 'displays error msg twice' do
        name = 'shrey'
        symbol = "\u26bd"
        invalid1 = '12'
        invalid2 = 'a'
        valid = '3'
        allow(game).to receive(:ask_player_input).with(name, symbol).and_return(invalid1, invalid2, valid)
        expect(game).to receive(:puts).with("Erronous input ! try again").twice
        game.give_valid_input(name, symbol)
      end
    end
  end
end
