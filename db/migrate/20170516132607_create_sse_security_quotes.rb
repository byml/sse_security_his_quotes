class CreateSseSecurityQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :sse_security_quotes do |t|
    	t.date :trade_date
    	t.string :stock_code, limit: 20
    	t.string :stock_abbreviation, limit: 50
      t.decimal :close_price,   :null => false, :precision => 16, :scale => 2, :default => 0
    	t.decimal :open_price,    :null => false, :precision => 16, :scale => 2, :default => 0
      t.decimal :highest_price,    :null => false, :precision => 16, :scale => 2, :default => 0
      t.decimal :lowest_price,     :null => false, :precision => 16, :scale => 2, :default => 0
      t.decimal :previous_closing_price,     		:null => false, :precision => 16, :scale => 2, :default => 0
      t.decimal :change_rate,  :null => false, :precision => 16, :scale => 2, :default => 0
      t.integer :volume,  :null => false, :default => 0
      t.decimal :turnover,  :null => false, :precision => 16, :scale => 2, :default => 0
      t.decimal :change_amount,  :null => false, :precision => 16, :scale => 2, :default => 0
      t.decimal :amplitude,  :null => false, :precision => 16, :scale => 2, :default => 0
    	t.string :trade_phase, limit: 20

      t.timestamps
    end
  end
end
