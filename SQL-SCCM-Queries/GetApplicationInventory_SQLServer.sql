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

where inst.ProductName0 like 'Microsoft SQL Server%Setup (English)' and col.CollectionID = 'CollectionID'

)

union

select distinct 

s.Name0 as 'Machine Name',
s.BuildExt as 'OS Build Version',
inst.DisplayName0 as 'Product Name',
inst.Version0 as 'Product Version',
inst.Publisher0 as 'Publisher',
--inst. as 'Package Code',

--see  https://learn.microsoft.com/en-us/troubleshoot/sql/releases/download-and-install-latest-updates for version numbers
case
    when  inst.Version0 >= '16.0.4095.4' and inst.DisplayName0 = 'Microsoft SQL Server 2022 Setup (English)' then 'Compliant - SQL 2022 CU10'
	when  inst.Version0 != '16.0.4095.4' and inst.DisplayName0 = 'Microsoft SQL Server 2022 Setup (English)' then 'Non-Compliant - SQL 2022'
    when  inst.Version0 >= '15.0.4335.1' and inst.DisplayName0 = 'Microsoft SQL Server 2019 Setup (English)' then 'Compliant - SQL 2019 CU23'
	when  inst.Version0 != '15.0.4335.1' and inst.DisplayName0 = 'Microsoft SQL Server 2019 Setup (English)' then 'Non-Compliant - SQL 2019'
    when  inst.Version0 = '14.0.3465.1' and inst.DisplayName0 = 'Microsoft SQL Server 2017 Setup (English)' then 'Compliant - SQL 2017 CU31+GDR'
	when  inst.Version0 = '14.0.3456.2' and inst.DisplayName0 = 'Microsoft SQL Server 2017 Setup (English)' then 'Compliant - SQL 2017 CU31'
	when  inst.Version0 != '14.0.3460.9' and inst.Version0 != '14.0.3456.2' and inst.DisplayName0 = 'Microsoft SQL Server 2017 Setup (English)' then 'Non-Compliant - SQL 2017'
	when  inst.Version0 = '13.0.7029.3' and inst.DisplayName0 = 'Microsoft SQL Server 2016 Setup (English)' then 'Compliant - SQL 2016 SP3 Azure Connect GDR'
	when  inst.Version0 != '13.0.7029.3' and inst.DisplayName0 = 'Microsoft SQL Server 2016 Setup (English)' then 'Non-Compliant - SQL 2016'
	when  inst.Version0 = '12.0.6449.1' and inst.DisplayName0 = 'Microsoft SQL Server 2014 Setup (English)' then 'Compliant - SQL 2014 SP3 CU4 + GDR'
	when  inst.Version0 != '12.0.6449.1' and inst.DisplayName0 = 'Microsoft SQL Server 2014 Setup (English)' then 'Non-Compliant - SQL 2014'
	when  inst.Version0 = '11.0.7512.11' and inst.DisplayName0 = 'Microsoft SQL Server 2012 Setup (English)' then 'Compliant - SQL 2012 SP4 GDR'
	when  inst.Version0 != '11.0.7512.11' and inst.DisplayName0 = 'Microsoft SQL Server 2012 Setup (English)' then 'Non-Compliant - SQL 2012'    
	when  inst.Version0 = '10.50.6785.2' and inst.DisplayName0 = 'Microsoft SQL Server 2008 R2 Setup (English)' then 'Compliant - SQL 2008 R2 SP3 GDR'
	when  inst.Version0 != '10.50.6785.2' and inst.DisplayName0 = 'Microsoft SQL Server 2008 R2 Setup (English)' then 'Non-Compliant - SQL 2008 R2'  	
	else 'Not Installed'
end status,

inst.InstallDate0 as 'Install Date'

from  v_FullCollectionMembership col

inner join v_R_System s on s.ResourceID = col.ResourceID
left join v_Add_Remove_Programs inst on inst.ResourceID = col.ResourceID

where inst.DisplayName0 like 'Microsoft SQL Server%Setup (English)' and col.CollectionID = 'CollectionID'

group by s.Name0, s.BuildExt, inst.DisplayName0, inst.Version0, inst.Publisher0, inst.InstallDate0

order by [Status] asc