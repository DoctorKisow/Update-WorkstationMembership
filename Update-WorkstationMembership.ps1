# Update-WorkstationMembership
# Copyright 2018, Dr. Matthew R. Kisow
#
# This script runs as a scheduled task and will remove any disabled
# "workstation" object(s) from the "Workstations" group and add any 
# new workstation object(s) to the "Workstations" group.

# Install the Active Directory management objects.
Import-Module ActiveDirectory

# Setting a search pattern for all disabled computer objects that are workstations and remove them from the group workstations.
Get-ADComputer -Filter "(Enabled -eq 'False') -and (OperatingSystem -Like 'Windows * Professional')" | ForEach-Object {Remove-ADPrincipalGroupMembership –Identity $_ –MemberOf Workstations –Confirm:$false}

# Setting a search pattern for all enabled computer objects that are workstations and adding them to the group workstations.
Get-ADComputer -Filter "(Enabled -eq 'True') -and (OperatingSystem -Like 'Windows * Professional')" | ForEach-Object {Add-ADPrincipalGroupMembership -Identity $_ -MemberOf Workstations}
