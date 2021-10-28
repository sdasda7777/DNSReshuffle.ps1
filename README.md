# DNSReshuffle.ps1
Finds first two reachable addresses from a list, sets them as main and backup DNS server respectively.

# Preparations for running
- Open DNSReshuffle.ps1 file in your preferred text editor.
- Change the variable INTERFACE_INDEX to index of the interface you want the script to change settings of. 
- Change the variable DNS_IPS to a list of your preferred DNS servers in order of preference (most desirable first).

# How to run
Run the script file as administrator

## The simpler way
- Open Start menu, type "windows powershell", right click first option, select "Run as administrator". 
- Navigate to location of your file using commands cd and ls (Or just enter "cd ABSOLUTE_PATH" where ABSOLUTE_PATH is absolute path to folder in which the DNSReshuffle.ps1 script lies). 
- Run DNSReshuffle by entering ".\DNSReshuffle.ps1".

Your DNS settings are now changed (if two reachable hosts were found).

## The power-user way
- Go to the folder "C:\Windows\System32\WindowsPowerShell\v1.0", duplicate powershell.exe, rename the copy to powershell_admin.exe. 
- Open regedit.exe, navigate to "HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\". 
- Add new key named "Run with PowerShell (Admin)". Add new key to it named "Command". Change its value to ""C:\Windows\System32\WindowsPowerShell\v1.0\powershell_admin.exe" "-NoExit"  "-Command" "if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy -Scope Process Bypass }; & '%1'"" (without the first and the last double quote). 

You can now you can launch any PowerShell script as an admin from your context menu (the right click menu).
