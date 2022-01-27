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
                                          [nil, 'O', nil, nil, nil, nil, nil],
                                          [nil, nil, 'X', nil, nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, nil, 'X', nil, nil],
                                          [nil, nil, nil, nil, nil, 'X', nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
      end
      it 'returns true' do
        expect(board_win).to be_win
      end
    end
  end

  describe '#edit_board' do
    subject(:board_edit) { described_class.new }

    context 'when no previous edits made i.e depth 5' do
      it 'edits board returns nil' do
        col = 4
        sym = 'X'
        depth = 5
        board_edit.edit_grid(col, sym)
        expect(board_edit.grid[depth][col]).to eq(sym)
      end
    end

    context 'when 2 previous edits made i.e depth 3' do
      before do # the 2 previous edits
        2.times { board_edit.edit_grid(4, 'X') }
      end
      it 'edits board returns nil' do
        col = 4
        sym = 'X'
        depth = 3
        board_edit.edit_grid(col, sym)
        expect(board_edit.grid[depth][col]).to eq(sym)
      end
    end

    context 'when no space to edit i.e depth < 0' do
      before do
        6.times { board_edit.edit_grid(4, 'X') }
      end
      it 'does not edit board instead displays Overflow !!!' do
        col = 4
        sym = 'X'
        expect(board_edit).to receive(:puts).with('Overflow !!!')
        board_edit.edit_grid(col, sym)
      end
    end
  end

  describe '#full?' do
    subject(:board_full) { described_class.new }

    context 'when board is full ' do
      before do
        board_full.instance_variable_set(:@grid, [
                                           ['X', 'O', 'X', 'O', 'O', 'X', 'O'],
                                           ['O', 'O', 'X', 'X', 'O', 'X', 'O'],
                                           ['O', 'X', 'O', 'X', 'O', 'O', 'X'],
                                           ['X', 'O', 'X', 'O', 'X', 'X', 'O'],
                                           ['O', 'X', 'O', 'X', 'X', 'O', 'X'],
                                           ['O', 'X', 'O', 'X', 'O', 'O', 'X']
                                         ])
      end
      it 'returns true' do
        expect(board_full).to be_full
      end
    end

    context 'when board is not full ' do
      before do
        board_full.instance_variable_set(:@grid, [
                                           ['X', 'O', 'X', 'O', 'O', 'X', 'O'],
                                           ['O', 'O', 'X', 'X', 'O', 'X', 'O'],
                                           ['O', nil, 'O', 'X', 'O', 'O', 'X'],
                                           ['X', 'O', 'X', 'O', 'X', 'X', 'O'],
                                           ['O', 'X', 'O', 'X', 'X', 'O', 'X'],
                                           ['O', 'X', 'O', 'X', 'O', 'O', 'X']
                                         ])
      end
      it 'returns false' do
        expect(board_full).not_to be_full
      end
    end
  end
end
