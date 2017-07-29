# encoding: shift_jis

#スクリプト描画メソッド
def script_line_draw(line, font)

	#文字位置の初期化
	x = 0; y = 0

	line.each_char do |word|

		Window.draw_font(30 + x, 350 + y, word, font, z:4)

		#文字位置を一つ進める
		x += 30

		if x >= 600 then
			x = 0
			y += 30
		end
	end
end

#スクリプト描画クラス
class Script

	#初期化
	def initialize(text = "")
		@text = text
		@bg = Sprite.new(0, 350, Image.new(640, 480, C_DEFAULT))
		@char = Sprite.new(0, 350, Image.new(640, 480, C_DEFAULT))
		@bgm = nil
		@se = nil
		@window = Sprite.new(0, 350, Image.new(640, 480, C_BLACK))
	end

	#スクリプト読込
	def read

		@text = File.open("DATA/STR/#{Flag.ref}.txt", "r")

		return @string = @text.read
	end

	#文字列と各種素材の描画
	def draw(font, messagebox, mouse)

		lineno = 0
		temp_flag = Flag.ref

		@string.each_line do |line|

			case line
				#コメント処理
				when /\/\//
					line.gsub!(/\/\/+/, "")
				#立ち絵ロード処理
				when /char\d\d/
					line.chomp!
					@char = Sprite.new(150, 0,Image.load("DATA/CHAR/#{line}.png"))
					line.gsub!(/char\d\d/, "")
				#背景ロード処理
				when /bg\d\d/
					line.chomp!
					@bg = Sprite.new(0, 0, Image.load("DATA/BG/#{line}.png"))
					line.gsub!(/bg\d\d/, "")
				#BGM再生処理
				when /bgm\d\d/
					line.chomp!
					@bgm = Sound.new("DATA/BGM/#{line}.wav"); @bgm.play
					line.gsub!(/bgm\d\d/, "")
				#SE再生処理
				when /se\d\d/
					line.chomp!
					@se = Sound.new("DATA/SE/#{line}.wav"); @se.play
					line.gsub!(/se\d\d/, "")
				#ルート終了タグ
				when /EOF/
					line.gsub!(/EOF/, "")
					if temp_flag == Flag.ref then
						Flag.set(11)
						puts Flag.ref
					else
						return Flag.ref
					end
				else
					lineno += 1

					temp_lineno = Lineno.ref

					if lineno >= Lineno.ref then
						Window.loop do

							@bg.draw; @char.draw; @window.draw

							script_line_draw(line, font)

							#エンターキーで次の文字列を呼び出す
							if Input.mouse_push?(M_LBUTTON); break; end

							#ゲームメニュー呼び出し
							gamemenu_call(messagebox, font, mouse, lineno, @bgm)

							#エスケープキーで終了
							exit_message(messagebox)
						end
					end
			end

			#セーブデータの読込時の処理
			if temp_flag != Flag.ref then
				if @bgm != nil then
					@bgm.stop
				end
			
				break
			end
		end
	end
end