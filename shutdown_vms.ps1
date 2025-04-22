################################
## TITLE: shutdown_vms
### AUTHOR: Boardleash (Derek)
#### DATE: Monday, April 21 2025
###################################

# This is a Powershell script that will shutdown VMs managed by VboxManage

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