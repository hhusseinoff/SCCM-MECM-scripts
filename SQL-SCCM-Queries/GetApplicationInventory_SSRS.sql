use SCCM_DBName

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

where inst.ProductName0 like 'Microsoft SQL Server Reporting Services' and col.CollectionID = 'CollectionID'

)

union

select distinct 

s.Name0 as 'Machine Name',
s.BuildExt as 'OS Build Version',
inst.DisplayName0 as 'Product Name',
inst.Version0 as 'Product Version',
inst.Publisher0 as 'Publisher',
--inst. as 'Package Code',

--see  https://learn.microsoft.com/en-us/sql/reporting-services/release-notes-reporting-services?view=sql-server-ver16 for version numbers
case
    when  inst.Version0 = '16.0.8564.33454' and inst.DisplayName0 = 'Microsoft SQL Server Reporting Services' then 'Compliant - SSRS 2022'
	when  inst.Version0 != '16.0.8564.33454' and inst.Version0 like '16.0.%' and inst.DisplayName0 = 'Microsoft SQL Server Reporting Services' then 'Non-Compliant - SSRS 2022'
    when  inst.Version0 = '15.0.8599.29221' and inst.DisplayName0 = 'Microsoft SQL Server Reporting Services' then 'Compliant - SSRS 2019'
	when  inst.Version0 != '15.0.8599.29221' and inst.Version0 like '15.0.%' and inst.DisplayName0 = 'Microsoft SQL Server Reporting Services' then 'Non-Compliant - SSRS 2019'
    when  inst.Version0 = '14.0.601.20' and inst.DisplayName0 = 'Microsoft SQL Server Reporting Services' then 'Compliant - SSRS 2017'
	when  inst.Version0 != '14.0.601.20' and inst.Version0 like '14.0.%' and inst.DisplayName0 = 'Microsoft SQL Server Reporting Services' then 'Non-Compliant - SSRS 2017'	
	else 'Not Installed'
end status,

inst.InstallDate0 as 'Install Date'

from  v_FullCollectionMembership col

inner join v_R_System s on s.ResourceID = col.ResourceID
left join v_Add_Remove_Programs inst on inst.ResourceID = col.ResourceID

where inst.DisplayName0 like 'Microsoft SQL Server Reporting Services' and col.CollectionID = 'CollectionID'

group by s.Name0, s.BuildExt, inst.DisplayName0, inst.Version0, inst.Publisher0, inst.InstallDate0

order by [Product Version] asc