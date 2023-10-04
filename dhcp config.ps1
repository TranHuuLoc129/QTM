

Install-WindowsFeature -Name DHCP -IncludeManagementTools

Add-DhcpServerInDC -DnsName dhcp01.labtdtu.com -IPAddress 192.168.1.2

#kiem tra lai => Get-DhcpServerInDC

Add-DhcpServerv4Scope -Name LAN_A -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -LeaseDuration 02:00:00 -State Active

#kiem tra lai => Get DhcpServerv4Scope

Set-DhcpServerv4OptionValue -ScopeId 192.168.1.0 -DnsDomain labtdtu.com -DnsServer 192.168.1.2 -Router 192.168.1.1

Add-DhcpServerv4ExclusionRange -ScopeId 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.100