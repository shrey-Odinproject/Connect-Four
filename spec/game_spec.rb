require './lib/game'
require_relative '../lib/board'
require './lib/player'

describe Game do
  subject(:game) { described_class.new }

  before do
    # y do this?, used in make move as without it board's grid wasnt being updated
    game.instance_variable_set(:@board, instance_double(Board))
  end

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

  describe '#get_valid_input' do
    context 'when entering a valid input' do
      it 'returns input' do
        name = 'shrey'
        symbol = "\u26bd"
        valid = '3'
        allow(game).to receive(:ask_player_input).with(name, symbol).and_return(valid)
        tst = game.get_valid_input(name, symbol)
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
        game.get_valid_input(name, symbol)
      end
    end
  end

  describe '#make_move' do
    let(:player) { instance_double(Player) }
    context 'when making move on new board' do
      it 'registers player move' do
        name = 'shrey'
        sym = "\u26bd"
        col = 4
        allow(player).to receive(:name).and_return(name)
        allow(player).to receive(:symbol).and_return(sym)
        allow(game).to receive(:get_valid_input).and_return(col)
        expect(game.board).to receive(:edit_grid).with(col, sym)
        expect(game.board).to receive(:show)
        game.make_move(player)
      end
    end
  end

  describe '#switch_players' do
    describe 'when player 1 is current player' do
      it 'returns player 2' do
        game.instance_variable_set(:@player1, instance_double(Player))
        game.instance_variable_set(:@player2, instance_double(Player))
        game.instance_variable_set(:@current_player, game.player1)
        tst=game.switch_players
        expect(tst).to eq(game.player2)
      end
    end
  end
end
