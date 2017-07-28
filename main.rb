# encoding: shift_jis

#ヘッダーの読込
require_relative 'SYSTEM/header'

#タイトル名
Window.caption=("神在奇譚")

#マウスポインタ作成
mouse = Sprite.new(0, 0, Image.new(10, 10, C_DEFAULT))

#フォントサイズの指定
font = Font.new(26)

#メッセージボックス生成
messagebox = WIN32OLE.new('WScript.Shell')

#ルート管理変数
Flag.set(99)

def ScriptRoot(font, messagebox, mouse)
	script = Script.new
	script.read
	script.draw(font, messagebox, mouse)
end

#メインループ
Window.loop do

	case Flag.ref

		#タイトル画面
		when 99
			title(mouse, font, messagebox)

		#マップの描画
		when 11
			map(font, messagebox)

		#各ルートの描画
		else
			ScriptRoot(font, messagebox, mouse)
	end
end
