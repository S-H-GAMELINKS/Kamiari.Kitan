# coding: shift_jis

#マップ素材の読込
def map_load	

	#マップ画像の読込
	map = Sprite.new(0, 0, Image.load( "DATA/MAP/map.png"))
	ap1 = Sprite.new(120, 80, Image.load("DATA/MAP/ap.png"))
	ap2 = Sprite.new(40, 180, Image.load("DATA/MAP/ap.png"))
	ap3 = Sprite.new(160, 170, Image.load("DATA/MAP/ap.png"))
	ap4 = Sprite.new(220, 230, Image.load("DATA/MAP/ap.png"))
	ap5 = Sprite.new(200, 380, Image.load("DATA/MAP/ap.png"))
	ap6 = Sprite.new(350, 300, Image.load("DATA/MAP/ap.png"))

	#フォントサイズ
	map_font = Font.new(32)

	return map, ap1, ap2, ap3, ap4, ap5, ap6, map_font
end

#各地名(アクセスポイント)描画メソッド
def ap_draw(string, num, font, messagebox)
	Window.draw_font(500, 200, "#{string}", font, z:2)

	#左クリック時の処理
	if Input.mouse_push?(M_LBUTTON) then

		#「はい」を押すと終了
		if messagebox.Popup("#{string}に行きますか？", 0, "神在奇譚", 4 + 32 ) == 6 then
			Flag.set(num)
		end
	end
end

#マップ描画メソッド(メイン)
def map(font, messagebox)

	lineno = 0
	Lineno.set(0)
	temp_flag = Flag.ref

	map, ap1, ap2, ap3, ap4, ap5, ap6, map_font = map_load()

	Input.mouse_enable=(false)

	mouse = Sprite.new(0, 0, Image.load("DATA/MAP/usagi.png"))

	bgm = Sound.new("DATA/BGM/BGM01.wav")
	bgm.play

	#マップ描画ループ
	Window.loop do

		#マウスの位置を取得
		mouse.x, mouse.y = Input.mouse_x, Input.mouse_y

		#マップの描画&地名(アクセスポイント)◆とマウスの描画
		map.draw; ap1.draw; ap2.draw; ap3.draw; ap4.draw; ap5.draw; ap6.draw; mouse.draw

		#各地名(アクセスポイント)にマウスが接触すると地名描画
		case mouse

			when ap1
				ap_draw("日御碕灯台", 5, font, messagebox)

			when ap2
				ap_draw("稲佐の浜", 4, font, messagebox)

			when ap3
				ap_draw("出雲大社", 2, font, messagebox)

			when ap4
				ap_draw("旧大社駅", 3, font, messagebox)

			when ap5
				ap_draw("須佐神社", 7, font, messagebox)

			when ap6
				ap_draw("立久恵峡", 6, font, messagebox)
		end

		#地名（アクセスポイント）の描画
		Window.draw_font(500, 450, "出雲の國", font, z:2)

		#ゲームメニュー呼び出し
		gamemenu_call(messagebox, font, mouse, lineno, bgm); Input.mouse_enable=(true)

		#セーブデータ読み込み時の処理(flag変数が異なる場合)
		if  Flag.ref != temp_flag then
			puts Flag.ref
			bgm.stop
			break
		#@@flagが99の場合タイトルに戻る
		elsif Flag.ref == 99 then
			bgm.stop
			break
		end

		#エスケープキーで終了
		exit_message(messagebox)
	end
end
