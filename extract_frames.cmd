SET SHARED=shared32
SET PATH=%CD%\%SHARED%;%PATH%

IF "%1"=="" (
	ECHO *** MISSING VIDEO FILE
	EXIT 1
) 

IF "%2"=="" (
	ECHO *** MISSING TARGET DIRECTORY
	EXIT 2
)
 
IF NOT EXIST %2 MKDIR %2

ffmpeg -i %1 -filter:v fps="1/2" -vsync 0 -qscale:v 0 %2\%%06d.png

SET TMP_MPC=%TMP%\frame.mpc
MKDIR /F
 
FOR %%F IN (%2\??????.png) DO (
    convert -quiet -regard-warnings %%F +repage %TMP_MPC%
	convert -scale 50%% %TMP_MPC% %%~dpFm_%%~nF.png
	convert -scale 5%% %TMP_MPC% %%~dpFt_%%~nF.png
)
