USE SCCM_DBName

select distinct 

FCM.Name as 'Machine Name',
ldisk.FreeSpace0 / 1000 as 'Free Disk Space On C, GB',
cpu.NumberOfCores0 as 'CPU Core Count',
ram.TotalPhysicalMemory0 /1000 /1000 as 'Total Memory (GB)',
s.BuildExt as 'OS Build version',

case
    when  s.BuildExt = '10.0.20348.2113' then 'Compliant (Server 2022)'
	when  s.BuildExt != '10.0.20348.2113' and s.BuildExt like '10.0.20348.%' then 'NON-Compliant (Server 2022)'
	when  s.BuildExt = '10.0.17763.5122' then 'Compliant (Server 2019)'
	when  s.BuildExt != '10.0.17763.5122' and s.BuildExt like '10.0.17763.%' then 'NON-Compliant (Server 2019)'
	when  s.BuildExt = '10.0.14393.6452' then 'Compliant (Server 2016)'
	when  s.BuildExt != '10.0.14393.6452' and s.BuildExt like '10.0.14393.%' then 'NON-Compliant (Server 2016)'
	when  s.BuildExt = '6.3.9600.21620' then 'Compliant (Server 2012 R2), no ESU'
	when  s.BuildExt != '6.3.9600.21620' and s.BuildExt like '6.3.9600.%' then 'NON-Compliant (Server 2012 R2)'
	when  s.BuildExt = '6.1.7601.24106' then 'Compliant (Server 2008 R2), no ESU'
	when  s.BuildExt != '6.1.7601.24106' and s.BuildExt like '6.1.7601.%' then 'NON-Compliant (Server 2008 R2)'
	when  s.BuildExt = '10.0.19044.3693' then 'Compliant (Windows 10 21H2)'
	when  s.BuildExt != '10.0.19044.3693' and s.BuildExt like '10.0.19044.%' then 'NON-Compliant (Windows 10 21H2)'
	when  s.BuildExt = '10.0.19045.3693' then 'Compliant (Windows 10 22H2)'
	when  s.BuildExt != '10.0.19045.3693' and s.BuildExt like '10.0.19045.%' then 'NON-Compliant (Windows 10 22H2)'
    else 'Invalid'
end 'Patch Compliance State'

from v_FullCollectionMembership FCM

left join v_GS_LOGICAL_DISK ldisk on ldisk.ResourceID = FCM.ResourceID and ldisk.DeviceID0 = 'C:'
left join v_GS_PROCESSOR cpu on cpu.ResourceID = FCM.ResourceID
left join v_GS_X86_PC_MEMORY ram on ram.ResourceID = FCM.ResourceID
left join v_R_System s on s.ResourceID = FCM.ResourceID

where FCM.CollectionID = 'CollectionID'

order by [Machine Name] asc

