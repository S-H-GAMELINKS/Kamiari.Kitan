# coding: shift_jis

#�}�b�v�f�ނ̓Ǎ�
def map_load	

	#�}�b�v�摜�̓Ǎ�
	map = Sprite.new(0, 0, Image.load( "DATA/MAP/map.png"))
	ap1 = Sprite.new(120, 80, Image.load("DATA/MAP/ap.png"))
	ap2 = Sprite.new(40, 180, Image.load("DATA/MAP/ap.png"))
	ap3 = Sprite.new(160, 170, Image.load("DATA/MAP/ap.png"))
	ap4 = Sprite.new(220, 230, Image.load("DATA/MAP/ap.png"))
	ap5 = Sprite.new(200, 380, Image.load("DATA/MAP/ap.png"))
	ap6 = Sprite.new(350, 300, Image.load("DATA/MAP/ap.png"))

	#�t�H���g�T�C�Y
	map_font = Font.new(32)

	return map, ap1, ap2, ap3, ap4, ap5, ap6, map_font
end

#�e�n��(�A�N�Z�X�|�C���g)�`�惁�\�b�h
def ap_draw(string, num, font, messagebox)
	Window.draw_font(500, 200, "#{string}", font, z:2)

	#���N���b�N���̏���
	if Input.mouse_push?(M_LBUTTON) then

		#�u�͂��v�������ƏI��
		if messagebox.Popup("#{string}�ɍs���܂����H", 0, "�_�݊��", 4 + 32 ) == 6 then
			Flag.set(num)
		end
	end
end

#�}�b�v�`�惁�\�b�h(���C��)
def map(font, messagebox)

	lineno = 0
	Lineno.set(0)
	temp_flag = Flag.ref

	map, ap1, ap2, ap3, ap4, ap5, ap6, map_font = map_load()

	Input.mouse_enable=(false)

	mouse = Sprite.new(0, 0, Image.load("DATA/MAP/usagi.png"))

	#�}�b�v�`�惋�[�v
	Window.loop do

		#�}�E�X�̈ʒu���擾
		mouse.x, mouse.y = Input.mouse_x, Input.mouse_y

		#�}�b�v�̕`��&�n��(�A�N�Z�X�|�C���g)���ƃ}�E�X�̕`��
		map.draw; ap1.draw; ap2.draw; ap3.draw; ap4.draw; ap5.draw; ap6.draw; mouse.draw

		#�e�n��(�A�N�Z�X�|�C���g)�Ƀ}�E�X���ڐG����ƒn���`��
		case mouse

			when ap1
				ap_draw("����ꓔ��", 5, font, messagebox)

			when ap2
				ap_draw("��̕l", 4, font, messagebox)

			when ap3
				ap_draw("�o�_���", 2, font, messagebox)

			when ap4
				ap_draw("����Љw", 3, font, messagebox)

			when ap5
				ap_draw("�{���_��", 7, font, messagebox)

			when ap6
				ap_draw("���v�b��", 6, font, messagebox)
		end

		#�n���i�A�N�Z�X�|�C���g�j�̕`��
		Window.draw_font(500, 450, "�o�_�̚�", font, z:2)

		#�Q�[�����j���[�Ăяo��
		gamemenu_call(messagebox, font, mouse, lineno); Input.mouse_enable=(true)

		#�Z�[�u�f�[�^�ǂݍ��ݎ��̏���(flag�ϐ����قȂ�ꍇ)
		if  Flag.ref != 11 then
			puts Flag.ref
			break
		end

		#@@flag��99�̏ꍇ�^�C�g���ɖ߂�
		if Flag.ref == 99 then
			break
		end

		#�G�X�P�[�v�L�[�ŏI��
		exit_message(messagebox)
	end
end
