# encoding: shift_jis

#タイトル用オブジェクト生成
def title_object

	#タイトル文字
	title = Sprite.new(0, 0, Image.load("DATA/BG/TITLE.png"))

	#各種メニュー
	start = Sprite.new(490, 30, Image.new(100, 30, C_DEFAULT))
	load = Sprite.new(490, 90, Image.new(100, 30, C_DEFAULT))
	quit = Sprite.new(490, 150, Image.new(100, 30, C_DEFAULT))

	return title, start, load, quit
end

#各種タイトルメニュー項目描画メソッド
def title_menu_draw(font)

	Window.draw_font(500, 30, "START", font)
	Window.draw_font(500, 90, "LOAD", font)
	Window.draw_font(500, 150, "QUIT", font)
end

#タイトルメニューメソッド
def title(mouse, font, messagebox)

	#タイトル用オブジェクト生成
	title, start, load, quit = title_object

	lineno = 0

	#メインループ
	Window.loop do

		#マウス位置の取得
		mouse.x, mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

		#タイトル画面の描画
		title.draw; start.draw; load.draw; quit.draw

		#各種タイトルメニューの描画
		title_menu_draw(font)

		case mouse
			#START選択時の処理
			when start
				Window.draw_font(0, 450, "ゲームを開始します", font, color:C_BLACK, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					Flag.set(1)
					break
				end

			#LOAD選択時の処理
			when load
				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("ロードしますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						savedata_menu(font, mouse, messagebox, 1, lineno)
						break
					end
				end
				
			#QUIT選択時の処理
			when quit

				#実行内容の描画
				Window.draw_font(0, 450, "ゲームを終了します", font, color:C_BLACK, z:4)

				#終了確認
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("ゲームを終了を終了しますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						exit
					end
				end
		end

		#エスケープキーで終了
		exit_message(messagebox)
	end
end