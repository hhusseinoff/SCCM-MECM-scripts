select distinct 

s.Name0 as 'Machine Name', 
s.BuildExt as 'OS Build Version',
'N/A' as 'Product Name',
'N/A' as 'Product Version',
--'N/A' as 'Publisher',
img.Build_Version0 as 'Build Version',
vda.DesktopGroupName0 'XenDesktop Delivery Group',
'N/A' as 'Package Code',
'Non-compliant' as Status

from  v_FullCollectionMembership col

left join v_R_System s on s.ResourceID = col.ResourceID
left join v_GS_ImageVersion_AVC64_2_00 img on img.ResourceID = s.ResourceID
left join v_GS_XD_VDA_640 vda on vda.ResourceID = s.ResourceID

where

col.CollectionID ='CA100B13' and col.ResourceID not in 
(

select col.ResourceID from v_FullCollectionMembership col

inner join v_GS_INSTALLED_SOFTWARE inst on inst.ResourceID = col.ResourceID

where inst.ProductName0 like 'Citrix Virtual Apps and Desktops 7 1912 LTSR CU5%' and col.CollectionID = 'CA100B13'

)

union

select distinct 

s.Name0 as 'Machine Name',
s.BuildExt as 'OS Build Version',
inst.ProductName0 as 'Product Name',
inst.ProductVersion0 as 'Product Version',
--inst.Publisher0 as 'Publisher',
img.Build_Version0 as 'Build Version',
vda.DesktopGroupName0 'XenDesktop Delivery Group',
inst.PackageCode0 as 'Package Code',


case
    when  inst.ProductVersion0 >= '16.0.15601.20456' then 'Compliant'
    else 'Non-compliant'
end status

from  v_FullCollectionMembership col

inner join v_R_System s on s.ResourceID = col.ResourceID
left join v_GS_INSTALLED_SOFTWARE inst on inst.ResourceID = col.ResourceID
left join v_GS_ImageVersion_AVC64_2_00 img on img.ResourceID = col.ResourceID
left join v_GS_XD_VDA_640 vda on vda.ResourceID = col.ResourceId

where inst.ProductName0 like 'Citrix Virtual Apps and Desktops 7 1912 LTSR CU5%' and col.CollectionID = 'CA100B13' --and vda.DesktopGroupName0 like '%ATA%'

group by s.Name0, s.BuildExt, inst.ProductName0, inst.ProductVersion0, img.Build_Version0, vda.DesktopGroupName0, inst.PackageCode0

order by [Product Version] asc







------------------------------
------------------------------
--select * from v_GS_INSTALLED_SOFTWARE where ResourceID in (select ResourceID from v_R_System where name0 = 'XPE1-D31017') and ProductName0 = 'webex'

/*

Microsoft 365 Apps for enterprise - en-us       16.0.14931.20858
Microsoft Visio Professional 2019 - en-us		16.0.14931.20858
Microsoft Project Professional 2019 - pt-pt		16.0.14931.20858
CA100B13

Adobe Acrobat Reader MUI						22.003.20282
Eclipse Temurin JRE with Hotspot%(x64)			8.0.352.8
Webex											42.6.0.23196
Cisco Webex Productivity Tools%					42.6.1.12
Veridium%										3.1.5.0
%WebView2%										108.0.1462.44
CynetEPS										4.5.5.6845
CynetEPS										4.7.0.8220
%Teams%											1.5.00.11865
												1.5.00.21463
VMWare Tools									12.1.0
AgentInstall64%

7-Zip 21.07 (x64)								21.07

Citrix Virtual Apps and Desktops 7 1912 LTSR CU5 - Virtual Delivery Agent 1912.0.5000.5174

Citrix Virtual Apps and Desktops%

%Citrix Workspace 1912%
