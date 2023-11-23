USE SCCM_DBName
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

where inst.ProductName0 like '%Firefox%' and col.CollectionID = 'CollectionID'

)

union

select distinct 

s.Name0 as 'Machine Name',
s.BuildExt as 'OS Build Version',
inst.ProductName0 as 'Product Name',
inst.ProductVersion0 as 'Product Version',
inst.Publisher0 as 'Publisher',
--inst. as 'Package Code',


case
    when  inst.ProductVersion0 >= '117.0.2045.35' then 'Compliant'
	when  inst.ProductVersion0 != '117.0.2045.35' and inst.ProductVersion0 like '11%' and inst.ProductVersion0 not like '109.%' then 'Non-Compliant'
	when  inst.ProductVersion0 like '109.0.1518.140' then 'Compliant (Server 2012 and 2008)'
	when  inst.ProductVersion0 != '109.0.1518.140' and inst.ProductVersion0 like '109.%' and inst.ProductVersion0 not like '11.%' then 'Non-Compliant (Server 2012 and 2008)'
    else 'Not Installed'
end status,

inst.InstallDate0 as 'Install Date'

from  v_FullCollectionMembership col

inner join v_R_System s on s.ResourceID = col.ResourceID
left join v_GS_INSTALLED_SOFTWARE inst on inst.ResourceID = col.ResourceID

where inst.ProductName0 like '%Firefox%' and col.CollectionID = 'CollectionID'

group by s.Name0, s.BuildExt, inst.ProductName0, inst.ProductVersion0, inst.Publisher0, inst.InstallDate0

order by [Product Version] asc