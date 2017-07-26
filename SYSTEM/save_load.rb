# encoding: shift_jis

#�Z�[�u�f�[�^�p�X�N���[���V���b�g�擾
def savedata_screenshot(savedata_screenshot_flag)

	#�Z�[�u�f�[�^�p�̃X�N���[���V���b�g
	if savedata_screenshot_flag == 1 then

		Window.get_screen_shot("DATA/SAVE/savedata.png", format=FORMAT_PNG)
		return savedata_screenshot_flag = 0
	end
end

#�Z�[�u�f�[�^�p�X�N���[���V���b�g�̓Ǎ�
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

#�Z�[�u�f�[�^�̃��[�h
def savedata_load(number, messagebox)
	
	#�Z�[�u�f�[�^�̗L���`�F�b�N
	if File.exist?("DATA/SAVE/savedata#{number}.png") then
		Flag.set(File.open("DATA/SAVE/savedata#{number}_flag.txt", "r").read.to_i)
		Lineno.set(File.open("DATA/SAVE/savedata#{number}_lineno.txt", "r").read.to_i)
		puts Flag.ref
		puts Lineno.ref
	else
		messagebox.Popup("�Z�[�u�f�[�^#{number}�͂���܂���I", 0, "�_�݊��", 1 + 48 )
	end
end

#�Z�[�u�f�[�^�ɃZ�[�u
def savedata_save(number, lineno)

	#���[�g�Ǘ��ϐ��̏������݁i�Z�[�u�f�[�^�̏�������)
	File.write("DATA/SAVE/savedata#{number}_flag.txt", Flag.ref.to_s)
	File.write("DATA/SAVE/savedata#{number}_lineno.txt", lineno.to_s)
	File.rename("DATA/SAVE/savedata.png", "DATA/SAVE/savedata#{number}.png")
end

#�Z�[�u�f�[�^���폜
def savedata_delete(number, messagebox)

	#�Z�[�u�f�[�^�̗L���`�F�b�N
	if File.exist?("DATA/SAVE/savedata#{number}.png") then
		#�Z�[�u�f�[�^�̍폜
		File.delete("DATA/SAVE/savedata#{number}_flag.txt")
		File.delete("DATA/SAVE/savedata#{number}_lineno.txt")
		File.delete("DATA/SAVE/savedata#{number}.png")
	else
		messagebox.Popup("�Z�[�u�f�[�^#{number}�͂���܂���I", 0, "�_�݊��", 1 + 48 )
	end
end

#�Z�[�u�f�[�^�`��p�I�u�W�F�N�g����
def savedata_object

	savedata1 =  Sprite.new(100, 300, Image.new(250, 30, C_DEFAULT))
	savedata2 =  Sprite.new(100, 350, Image.new(250, 30, C_DEFAULT))
	savedata3 =  Sprite.new(100, 400, Image.new(250, 30, C_DEFAULT))
	back = Sprite.new(100, 450, Image.new(200, 300, C_DEFAULT))

	return savedata1, savedata2, savedata3, back
end

#���j���[��ʂ̕`�惁�\�b�h
def savedata_menu_draw(font, mouse, savedata1, savedata2, savedata3, back)

	#���[�h�p�I�u�W�F�N�g
	savedata1.draw
	savedata2.draw
	savedata3.draw
	mouse.draw

	#�e��Q�[�����j���[�̕`��
	Window.draw_font(100, 300, "�Z�[�u�f�[�^�P", font)
	Window.draw_font(100, 350, "�Z�[�u�f�[�^�Q", font)
	Window.draw_font(100, 400, "�Z�[�u�f�[�^�R", font)
	Window.draw_font(100, 450, "BACK", font)
end

#�Z�[�u�f�[�^���j���[�`��̐؂�ւ�
def select_savedata_switch(messagebox, string, num, lineno)

	#���N���b�N���ɃZ�[�u/���[�h/�폜
	if Input.mouse_push?(M_LBUTTON) then
		if messagebox.Popup("�Z�[�u�f�[�^#{num}��#{string}���܂����H", 0, "�_�݊��", 4 + 32 ) == 6 then
			if string == "���[�h" then
				savedata_load(num, messagebox)
			elsif string == "�Z�[�u" then
				savedata_save(num, lineno)
			else
				savedata_delete(num, messagebox)
			end
		end
	end
end

#�Z�[�u���j���[�p������̃Z�b�g
def savedata_string_set(number)

	if number == 1 then
		string = "���[�h"
	elsif number == 0 then
		string = "�Z�[�u"
	else
		string = "�폜"
	end

	return string
end

#savedata_menu���\�b�h�̒�`
def savedata_menu(font, mouse, messagebox, number, lineno)
	
	#�e��`��p�I�u�W�F�N�g����
	savedata1, savedata2, savedata3, back = savedata_object
	savedata1_screenshot, savedata2_screenshot, savedata3_screenshot = savedata_screenshot_load
	string = savedata_string_set(number)
	
	temp_flag = Flag.ref

	#�`�惋�[�v
	Window.loop do

		#�}�E�X�ʒu�̎擾
		mouse.x, mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

		#�Z�[�u�f�[�^�����̃��j���[�`��
		savedata_menu_draw(font, mouse, savedata1, savedata2, savedata3, back)

		case mouse

			when savedata1
				#�Z�[�u�f�[�^�摜�̕`��
				Window.draw_scale(100, -100, savedata1_screenshot, 0.5, 0.5, 1)

				select_savedata_switch(messagebox, string, 1, lineno)

			when savedata2
				#�Z�[�u�f�[�^�摜�̕`��
				Window.draw_scale(100, -100, savedata2_screenshot, 0.5, 0.5, 1)

				select_savedata_switch(messagebox, string, 2, lineno)

			when savedata3
				#�Z�[�u�f�[�^�摜�̕`��
				Window.draw_scale(100, -100, savedata3_screenshot, 0.5, 0.5, 1)

				select_savedata_switch(messagebox, string, 3, lineno)

			when back
				if Input.mouse_push?(M_LBUTTON) then
					break
				end
		end

		#���[�h�����ꍇ�̏���
		if temp_flag != Flag.ref then
			break
		end

		#�G�X�P�[�v�L�[�ŏI��
		exit_message(messagebox)
	end
end
