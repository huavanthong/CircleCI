@echo off

rem Chạy script Python và ghi log ra output.txt
tee output.txt 2>&1 | python hello.py 

rem Lấy exit code của lần chạy trước đó
echo " HELLLO"


set /a "exit_code=%errorlevel%"

echo %exit_code%

rem Kiểm tra mã lỗi
echo " HELLLO2"
if %exit_code% == 1 (
    echo " HELLLO4"
    echo Error occurred
)
echo " HELLLO3"

rem Kết thúc script với mã lỗi mặc định (0) nếu không có lỗi
exit /b 0

