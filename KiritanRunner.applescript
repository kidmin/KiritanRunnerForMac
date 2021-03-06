-- 
-- KiritanRunner for Mac
-- 
-- 作った人: https://twitter.com/kdmn
-- 配布場所: https://github.com/kidmin/KiritanRunnerForMac
-- 
-- UTF-16LEにするための文字です。消さないで下さい: --> 🎼 <--
-- 
-- 【初期設定】
--   (1) このファイルを、 Run.sh と同じ場所に置きます
--   (2) Run.sh をテキストエディット（使い方が分かれば他のアプリでも可）で開いて、
--         BASENAME=sample1
--       を
--         BASENAME="$1"
--       に変更します（なるべくコピー＆ペーストして下さい）
--     ※  BASENAME= の後ろは
--          「"」（Shift+2）
--          「$」（Shift+4）
--          「1」
--          「"」（Shift+2）
--          の 4 文字です
-- 
-- 【使い方】
--   (1) Run.sh と同じ場所にある score フォルダの中にある musicxml フォルダに、
--     MusicXML ファイルを置きます（元々入っているサンプルでも動きます）
--     ※ ファイル名に半角スペースが入っていると動きません
--   (2) このウインドウの上にある黒い右向き三角ボタンを押すか、
--       メニューバーの「スクリプト」→「実行」を選択します
--   (3) ファイルを選ぶウインドウが表示されるので、
--       先ほどの MusicXML ファイルを指定します
--   (4) ターミナルアプリが起動して処理が始まりますのでしばらくお待ちください
--   (5) 処理が終わったらターミナルアプリのウインドウを閉じます
--   (6) Run.sh と同じ場所にある output フォルダの中に、 wav ファイルが
--     出力されています
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
	display dialog "KiritanRunner と同じ場所に score/musicxml フォルダが見つかりませんでした。 README をご覧下さい。" buttons {"わかりました"}
	return
end try

set xmlMusicDocument to choose file with prompt "MusicXML ファイルを指定して下さい" of type {FILE_EXTENSION} default location scoreDirectoryAlias without invisibles

set fileName to name of (info for xmlMusicDocument)
set fileBaseName to text 1 thru -((count (name extension of (info for xmlMusicDocument) as text)) + 2) of fileName
set fileDirectory to text 1 thru -((count fileName) + 2) of (POSIX path of xmlMusicDocument)

if (offset of " " in fileName) > 0 then
	display dialog "MusicXML のファイル名にスペースが含まれています。 現時点ではうまく動作しません。" buttons {"わかりました"}
	return
end if


if fileDirectory does not end with SCORE_DIR_RELATIVE then
	display dialog "指定された MusicXML ファイルの場所が score/musicxml フォルダではありません。 README をご覧下さい。" buttons {"わかりました"}
	return
end if

if scriptDirectory is not text 1 thru -((count (SCORE_DIR_RELATIVE)) + 1) of (fileDirectory) then
	display dialog "指定された MusicXML ファイルが入っている score/musicxml フォルダが KiritanRunner と同じ場所にありません。 README をご覧下さい。" buttons {"わかりました"}
	return
end if

set isRunShUpdated to do shell script "cd " & quoted form of scriptDirectory & "; grep -q -F 'BASENAME=\"$1\"' Run.sh && echo 'ok' || true"
if isRunShUpdated is not "ok" then
	display dialog "Run.sh の準備ができていません。 README をご覧下さい。" buttons {"わかりました"}
	return
end if

tell application "Terminal"
	activate
	do script "cd " & quoted form of scriptDirectory & "; /bin/bash Run.sh " & quoted form of fileBaseName & "; echo; echo 処理が終わりました。このウインドウを閉じて下さい。; echo" as Unicode text
end tell