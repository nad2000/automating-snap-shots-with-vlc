SET SHARED=shared32
SET PATH=%CD%\%SHARED%;%PATH%

ffmpeg -skip_frame nokey -i %1 -filter:v select="eq(pict_type\,I)" -vsync 0 %2\%%06d.png

SET TMP_MPC=%TMP%\frame.mpc
MKDIR /F 
FOR %%F IN (%2\??????.png) DO (
    convert -quiet -regard-warnings %%F +repage %TMP_MPC%
	convert -scale 50%% %TMP_MPC% %%~dpF%%~nF_m.png
	convert -scale 5%% %TMP_MPC% %%~dpF%%~nF_t.png
)
