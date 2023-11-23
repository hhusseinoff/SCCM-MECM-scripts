USE SCCM_DBName
select distinct 

FCM.Name as 'Resource Name',

appwiz32.DisplayName0 as 'Installed Application (x86) DisplayName',
appwiz32.Publisher0 as 'Installed Application (x86) Publisher',
appwiz32.Version0 as 'Installed Application (x86) Version',
appwiz32.InstallDate0 as 'Installed Application (x86) Install Date'

from v_FullCollectionMembership FCM

left join v_GS_ADD_REMOVE_PROGRAMS appwiz32 on appwiz32.ResourceID = FCM.ResourceID


where FCM.CollectionID = 'ZON000AB'

order by FCM.Name