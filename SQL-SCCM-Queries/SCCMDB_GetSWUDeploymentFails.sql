select distinct

s.Name0 as 'Machine Name',
s.BuildExt as 'OS Build Version',
stnames.StateName as 'State Name',
stnames.StateID as 'State ID',
ciass.AssignmentName as 'Deployment name',
assc.StateTime as 'State Time',
ciass.CollectionName as 'Collection Name'



from v_CIAssignment ciass

left join v_AssignmentState_Combined assc on ciass.AssignmentID = assc.AssignmentID
left join v_StateNames stnames on assc.StateType = stnames.TopicType and stnames.StateID=ISNULL(assc.StateID,0)
--left join v_ClientAdvertisementStatus cladv on ciass.AssignmentID = cladv.AdvertisementID
--left join v_AdvertisementStatusInformation adsI on adsi.MessageID = assc.m
inner join v_R_System s on s.ResourceID = assc.ResourceID



where ciass.AssignmentID = '10063' --and stnames.StateName = 'Failed to install update(s)'

order by [State Name]

--select * from v_ad test where test. = 2160699 --and test.AssignmentID = 10062

