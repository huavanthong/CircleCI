#!/bin/bash

RobotFrameworkVersion="maunau build"
# Định nghĩa hàm để thêm dòng vào file
add_line_to_file() {
    echo "$1" >> version.txt
}

function generate_version_info() {

	add_line_to_file "Installer version:"
	add_line_to_file "********************"
	add_line_to_file "RobotFramework AIO (OSS)  ${RobotFrameworkVersion}"
	add_line_to_file ""
	add_line_to_file "Web sites:"
	add_line_to_file "********************"
	add_line_to_file "RobotFramework AIO Tool full version:"
	add_line_to_file "    https://htmlpreview.github.io/?https://github.com/test-fullautomation/robotframework-documentation/blob/develop/RobotFrameworkAIO/Components.html"
	add_line_to_file ""
	add_line_to_file "RobotFramework AIO repository:"
	add_line_to_file "    https://github.com/test-fullautomation/RobotFramework_AIO"
	add_line_to_file ""
	add_line_to_file "Author:"
	add_line_to_file "********************"
	add_line_to_file "Thomas Pollerspöck <Pollerspoeck@de.bosch.com>"
}

generate_version_info
