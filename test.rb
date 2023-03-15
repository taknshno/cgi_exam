# WEBrickの呼び出し
require 'webrick'

# WEBrickインスタンスの作成
## DocumentRoot: Webアプリケーションのドメイン設定
## CGIInterpreter: プログラムを実行するプログラムのパス
## Port: ポート番号
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
# 割り込み(INT)か通常終了(TERM)を検知したら
# サーバーをシャットダウン
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

# "/test"にアクセスされたら test.html.erb を ERBHandler として処理させる
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')

# ルートドメインにアクセスされたら exam.html.erb を ERBHandler として処理させる
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'exam.html.erb')

# "indicate.cgi"にアクセスされたら indicate.rb を CGIHandler として処理させる
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

# "goya.cgi"にアクセスされたら goya.rb を CGIHandler として処理させる
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

# サーバーを起動
server.start