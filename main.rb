# encoding: shift_jis

#�w�b�_�[�̓Ǎ�
require_relative 'SYSTEM/header'

#�^�C�g����
Window.caption=("�_�݊��")

#�}�E�X�|�C���^�쐬
mouse = Sprite.new(0, 0, Image.new(10, 10, C_DEFAULT))

#�t�H���g�T�C�Y�̎w��
font = Font.new(26)

#���b�Z�[�W�{�b�N�X����
messagebox = WIN32OLE.new('WScript.Shell')

#���[�g�Ǘ��ϐ�
Flag.set(99)

def ScriptRoot(font, messagebox, mouse)
	script = Script.new
	script.read
	script.draw(font, messagebox, mouse)
end

#���C�����[�v
Window.loop do

	case Flag.ref

		#�^�C�g�����
		when 99
			title(mouse, font, messagebox)

		#�}�b�v�̕`��
		when 11
			map(font, messagebox)

		#�e���[�g�̕`��
		else
			ScriptRoot(font, messagebox, mouse)
	end
end
