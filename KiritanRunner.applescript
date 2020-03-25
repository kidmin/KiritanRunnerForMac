-- 
-- KiritanRunner for Mac
-- 
-- ������l: https://twitter.com/kdmn
-- �z�z�ꏊ: https://github.com/kidmin/KiritanRunnerForMac
-- 
-- �y�����ݒ�z
--   (1) ���̃t�@�C�����A Run.sh �Ɠ����ꏊ�ɒu���܂�
--   (2) Run.sh ���e�L�X�g�G�f�B�b�g�i�g������������Α��̃A�v���ł��j�ŊJ���āA
--         BASENAME=sample1
--       ��
--         BASENAME="$1"
--       �ɕύX���܂��i�Ȃ�ׂ��R�s�[���y�[�X�g���ĉ������j
--     ��  BASENAME= �̌���
--          �u"�v�iShift+2�j
--          �u$�v�iShift+4�j
--          �u1�v
--          �u"�v�iShift+2�j
--          �� 4 �����ł�
-- 
-- �y�g�����z
--   (1) Run.sh �Ɠ����ꏊ�ɂ��� score �t�H���_�̒��ɂ��� musicxml �t�H���_�ɁA
--     MusicXML �t�@�C����u���܂��i���X�����Ă���T���v���ł������܂��j
--     �� �t�@�C�����ɔ��p�X�y�[�X�������Ă���Ɠ����܂���
--   (2) ���̃E�C���h�E�̏�ɂ��鍕���E�����O�p�{�^�����������A
--       ���j���[�o�[�́u�X�N���v�g�v���u���s�v��I�����܂�
--   (3) �t�@�C����I�ԃE�C���h�E���\�������̂ŁA
--       ��قǂ� MusicXML �t�@�C�����w�肵�܂�
--   (4) �^�[�~�i���A�v�����N�����ď������n�܂�܂��̂ł��΂炭���҂���������
--   (5) �������I�������^�[�~�i���A�v���̃E�C���h�E����܂�
--   (6) Run.sh �Ɠ����ꏊ�ɂ��� output �t�H���_�̒��ɁA wav �t�@�C����
--     �o�͂���Ă��܂�
-- 

set FILE_EXTENSION to "musicxml" as Unicode text
set SCORE_DIR_RELATIVE to "/score/musicxml" as Unicode text

set scriptPath to path to me
set scriptFileName to name of (info for scriptPath)
set scriptDirectory to text 1 thru -((count scriptFileName) + 2) of (POSIX path of scriptPath)

set scoreDirectory to scriptDirectory & SCORE_DIR_RELATIVE
try
	set scoreDirectoryAlias to (POSIX file scoreDirectory) as alias
on error
	display dialog "KiritanRunner �Ɠ����ꏊ�� score/musicxml �t�H���_��������܂���ł����B README �������������B" buttons {"�킩��܂���"}
	return
end try

set xmlMusicDocument to choose file with prompt "MusicXML �t�@�C�����w�肵�ĉ�����" of type {FILE_EXTENSION} default location scoreDirectoryAlias without invisibles

set fileName to name of (info for xmlMusicDocument)
set fileBaseName to text 1 thru -((count (name extension of (info for xmlMusicDocument) as text)) + 2) of fileName
set fileDirectory to text 1 thru -((count fileName) + 2) of (POSIX path of xmlMusicDocument)

if (offset of " " in fileName) > 0 then
	display dialog "MusicXML �̃t�@�C�����ɃX�y�[�X���܂܂�Ă��܂��B �����_�ł͂��܂����삵�܂���B" buttons {"�킩��܂���"}
	return
end if


if fileDirectory does not end with SCORE_DIR_RELATIVE then
	display dialog "�w�肳�ꂽ MusicXML �t�@�C���̏ꏊ�� score/musicxml �t�H���_�ł͂���܂���B README �������������B" buttons {"�킩��܂���"}
	return
end if

if scriptDirectory is not text 1 thru -((count (SCORE_DIR_RELATIVE)) + 1) of (fileDirectory) then
	display dialog "�w�肳�ꂽ MusicXML �t�@�C���������Ă��� score/musicxml �t�H���_�� KiritanRunner �Ɠ����ꏊ�ɂ���܂���B README �������������B" buttons {"�킩��܂���"}
	return
end if

set isRunShUpdated to do shell script "cd " & quoted form of scriptDirectory & "; grep -q -F 'BASENAME=�"$1�"' Run.sh && echo 'ok' || true"
if isRunShUpdated is not "ok" then
	display dialog "Run.sh �̏������ł��Ă��܂���B README �������������B" buttons {"�킩��܂���"}
	return
end if

tell application "Terminal"
	activate
	do script "cd " & quoted form of scriptDirectory & "; /bin/bash Run.sh " & quoted form of fileBaseName & "; echo; echo �������I���܂����B���̃E�C���h�E����ĉ������B; echo" as Unicode text
end tell