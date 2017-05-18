require "execjs"
require "open-uri"

hk_stocks = ['hk00001','hk00002','hk00003']

source = open("http://hq.sinajs.cn/?list=#{ hk_stocks.join(',') }").read
context = ExecJS.compile(source)

hk_stocks.each do |hk_stock|
	xx = context.eval("hq_str_#{ hk_stock }").split(',')
	p 'bbb', xx
end
