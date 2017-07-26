# encoding: shift_jis

#セーブデータ用スクリーンショット取得
def savedata_screenshot(savedata_screenshot_flag)

	#セーブデータ用のスクリーンショット
	if savedata_screenshot_flag == 1 then

		Window.get_screen_shot("DATA/SAVE/savedata.png", format=FORMAT_PNG)
		return savedata_screenshot_flag = 0
	end
end

#セーブデータ用スクリーンショットの読込
def savedata_screenshot_load

	i = 0

	savedata_screenshot = Array.new(3)

	3.times do

		if File.exist?("DATA/SAVE/savedata#{i + 1}.png") then
			savedata_screenshot[i] = Image.load("DATA/SAVE/savedata#{i + 1}.png")
		else
			savedata_screenshot[i] = Image.new(640, 480, [0, 0, 0, 0])
		end

		i += 1
	end

	return savedata_screenshot[0], savedata_screenshot[1], savedata_screenshot[2]
end

#セーブデータのロード
def savedata_load(number, messagebox)
	
	#セーブデータの有無チェック
	if File.exist?("DATA/SAVE/savedata#{number}.png") then
		Flag.set(File.open("DATA/SAVE/savedata#{number}_flag.txt", "r").read.to_i)
		Lineno.set(File.open("DATA/SAVE/savedata#{number}_lineno.txt", "r").read.to_i)
		puts Flag.ref
		puts Lineno.ref
	else
		messagebox.Popup("セーブデータ#{number}はありません！", 0, "神在奇譚", 1 + 48 )
	end
end

#セーブデータにセーブ
def savedata_save(number, lineno)

	#ルート管理変数の書き込み（セーブデータの書き込み)
	File.write("DATA/SAVE/savedata#{number}_flag.txt", Flag.ref.to_s)
	File.write("DATA/SAVE/savedata#{number}_lineno.txt", lineno.to_s)
	File.rename("DATA/SAVE/savedata.png", "DATA/SAVE/savedata#{number}.png")
end

#セーブデータを削除
def savedata_delete(number, messagebox)

	#セーブデータの有無チェック
	if File.exist?("DATA/SAVE/savedata#{number}.png") then
		#セーブデータの削除
		File.delete("DATA/SAVE/savedata#{number}_flag.txt")
		File.delete("DATA/SAVE/savedata#{number}_lineno.txt")
		File.delete("DATA/SAVE/savedata#{number}.png")
	else
		messagebox.Popup("セーブデータ#{number}はありません！", 0, "神在奇譚", 1 + 48 )
	end
end

#セーブデータ描画用オブジェクト生成
def savedata_object

	savedata1 =  Sprite.new(100, 300, Image.new(250, 30, C_DEFAULT))
	savedata2 =  Sprite.new(100, 350, Image.new(250, 30, C_DEFAULT))
	savedata3 =  Sprite.new(100, 400, Image.new(250, 30, C_DEFAULT))
	back = Sprite.new(100, 450, Image.new(200, 300, C_DEFAULT))

	return savedata1, savedata2, savedata3, back
end

#メニュー画面の描画メソッド
def savedata_menu_draw(font, mouse, savedata1, savedata2, savedata3, back)

	#ロード用オブジェクト
	savedata1.draw
	savedata2.draw
	savedata3.draw
	mouse.draw

	#各種ゲームメニューの描画
	Window.draw_font(100, 300, "セーブデータ１", font)
	Window.draw_font(100, 350, "セーブデータ２", font)
	Window.draw_font(100, 400, "セーブデータ３", font)
	Window.draw_font(100, 450, "BACK", font)
end

#セーブデータメニュー描画の切り替え
def select_savedata_switch(messagebox, string, num, lineno)

	#左クリック時にセーブ/ロード/削除
	if Input.mouse_push?(M_LBUTTON) then
		if messagebox.Popup("セーブデータ#{num}を#{string}しますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
			if string == "ロード" then
				savedata_load(num, messagebox)
			elsif string == "セーブ" then
				savedata_save(num, lineno)
			else
				savedata_delete(num, messagebox)
			end
		end
	end
end

#セーブメニュー用文字列のセット
def savedata_string_set(number)

	if number == 1 then
		string = "ロード"
	elsif number == 0 then
		string = "セーブ"
	else
		string = "削除"
	end

	return string
end

#savedata_menuメソッドの定義
def savedata_menu(font, mouse, messagebox, number, lineno)
	
	#各種描画用オブジェクト生成
	savedata1, savedata2, savedata3, back = savedata_object
	savedata1_screenshot, savedata2_screenshot, savedata3_screenshot = savedata_screenshot_load
	string = savedata_string_set(number)
	
	temp_flag = Flag.ref

	#描画ループ
	Window.loop do

		#マウス位置の取得
		mouse.x, mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

		#セーブデータ処理のメニュー描画
		savedata_menu_draw(font, mouse, savedata1, savedata2, savedata3, back)

		case mouse

			when savedata1
				#セーブデータ画像の描画
				Window.draw_scale(100, -100, savedata1_screenshot, 0.5, 0.5, 1)

				select_savedata_switch(messagebox, string, 1, lineno)

			when savedata2
				#セーブデータ画像の描画
				Window.draw_scale(100, -100, savedata2_screenshot, 0.5, 0.5, 1)

				select_savedata_switch(messagebox, string, 2, lineno)

			when savedata3
				#セーブデータ画像の描画
				Window.draw_scale(100, -100, savedata3_screenshot, 0.5, 0.5, 1)

				select_savedata_switch(messagebox, string, 3, lineno)

			when back
				if Input.mouse_push?(M_LBUTTON) then
					break
				end
		end

		#ロードした場合の処理
		if temp_flag != Flag.ref then
			break
		end

		#エスケープキーで終了
		exit_message(messagebox)
	end
end
