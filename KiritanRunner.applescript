-- 
-- KiritanRunner for Mac
-- 
-- ì‚Á‚½l: https://twitter.com/kdmn
-- ”z•zêŠ: https://github.com/kidmin/KiritanRunnerForMac
-- 
-- y‰Šúİ’èz
--   (1) ‚±‚Ìƒtƒ@ƒCƒ‹‚ğA Run.sh ‚Æ“¯‚¶êŠ‚É’u‚«‚Ü‚·
--   (2) Run.sh ‚ğƒeƒLƒXƒgƒGƒfƒBƒbƒgig‚¢•û‚ª•ª‚©‚ê‚Î‘¼‚ÌƒAƒvƒŠ‚Å‚à‰Âj‚ÅŠJ‚¢‚ÄA
--         BASENAME=sample1
--       ‚ğ
--         BASENAME="$1"
--       ‚É•ÏX‚µ‚Ü‚·i‚È‚é‚×‚­ƒRƒs[•ƒy[ƒXƒg‚µ‚Ä‰º‚³‚¢j
--     ¦  BASENAME= ‚ÌŒã‚ë‚Í
--          u"viShift+2j
--          u$viShift+4j
--          u1v
--          u"viShift+2j
--          ‚Ì 4 •¶š‚Å‚·
-- 
-- yg‚¢•ûz
--   (1) Run.sh ‚Æ“¯‚¶êŠ‚É‚ ‚é score ƒtƒHƒ‹ƒ_‚Ì’†‚É‚ ‚é musicxml ƒtƒHƒ‹ƒ_‚ÉA
--     MusicXML ƒtƒ@ƒCƒ‹‚ğ’u‚«‚Ü‚·iŒ³X“ü‚Á‚Ä‚¢‚éƒTƒ“ƒvƒ‹‚Å‚à“®‚«‚Ü‚·j
--     ¦ ƒtƒ@ƒCƒ‹–¼‚É”¼ŠpƒXƒy[ƒX‚ª“ü‚Á‚Ä‚¢‚é‚Æ“®‚«‚Ü‚¹‚ñ
--   (2) ‚±‚ÌƒEƒCƒ“ƒhƒE‚Ìã‚É‚ ‚é•‚¢‰EŒü‚«OŠpƒ{ƒ^ƒ“‚ğ‰Ÿ‚·‚©A
--       ƒƒjƒ…[ƒo[‚ÌuƒXƒNƒŠƒvƒgv¨uÀsv‚ğ‘I‘ğ‚µ‚Ü‚·
--   (3) ƒtƒ@ƒCƒ‹‚ğ‘I‚ÔƒEƒCƒ“ƒhƒE‚ª•\¦‚³‚ê‚é‚Ì‚ÅA
--       æ‚Ù‚Ç‚Ì MusicXML ƒtƒ@ƒCƒ‹‚ğw’è‚µ‚Ü‚·
--   (4) ƒ^[ƒ~ƒiƒ‹ƒAƒvƒŠ‚ª‹N“®‚µ‚Äˆ—‚ªn‚Ü‚è‚Ü‚·‚Ì‚Å‚µ‚Î‚ç‚­‚¨‘Ò‚¿‚­‚¾‚³‚¢
--   (5) ˆ—‚ªI‚í‚Á‚½‚çƒ^[ƒ~ƒiƒ‹ƒAƒvƒŠ‚ÌƒEƒCƒ“ƒhƒE‚ğ•Â‚¶‚Ü‚·
--   (6) Run.sh ‚Æ“¯‚¶êŠ‚É‚ ‚é output ƒtƒHƒ‹ƒ_‚Ì’†‚ÉA wav ƒtƒ@ƒCƒ‹‚ª
--     o—Í‚³‚ê‚Ä‚¢‚Ü‚·
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
	display dialog "KiritanRunner ‚Æ“¯‚¶êŠ‚É score/musicxml ƒtƒHƒ‹ƒ_‚ªŒ©‚Â‚©‚è‚Ü‚¹‚ñ‚Å‚µ‚½B README ‚ğ‚²——‰º‚³‚¢B" buttons {"‚í‚©‚è‚Ü‚µ‚½"}
	return
end try

set xmlMusicDocument to choose file with prompt "MusicXML ƒtƒ@ƒCƒ‹‚ğw’è‚µ‚Ä‰º‚³‚¢" of type {FILE_EXTENSION} default location scoreDirectoryAlias without invisibles

set fileName to name of (info for xmlMusicDocument)
set fileBaseName to text 1 thru -((count (name extension of (info for xmlMusicDocument) as text)) + 2) of fileName
set fileDirectory to text 1 thru -((count fileName) + 2) of (POSIX path of xmlMusicDocument)

if (offset of " " in fileName) > 0 then
	display dialog "MusicXML ‚Ìƒtƒ@ƒCƒ‹–¼‚ÉƒXƒy[ƒX‚ªŠÜ‚Ü‚ê‚Ä‚¢‚Ü‚·B Œ»“_‚Å‚Í‚¤‚Ü‚­“®ì‚µ‚Ü‚¹‚ñB" buttons {"‚í‚©‚è‚Ü‚µ‚½"}
	return
end if


if fileDirectory does not end with SCORE_DIR_RELATIVE then
	display dialog "w’è‚³‚ê‚½ MusicXML ƒtƒ@ƒCƒ‹‚ÌêŠ‚ª score/musicxml ƒtƒHƒ‹ƒ_‚Å‚Í‚ ‚è‚Ü‚¹‚ñB README ‚ğ‚²——‰º‚³‚¢B" buttons {"‚í‚©‚è‚Ü‚µ‚½"}
	return
end if

if scriptDirectory is not text 1 thru -((count (SCORE_DIR_RELATIVE)) + 1) of (fileDirectory) then
	display dialog "w’è‚³‚ê‚½ MusicXML ƒtƒ@ƒCƒ‹‚ª“ü‚Á‚Ä‚¢‚é score/musicxml ƒtƒHƒ‹ƒ_‚ª KiritanRunner ‚Æ“¯‚¶êŠ‚É‚ ‚è‚Ü‚¹‚ñB README ‚ğ‚²——‰º‚³‚¢B" buttons {"‚í‚©‚è‚Ü‚µ‚½"}
	return
end if

set isRunShUpdated to do shell script "cd " & quoted form of scriptDirectory & "; grep -q -F 'BASENAME=€"$1€"' Run.sh && echo 'ok' || true"
if isRunShUpdated is not "ok" then
	display dialog "Run.sh ‚Ì€”õ‚ª‚Å‚«‚Ä‚¢‚Ü‚¹‚ñB README ‚ğ‚²——‰º‚³‚¢B" buttons {"‚í‚©‚è‚Ü‚µ‚½"}
	return
end if

tell application "Terminal"
	activate
	do script "cd " & quoted form of scriptDirectory & "; /bin/bash Run.sh " & quoted form of fileBaseName & "; echo; echo ˆ—‚ªI‚í‚è‚Ü‚µ‚½B‚±‚ÌƒEƒCƒ“ƒhƒE‚ğ•Â‚¶‚Ä‰º‚³‚¢B; echo" as Unicode text
end tell