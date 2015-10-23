SET ZIP="C:\Program Files\7-Zip\7z.exe"
FOR /f %%A IN ('powershell -Command "Get-Date -format yyyyMMdd"') DO SET TS=%%A
IF "%1"=="/p" (
	%ZIP% a -y extract_frames_%TS%.7z extract_frames.cmd
) ELSE (
	%ZIP% a -y %TS%.7z shared32 extract_frames.cmd
)
