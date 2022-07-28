$csv=Import-Csv 'sites.csv'
$results = @()
$ExcludedLibs =@("Converted Forms", "Customized Reports", "Form Templates", "List Template Gallery", "Master Page Gallery",  
                               "Reporting Templates", "Site Assets", "Site Collection Documents", 
                               "Site Collection Images", "Site Pages", "Solution Gallery",  
                               "Theme Gallery", "Web Part Gallery", "wfpub", "Site Template Gallery", "Personal Documents", "Shared Documents", "Style Library", "Shared Pictures")
foreach($site in $csv)
{
	$site = Get-SPSite $site.SiteUrl
	$webs = $site.AllWebs
	foreach($web in $webs)
	{
		$count=0;
		$Lib=""
		foreach($list in $web.Lists)
  		{
			if($list.BaseType -eq 1 -and (-not ($ExcludedLibs -Contains $list.Title)))
 			{
				if($count -eq 0)
				{
					$Lib=$list.Title
					$count++
				}
				else
				{
					$Lib=$Lib+" ; "+$list.Title
				}
			}
  		}
		$libraries = @{
    				MysiteUrl=$web.url
    				Libraries=$Lib
    			      }
		$results += New-Object psobject -Property $Libraries
	}
}
$results | Export-Csv 'sites.csv' -NoTypeInformation


