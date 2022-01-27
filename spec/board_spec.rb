require './lib/board'

describe Board do
  describe '#win?' do
    subject(:board_win) { described_class.new }

    context 'on newly created board' do
      it 'returns false' do
        expect(board_win).not_to be_win
      end
    end

    context 'when 4 in a row' do
      before do
        board_win.instance_variable_set(:@grid, [
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, 'X', 'X', 'X', 'X', nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
      end
      it 'returns true' do
        expect(board_win).to be_win
      end
    end

    context 'when 4 in a column' do
      before do
        board_win.instance_variable_set(:@grid, [
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
      end
      it 'returns true' do
        expect(board_win).to be_win
      end
    end

    context 'when 4 in a primary-diagonal' do
      before do
        board_win.instance_variable_set(:@grid, [
                                          [nil, nil, nil, nil, nil, 'X', nil],
                                          [nil, nil, nil, nil, 'X', nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, 'X', nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
      end
      it 'returns true' do
        expect(board_win).to be_win
      end
    end

    context 'when 4 in a secondarry-diagonal' do
      before do
        board_win.instance_variable_set(:@grid, [
                                          [nil, 'X', nil, nil, nil, nil, nil],
                                          [nil, nil, 'X', nil, nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, nil, 'X', nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
      end
      it 'returns true' do
        expect(board_win).to be_win
      end
    end
  end
end
