################################
## TITLE: shutdown_vms
### AUTHOR: Boardleash (Derek)
#### DATE: Monday, April 21 2025
###################################

# This is a Powershell script that will shutdown VMs hosted by Oracle VirtualBox
# Uncomment whichever method is preferred and substitute 'vm1', 'vm2', etc. with \
# applicable VM names (host/domain names)
# This has been tested on Powershell version 5.1.26100.3624 \
# and Oracle VirtualBox version 7.1.4 r165100 (Qt6.5.3)

# Variables and Formatting
set-alias -name vbox -value 'c:\program files\oracle\virtualbox\vboxmanage.exe'

# METHOD 1: Run the vbox alias command in separate lines on each host
#vbox controlvm vm1 poweroff
#vbox controlvm vm2 poweroff
#vbox controlvm vm3 poweroff

# METHOD 2: Use a 'for' loop to run the vbox alias against the list of hosts
#$vmhosts=@('vm1','vm2','vm3','vm4')
#$vmhosts | foreach-object {
#  vbox controlvm $_ poweroff
#}

# METHOD 3: Start a specific host based on user input
$vmhost=read-host -prompt "Enter VM name to start"
vbox controlvm $vmhost poweroff

# EOF