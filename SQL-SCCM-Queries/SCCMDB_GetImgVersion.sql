select distinct 

FCM.Name as 'Machine Name',
ldisk.FreeSpace0 / 1000 as 'Free Disk Space On C, GB',
cpu.NumberOfCores0 as 'CPU Core Count',
ram.TotalPhysicalMemory0 /1000 /1000 as 'Total Memory (GB)',
s.BuildExt as 'OS Build version',
vda.DesktopGroupName0 as 'XD Delivery Group',
img.Image_Version0 as 'Image Version',

case
    when  s.BuildExt >= '10.0.19045.2364' then 'Compliant'
    else 'Non-compliant'
end 'Patch Compliance State',

case
	when img.Image_Version0 = 'PR001_23_PR023' then 'Compliant'
	else 'Non-Compliant'
end 'Image Version Compliance State'

from v_FullCollectionMembership FCM

left join v_GS_XD_VDA_640 vda on vda.ResourceID = FCM.ResourceID
left join v_GS_ImageVersion_AVC64_2_00 img on img.ResourceID = FCM.ResourceID
left join v_GS_LOGICAL_DISK ldisk on ldisk.ResourceID = FCM.ResourceID
left join v_GS_PROCESSOR cpu on cpu.ResourceID = FCM.ResourceID
left join v_GS_X86_PC_MEMORY ram on ram.ResourceID = FCM.ResourceID
left join v_R_System s on s.ResourceID = FCM.ResourceID

where FCM.CollectionID = 'CA100AC0'  --and s.Name0 = 'XPE2-D10148' --and img.Image_Version0 is NULL --and img.Image_Version0 like '%PR020%'

order by [Image Version] asc


