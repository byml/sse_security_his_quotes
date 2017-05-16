require 'roo'

SseSecurityQuoteFields = {
	stock_code: '证券代码',
	stock_abbreviation: '证券简称',
	close_price: '最新',
	open_price: '开盘',
	highest_price: '最高',
	lowest_price: '最低',
	previous_closing_price: '前收',
	change_rate: '涨跌幅',
	volume: '成交量',
	turnover: '成交额',
	change_amount: '涨跌',
	amplitude: '振幅',
	trade_phase: 'tradephase'
}

src_dir = '/vagrant/data/todo'
dest_dir = '/vagrant/data/done'

Dir.foreach(src_dir) do |file_name|
  if file_name != "." and file_name != ".." and !file_name.start_with?('~$')
  	suffix = file_name[0,8]
		table_name_with_suffix = "#{ Sse::SecurityQuote.table_name}_#{ suffix }"
		Sse::SecurityQuote.connection.execute "DROP TABLE IF EXISTS #{ table_name_with_suffix }"
		Sse::SecurityQuote.connection.execute "CREATE TABLE #{ table_name_with_suffix } LIKE #{ Sse::SecurityQuote.table_name}"
		SecurityQuoteWithSuffix = Class.new(Sse::SecurityQuote)
		SecurityQuoteWithSuffix.table_name = table_name_with_suffix

		src_file_name = "#{ src_dir }/#{ file_name }"
    xlsx = Roo::Spreadsheet.open(src_file_name)
		sheet = xlsx.sheet(0)
		sheet.each(SseSecurityQuoteFields) do |hash|
			unless 'tradephase' == hash[:trade_phase]
				hash['trade_date'] = Date.parse(suffix)
				SecurityQuoteWithSuffix.create!(hash)
			end
		end
		desc_file_name = "#{ dest_dir }/#{ file_name }"
		File.rename(src_file_name, desc_file_name)
  end
end