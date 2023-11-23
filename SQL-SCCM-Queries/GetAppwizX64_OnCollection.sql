USE SCCM_DBName
select distinct 

FCM.Name as 'Resource Name',

appwiz64.DisplayName0 as 'Installed Application (x64) DisplayName',
appwiz64.Publisher0 as 'Installed Application (x64) Publisher',
appwiz64.Version0 as 'Installed Application (x64) Version',
appwiz64.InstallDate0 as 'Installed Application (x64) Install Date'

from v_FullCollectionMembership FCM
left join v_GS_ADD_REMOVE_PROGRAMS_64 appwiz64 on appwiz64.ResourceID = FCM.ResourceID


where FCM.CollectionID = 'CollectionID'

order by FCM.Name