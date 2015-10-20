@ECHO OFF
SET SHARED=shared32
SET PATH=%~dp0\%SHARED%;%PATH%

IF "%1"=="" (
	ECHO *** MISSING VIDEO FILE
	EXIT 1
) 

IF "%2"=="" (
	ECHO *** MISSING TARGET DIRECTORY
	EXIT 2
)
 
IF NOT EXIST %2 MKDIR %2

ffmpeg -i %1 -filter:v fps="1/2" -vsync 0 -qscale:v 0 %2\%%05d.png

SET TMP_MPC=%TMP%\frame.mpc
 
FOR %%F IN (%2\?????.png) DO (
	ECHO * RESCALING %%F
    convert -quiet -regard-warnings %%F +repage %TMP_MPC%
	convert -scale 50%% %TMP_MPC% %%~dpFm_%%~nF.png
	convert -scale 5%% %TMP_MPC% %%~dpFt_%%~nF.png
)

COPY %1 %2