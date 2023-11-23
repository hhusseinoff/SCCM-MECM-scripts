Use SCCM_DBName

select distinct 

s.Name0 as 'Machine Name', 
s.BuildExt as 'OS Build Version',
'N/A' as 'Product Name',
'N/A' as 'Product Version',
'N/A' as 'Publisher',
--'N/A' as 'Package Code',
'Non-compliant' as Status,
'01/01/1900' as 'Install Date'

from  v_FullCollectionMembership FCM

left join v_R_System s on s.ResourceID = FCM.ResourceID

where

FCM.CollectionID ='CollectionID' and FCM.ResourceID not in 
(

select col.ResourceID from v_FullCollectionMembership col

left join v_GS_INSTALLED_SOFTWARE inst on inst.ResourceID = col.ResourceID

where inst.ProductName0 like 'Microsoft Azure Powershell%' and col.CollectionID = 'CollectionID'

)

union

select distinct 

s.Name0 as 'Machine Name',
s.BuildExt as 'OS Build Version',
inst.DisplayName0 as 'Product Name',
inst.Version0 as 'Product Version',
inst.Publisher0 as 'Publisher',
--inst. as 'Package Code',


case
    when  inst.Version0 >= '11.0.37632' then 'Compliant'
	when  inst.Version0 >= '11.%' and inst.Version0 < '11.0.37632' then 'Outdated'
    else 'Non-Compliant'
end status,

inst.InstallDate0 as 'Install Date'

from  v_FullCollectionMembership col

inner join v_R_System s on s.ResourceID = col.ResourceID
left join v_Add_Remove_Programs inst on inst.ResourceID = col.ResourceID

where inst.DisplayName0 like 'Microsoft Azure Powershell%' and col.CollectionID = 'CollectionID'

group by s.Name0, s.BuildExt, inst.DisplayName0, inst.Version0, inst.Publisher0, inst.InstallDate0

order by [Product Version] asc