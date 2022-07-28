#Connect to SPO
Connect-PnPOnline -Url "https://sp.sharepoint.com/sites/S123"

#Target multiple lists 
$allLists = Get-PnPList | Where-Object {$_.BaseTemplate -eq 101}

#Store the results
$results = @()

foreach ($row in $allLists) {
    $allItems = Get-PnPListItem -List $row.Title -Fields "FileLeafRef", "SMTotalFileStreamSize", "FileDirRef", "FolderChildCount", "ItemChildCount"
    
    foreach ($item in $allItems) {
        if (($item.FileSystemObjectType) -eq "Folder") {
            $results += New-Object psobject -Property @{
                FileType          = $item.FileSystemObjectType 
                RootFolder        = $item["FileDirRef"] 
                LibraryName       = $row.Title
                FolderName        = $item["FileLeafRef"]
                FullPath          = $item["FileRef"]
                FolderSizeInMB    = ($item["SMTotalFileStreamSize"] / 1MB).ToString("N")
                NbOfNestedFolders = $item["FolderChildCount"]
                NbOfFiles         = $item["ItemChildCount"]
            }
        }
    }
}
#Export the results
$results | Export-Csv -Path "C:\scripts\libs.csv" -NoTypeInformation
