@ECHO OFF
SET SHARED=shared32
SET PATH=%~dp0\%SHARED%;%PATH%
REM FPS - Frames Per Sec
REM e.g. FPS=1/2 == 1 frame each 2 sec
REM e.g. FPS=1/4 == 1 frame each 4 sec
SET FPS=2

IF "%1"=="" (
	ECHO *** MISSING VIDEO FILE
	EXIT 1
) 

SET OUT=output\%~n1
IF /I "%~2"=="/k" (
	SET FPS=key
) ELSE (
	IF NOT "%~2"=="" SET OUT=%~2
	IF /I "%~3"=="/k" SET FPS=key
)
 
IF NOT EXIST "%OUT%" MKDIR "%OUT%"
IF NOT EXIST "%OUT%\video" MKDIR "%OUT%\video"
IF NOT EXIST "%OUT%\video_web" MKDIR "%OUT%\video_web"
IF NOT EXIST "%OUT%\photos" MKDIR "%OUT%\photos"
IF NOT EXIST "%OUT%\large" MKDIR "%OUT%\large"
IF NOT EXIST "%OUT%\thumb" MKDIR "%OUT%\thumb"

IF /I "%FPS%"=="key" (
	ffmpeg -i %1 -filter:v select="eq(pict_type\,I)" -vsync 0 "%OUT%\photos\%%05d.png"
) ELSE (
	ffmpeg -i %1 -filter:v fps="%FPS%" -vsync 0 -qscale:v 0 "%OUT%\photos\%%05d.png"
)

SET TMP_MPC=%TMP%\frame.mpc
 
FOR %%F IN ("%OUT%\photos\?????.png") DO (
	ECHO * RESCALING %%F
    convert -quiet -regard-warnings "%%F" +repage %TMP_MPC%
	convert -resize 640 %TMP_MPC% "%OUT%\large\%%~nF.png"
	convert -resize 250 %TMP_MPC% "%OUT%\thumb\%%~nF.png"
)

COPY %1 "%OUT%\video"
IF NOT "%~p1"=="%~p0test\" DEL /F /Q "%1"
