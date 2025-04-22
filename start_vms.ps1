################################
## TITLE: start_vms
### AUTHOR: Boardleash (Derek)
#### DATE: Monday, April 21 2025
###################################

# This is a Powershell script that will start VMs managed by VboxManage

# Variables and Formatting
set-alias -name vbox -value 'c:\program files\oracle\virtualbox\vboxmanage.exe'

# METHOD 1: Run the vbox alias command in separate lines on each host
#vbox startvm vm1 --type headless
#vbox startvm vm2 --type headless
#vbox startvm vm3 --type headless

# METHOD 2: Use a 'for' loop to run the vbox alias against the list of hosts
#$vmhosts=@('vm1','vm2','vm3','vm4')
#$vmhosts | foreach-object {
#  vbox startvm $_ --type headless
#}

# METHOD 3: Start a specific host based on user input
$vmhost=read-host -prompt "Enter VM name to start"
vbox startvm $vmhost --type headless

# EOF