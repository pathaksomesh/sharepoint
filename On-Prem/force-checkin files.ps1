$Lines= Import-CSV "C:\sp_scripts\import\sitelist.csv"
ForEach ($Line In $Lines)
{ 
$site = get-spsite $Line.URL

     foreach($Web in $site.AllWebs)

   {
$Web.URL

            foreach ($List in $Web.GetListsOfType([Microsoft.SharePoint.SPBaseType]::DocumentLibrary))

            {             

 
      foreach ($ListItem in $List.Items) 

      {

                  if($ListItem.File.CheckOutStatus -ne "None") 
      { 

 $Web.URL +"#"+$ListItem.Name +"#"+ $ListItem.File.CheckedOutByUser.Name +"#" +$Web.URL+"/"+$ListItem.File.URL | Out-File 'C:\sp_scripts\export\sitelist_checkout.csv' -Append
    $ListItem.File.Checkin("Checked in by Administrator") 
$Web.URL +"#"+$ListItem.Name |Out-File 'C:\sp_scripts\export\sitelist_checkin.csv' -Append
write-host "Checked in file: " $ListItem.Name

      }
                    }

                }

            }      
}
