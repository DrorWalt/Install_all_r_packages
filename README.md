# Install_all_R_packages

This script is aimed at installing packages on a new machine - based on past scripts.

The function searchs a drive for all R files. It then extracts all libraries ever used in these scripts.
This list is compared to currently installed packages (using setDiff) and the install.packages command installs only packages that are not currently installed.
