$srccredential = Get-Credential -Message "Enter your source credential"
$dstcredential = Get-Credential -Message "Enter your destination credential"

$csvFile = "c:\spo_script\migrate.csv"
$table = Import-Csv $csvFile -delimiter ","
foreach ($row in $table)
{
$srcsite = Connect-Site -Url $row.SourceSite -Credential $srccredential
$dstsite = Connect-Site -Url $row.DestinationSite -Credential $dstcredential
$srclist = Get-List -Site $srcsite -Name "List1"
$dstlist = Get-List -Site $dstsite -Name "List2"
Copy-Content -SourceList $srclist -DestinationList $dstlist -DestinationFolder "User\12"
}
