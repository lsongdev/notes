---
layout: default
title: Microsoft Edge
parent: Windows
---

# Microsoft Edge

## NewTab

Modify newtab location to you like:

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF] 
"EnrollmentState"=dword:00000001 
"EnrollmentType"=dword:00000000 
"IsFederated"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF]
"Flags"=dword:00d6fb7f
"AcctUId"="0x000000000000000000000000000000000000000000000000000000000000000000000000"
"RoamingCount"=dword:00000000
"SslClientCertReference"="MY;User;0000000000000000000000000000000000000000"
"ProtoVer"="1.2"

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]
"NewTabPageLocation"="https://google.com"
```

<edge://policy>

![](https://assets.den.dev/images/postmedia/edge-blank-new-tab/edge-updated-new-tab.png)

+ <https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies#newtabpagelocation>