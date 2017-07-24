# encoding: shift_jis

#�^�C�g���p�I�u�W�F�N�g����
def title_object

	#�^�C�g������
	title = Sprite.new(0, 0, Image.load("DATA/BG/TITLE.png"))

	#�e�탁�j���[
	start = Sprite.new(490, 30, Image.new(100, 30, C_DEFAULT))
	load = Sprite.new(490, 90, Image.new(100, 30, C_DEFAULT))
	quit = Sprite.new(490, 150, Image.new(100, 30, C_DEFAULT))

	return title, start, load, quit
end

#�e��^�C�g�����j���[���ڕ`�惁�\�b�h
def title_menu_draw(font)

	Window.draw_font(500, 30, "START", font)
	Window.draw_font(500, 90, "LOAD", font)
	Window.draw_font(500, 150, "QUIT", font)
end

#�^�C�g�����j���[���\�b�h
def title(mouse, font, messagebox)

	#�^�C�g���p�I�u�W�F�N�g����
	title, start, load, quit = title_object

	lineno = 0

	#���C�����[�v
	Window.loop do

		#�}�E�X�ʒu�̎擾
		mouse.x, mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

		#�^�C�g����ʂ̕`��
		title.draw; start.draw; load.draw; quit.draw

		#�e��^�C�g�����j���[�̕`��
		title_menu_draw(font)

		case mouse
			#START�I�����̏���
			when start
				Window.draw_font(0, 450, "�Q�[�����J�n���܂�", font, color:C_BLACK, z:4)

				#���N���b�N���̏���
				if Input.mouse_push?(M_LBUTTON) then
					Flag.set(1)
					break
				end

			#LOAD�I�����̏���
			when load
				#���N���b�N���̏���
				if Input.mouse_push?(M_LBUTTON) then
					#�u�͂��v�������ƏI��
					if messagebox.Popup("���[�h���܂����H", 0, "�_�݊��", 4 + 32 ) == 6 then
						savedata_menu(font, mouse, messagebox, 1, lineno)
						break
					end
				end
				
			#QUIT�I�����̏���
			when quit

				#���s���e�̕`��
				Window.draw_font(0, 450, "�Q�[�����I�����܂�", font, color:C_BLACK, z:4)

				#�I���m�F
				if Input.mouse_push?(M_LBUTTON) then
					#�u�͂��v�������ƏI��
					if messagebox.Popup("�Q�[�����I�����I�����܂����H", 0, "�_�݊��", 4 + 32 ) == 6 then
						exit
					end
				end
		end

		#�G�X�P�[�v�L�[�ŏI��
		exit_message(messagebox)
	end
end