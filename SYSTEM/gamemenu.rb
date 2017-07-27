# encoding: shift_jis

#ゲームメニュー用オブジェクト生成
def gamemenu_object

	menu = Sprite.new(0, 0, Image.load("DATA/BG/GAMEMENU.png"))
	title_back = Sprite.new(45, 50, Image.new(100, 30, C_DEFAULT))
	save = Sprite.new(45, 110, Image.new(100, 30, C_DEFAULT))
	load = Sprite.new(45, 170, Image.new(100, 30, C_DEFAULT))
	delete = Sprite.new(45, 230, Image.new(100, 30, C_DEFAULT))
	config = Sprite.new(45, 290, Image.new(100, 30, C_DEFAULT))
	back = Sprite.new(45, 350, Image.new(100, 30, C_DEFAULT))
	quit = Sprite.new(45, 410, Image.new(100, 30, C_DEFAULT))

	return menu, title_back, save, load, delete, config, back, quit
end

#各種ゲームメニュー項目描画メソッド
def game_menu_draw(font)

	Window.draw_font(45, 50, "TITLE", font)
	Window.draw_font(45, 110, "SAVE", font)
	Window.draw_font(45, 170, "LOAD", font)
	Window.draw_font(45, 230, "DELETE", font)
	Window.draw_font(45, 290, "CONFIG", font)
	Window.draw_font(45, 350, "BACK", font)
	Window.draw_font(45, 410, "QUIT", font)
end

#ゲームメニューメソッド
def gamemenu(messagebox, font, mouse, lineno)

	#各種メニューボタン＆マウス用オブジェクト生成
	menu, title_back, save, load, delete, config, back, quit = gamemenu_object

	#ルート管理変数のtemp
	temp_flag = Flag.ref

	Window.loop do

		#マウス位置の取得
		mouse.x, mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

		#各種メニューの描画
		menu.draw; title_back.draw; save.draw; load.draw; delete.draw; config.draw; back.draw; quit.draw

		#各ゲームメニュー項目描画
		game_menu_draw(font)

		#各種オブジェクトの衝突判定
		case mouse

			when title_back
				Window.draw_font(0, 450, "タイトルに戻ります", font, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("タイトルに戻りますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						Flag.set(99)
						break
					end
				end

			when save
				Window.draw_font(0, 450, "セーブします", font, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("セーブしますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						savedata_menu(font, mouse, messagebox, 0, lineno)
					end
				end

			when load
				Window.draw_font(0, 450, "ロードします", font, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("ロードしますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						savedata_menu(font, mouse, messagebox, 1, lineno)
					end
				end

			when delete
				Window.draw_font(0, 450, "セーブデータを削除します", font, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("セーブデータを削除しますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						savedata_menu(font, mouse, messagebox, 2, lineno)
					end
				end

			when config
				Window.draw_font(0, 450, "設定を変更します", font, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("設定を変更しますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						config(font, mouse, messagebox)
					end
				end

			when back
				Window.draw_font(0, 450, "ゲームに戻ります", font, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("ゲームに戻りますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
						break
					end
				end

			when quit
				Window.draw_font(0, 450, "ゲームを終了します", font, z:4)

				#左クリック時の処理
				if Input.mouse_push?(M_LBUTTON) then
					#「はい」を押すと終了
					if messagebox.Popup("ゲームを終了しますか？", 10, "神在奇譚", 4 + 32 ) == 6 then
						exit
					end
				end
		end

		#右クリック時の処理
		if Input.mouse_push?(M_RBUTTON) then
			#「はい」を押すと終了
			if messagebox.Popup("ゲームに戻りますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
				return Flag.ref
			end
		end

		#エスケープキーで終了
		exit_message(messagebox)
	end
end

#ゲームメニュー呼び出しメソッド
def gamemenu_call(messagebox, font, mouse, lineno, bgm)

	#右クリック時の処理
	if Input.mouse_push?(M_RBUTTON) then

		#BGM停止処理
		if bgm != nil then
			bgm.stop
		end

		#「はい」を押すと終了
		if messagebox.Popup("ゲームメニューに移行しますか？", 0, "神在奇譚", 4 + 32 ) == 6 then

			#セーブデータ用スクリーンショット取得
			savedata_screenshot_flag = 1
			savedata_screenshot_flag = savedata_screenshot(savedata_screenshot_flag)

			gamemenu(messagebox, font, mouse, lineno)
		end

		#BGMの再生再開
		if bgm != nil then
			bgm.play
		end
	end
end