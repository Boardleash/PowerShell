###################
### WIN HARVEST ###
###################
#
# TITLE: win_harvest.ps1
# AUTHOR: Boardleash (Derek)
# DATE: Saturday, December 7 2024
#
# PowerShell script to collect various information on a host.
# Recommend to run this script wiht elevated privileges.  If not ran with elevated privileges \
# users list will not be able to be retrieved.

################################
### FORMATTING AND VARIABLES ###
################################

# Create a unique directory in the user's 'Documents' directory to hold the out-files
mkdir c:\users\$env:USERNAME\documents\win_harvest

#######################
### PNP INFORMATION ###
#######################

# Set up 'plug and play' information collection function
function pnp_usb {
	# Start a transcript to write the output to a file and place it in the user's documents directory
	start-transcript c:\users\$env:USERNAME\documents\win_harvest\pnp-usb-devices.txt

	# Get USB information from Plug and Play
	echo ""; echo "Checking for USB devices...";
	sleep 0.3; echo "The following USB devices have been found:";
	get-pnpdevice | ? Class -eq 'USB'| format-table; echo "";
	
	# Stop the transcript
	stop-transcript
}

function pnp_questionable {
	# Start a transcript to write the output to a file and place it in the user's documents directory
	start-transcript c:\users\$env:USERNAME\documents\win_harvest\pnp-questionable-devices.txt

	# Get Plug and Play information for statuses of 'Unknown' and 'Error'
	echo ""; echo "Checking for devices with statuses of 'Unknown' and/or 'Error'...";
	sleep 0.3; echo "The following have been discovered:";
	get-pnpdevice | ? Status -eq 'Unknown' | format-table;
	get-pnpdevice | ? Status -eq 'Error' | format-table; echo "";

	# Stop the transcript
	stop-transcript
}

################################
### GENERAL HOST INFORMATION ###
################################

# Set up function to collect general host information on host machine
function gather_intel {
	# Start a transcript to write the output to a file and place it in the user's documents directory
	start-transcript c:\users\$env:USERNAME\documents\win_harvest\general-intel.txt

	# Get Windows ID information and hostname from machine
	echo ""; echo "Checking for Windows Type, Product, Registered Owner and Hostname...";
	sleep 0.3; echo "The following has been collected:";
	get-computerinfo -property "WindowsInstallationType","WindowsProductId","WindowsRegisteredOwner","CsDNSHostName" | format-list;

	# Get Anti-Virus and Defender information 
	echo ""; echo "Checking if Anti-Virus and Defender is enabled...";
	sleep 0.3; echo "The following has been discovered:";
	get-mpcomputerstatus | select-object AntispywareEnabled,AntivirusEnabled,BehaviorMonitorEnabled,DefenderSignatureOutOfDate,RealTimeProtectionEnabled | format-list;

	# Get list of usernames on host
	echo ""; echo "Checking for users currently running processes...";
	sleep 0.3; echo "The following users are currently running processes:";
	get-process -includeusername | select-object -unique -property UserName | format-list; echo "";

	# Stop the transcript
	stop-transcript
}

#############################
### CONSOLIDATE FUNCTIONS ###
#############################

function main {
	pnp_usb
	pnp_questionable
	gather_intel
}

#########################
### RUN MAIN FUNCTION ###
#########################

main

# EOF