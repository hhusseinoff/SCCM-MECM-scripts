USE SCCM_DBName
select distinct 

FCM.Name as 'Machine Name',
ldisk.Name0 as 'Drive Letter',
ldisk.FreeSpace0 / 1000 as 'Free Disk Space On C, GB',
cpu.NumberOfCores0 as 'CPU Core Count',
ram.TotalPhysicalMemory0 /1000 /1000 as 'Total Memory (GB)',
s.BuildExt as 'OS Build version',

case
    when s.BuildExt IN ('6.3.9600.21075', '10.0.20348.1850', '10.0.17763.4645', '10.0.14393.6085') then 'Compliant'
    else 'Non-compliant'
end 'Patch Compliance State'


from v_FullCollectionMembership FCM
left join v_GS_LOGICAL_DISK ldisk on ldisk.ResourceID = FCM.ResourceID
left join v_GS_PROCESSOR cpu on cpu.ResourceID = FCM.ResourceID
left join v_GS_X86_PC_MEMORY ram on ram.ResourceID = FCM.ResourceID
left join v_R_System s on s.ResourceID = FCM.ResourceID

where FCM.CollectionID = 'ZON000F1'  and ldisk.Name0 = 'C:'

order by [Free Disk Space On C, GB] asc

