@echo off
:in
title Mapeamento de rede
mode 50,14
color 1f
cls
echo.
echo ��������������������������������������������������
echo      MAPEAMENTO DE REDES (Por: Lucas | lucas_developer@tutamail.com)
echo --------------------------------------------------
echo  ����������������������������Ŀ
echo  ������������������������������
echo __________________________________________________
set map=0
echo >"%temp%\0"
set /p map=N�mero de mapeamentos: 
if exist "%temp%\%map%" (
echo msgbox"Digite a quantidade de mapeamentos que deseja criar" ,vbcritical, "Mapa de Rede" > "%temp%\msg.vbs"
start %temp%\msg.vbs & goto in
)
set /a num=%map%+%map%
if %num% == 0 (
echo msgbox"Digite somente n�meros" ,vbcritical, "Mapa de Rede" > "%temp%\msg.vbs
start %temp%\msg.vbs & goto in
)

setlocal enabledelayedexpansion
set cont=0
set server=%userdomain%
echo @echo off > "Map.bat"

for /l %%R in (1,1,%map%) do (
cls
mode 50,14
title Mapeamento [%%R de %map%]
color 1f
rem NOME DO SERVIDOR
echo.
echo ��������������������������������������������������
echo  NOME OU IP DO SERVIDOR NA REDE  Mapeamento [%%R]
echo --------------------------------------------------
echo  ������������������������������������������Ŀ
echo  � SERVIDOR PADR�O: !server! 
echo  ������������������������������������������Ŀ
echo       PRESSIONE [ENTER] PARA USAR PADR�O    �
echo  �------------------------------------------�
echo  �
set /p server=.�- 

rem PASTA COMPARTILHADA
:compart
cls
echo.
echo ��������������������������������������������������
echo  PASTA COMPARTILHADA EM REDE     Mapeamento [%%R]
echo --------------------------------------------------
echo  ������������������������������������������Ŀ
echo  � SERVIDOR: !server!
echo  ������������������������������������������Ŀ
echo         DIGITE O NOME DA PASTA ABAIXO       �
echo  �------------------------------------------�
echo  �
set pasta=0
set /p pasta=.�- 
if !pasta! == 0 (
echo msgbox"Digite o caminho da pasta compartilhada no servidor: !server!" ,vbexclamation, "Mapa de Rede" > "%temp%\msg.vbs
start %temp%\msg.vbs & goto compart
)

rem NOME DO COMPARTILHAMENTO
cls
set drive=Unidade Rede
echo.
echo ��������������������������������������������������
echo  NOME DO COMPARTILHAMENTO        Mapeamento [%%R]
echo --------------------------------------------------
echo  ������������������������������������������Ŀ
echo  � PADR�O: !drive! 
echo  ������������������������������������������Ŀ
echo       PRESSIONE [ENTER] PARA USAR PADR�O    �
echo  �------------------------------------------�
echo  �
set /p drive=.�- 

rem LETRA DA UNIDADE
:und
cls
echo.
echo ��������������������������������������������������
echo  LETRA DA UNIDADE COMPARTILHADA  Anterior [!und!:]
echo --------------------------------------------------
echo  ������������������������������������������Ŀ
echo  � COMPARTILHAMENTO: !drive! 
echo  ������������������������������������������Ŀ
echo    DIGITE E LETRA SEM USAR DOIS PONTOS ":"  �
echo  �------------------------------------------�
echo  �
set und=0
set /p und=.�- 
if !und! == 0 (
echo msgbox"Digite uma letra para a unidade compartilhada: !drive!" ,vbexclamation, "Mapa de Rede" > %temp%\msg.vbs
start %temp%\msg.vbs & goto und
)

cls
mode 50,12
color 1f
echo.
echo ��������������������������������������������������
echo  AUT�NTICAR LOGIN E SENHA        Mapeamento [%%R]
echo --------------------------------------------------
echo   �����������������������������������������Ŀ  
echo   � PRESSIONE [ENTER] SE N�O FOR NECESS�RIO � 
echo  ������������������������������������������Ĵ
set autenticar=/USER:
set login=0
set /p login=.� LOGIN: 
if !login! == 0 (set login=!login:0=! & set autenticar=!autenticar:/USER:=!)

echo net use !und!: "\\!server!\!pasta!" !autenticar!!login! /persistent:yes ^>nul >> "Map.bat"
echo echo CreateObject("Shell.Application"^).NameSpace ("!und!:\"^).Self.Name = "!drive!" ^> "%%temp%%\RenDrive.vbs" >> "Map.bat"
echo start /wait %%temp%%\RenDrive.vbs >> "Map.bat"
echo 
)
set code=%random%
ren "Map.bat" "Map_%code%.bat"
echo msgbox"Configura��o do script [Map_%code%.bat] concluida com [%map%] mapeamentos." ,vbsystemmodal, "Mapa de Rede" > "%temp%\msg.vbs
start %temp%\msg.vbs & goto in
