# encoding: shift_jis

#�I�����b�Z�[�W�{�b�N�X
def exit_message(messagebox)

	#�G�X�P�[�v�L�[�ŏI��
	if Input.key_push?(K_ESCAPE) then

		#�u�͂��v�������ƏI��
		if messagebox.Popup("�Q�[�����I�����I�����܂����H", 0, "�_�݊��", 4 + 32 ) == 6 then
			exit
		end
	end
end