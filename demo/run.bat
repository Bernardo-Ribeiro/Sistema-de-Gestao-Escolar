@echo off
echo ====================================
echo  Sistema de Gestao Escolar - EduGestao
echo ====================================
echo.
echo Limpando cache do Jetty...
if exist target\tmp rmdir /s /q target\tmp 2>nul
if exist target\work rmdir /s /q target\work 2>nul
if exist target\classes\org\apache\jsp rmdir /s /q target\classes\org\apache\jsp 2>nul
echo Cache limpo!
echo.
echo Iniciando servidor Jetty...
echo Acesse: http://localhost:9090/sge/login
echo Login: admin / admin123
echo.
mvn jetty:run
