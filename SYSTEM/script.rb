# encoding: shift_jis

#�X�N���v�g�`�惁�\�b�h
def script_line_draw(line, font)

	#�����ʒu�̏�����
	x = 0; y = 0

	line.each_char do |word|

		Window.draw_font(30 + x, 350 + y, word, font, z:4)

		#�����ʒu����i�߂�
		x += 30

		if x >= 600 then
			x = 0
			y += 30
		end
	end
end

#�X�N���v�g�`��N���X
class Script

	#������
	def initialize(text = "")
		@text = text
		@bg = Sprite.new(0, 350, Image.new(640, 480, C_DEFAULT))
		@char = Sprite.new(0, 350, Image.new(640, 480, C_DEFAULT))
		@bgm = nil
		@se = nil
		@window = Sprite.new(0, 350, Image.new(640, 480, C_BLACK))
	end

	#�X�N���v�g�Ǎ�
	def read

		@text = File.open("DATA/STR/#{Flag.ref}.txt", "r")

		return @string = @text.read
	end

	#������Ɗe��f�ނ̕`��
	def draw(font, messagebox, mouse)

		lineno = 0

		@string.each_line do |line|

			case line
				when /char\d\d/
					line.chomp!
					@char = Sprite.new(150, 0,Image.load("DATA/CHAR/#{line}.png"))
					line.gsub!(/char\d\d/, "")
				when /bg\d\d/
					line.chomp!
					@bg = Sprite.new(0, 0, Image.load("DATA/BG/#{line}.png"))
					line.gsub!(/bg\d\d/, "")
				when /bgm\d\d/
					line.chomp!
					@bgm = Sound.new("DATA/BGM/#{line}.wav"); @bgm.play
					line.gsub!(/bgm\d\d/, "")
				when /se\d\d/
					line.chomp!
					@se = Sound.new("DATA/SE/#{line}.wav"); @se.play
					line.gsub!(/se\d\d/, "")
				when /EOF/
					line.gsub!(/EOF/, "")
						Flag.set(11)
				else
					lineno += 1

					temp_lineno = Lineno.ref
					temp_flag = Flag.ref

					if lineno >= Lineno.ref then
						Window.loop do

							@bg.draw; @char.draw; @window.draw

							script_line_draw(line, font)

							#�G���^�[�L�[�Ŏ��̕�������Ăяo��
							if Input.mouse_push?(M_LBUTTON); break; end

							#�Q�[�����j���[�Ăяo��
							gamemenu_call(messagebox, font, mouse, lineno)

							#�G�X�P�[�v�L�[�ŏI��
							exit_message(messagebox)

							#�Z�[�u�f�[�^�ǂݍ��ݎ��̏���(flag�ϐ����قȂ�ꍇ)
							if  temp_flag != Flag.ref && temp_lineno != Lineno.ref then
								puts "Flag.ref = #{Flag.ref}"
								break
							end

							#�Z�[�u�f�[�^�ǂݍ��ݎ��̏���(flag�ϐ����قȂ�ꍇ)
							if temp_lineno != Lineno.ref then
								puts "Flag.ref = #{Flag.ref}, line"
								break
							end

						end
					end
			end
		end
	end
end