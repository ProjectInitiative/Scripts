$Dir2 = 'DIRECTORY_TO_SEARCH';
$filenames=Get-Content '.\files.csv';
$count = 0;
$filesnotfound = [System.Collections.ArrayList]@()
foreach ($filename in $filenames) {
$count += 1
$found=$false;
ForEach-Object {if ((Get-ChildItem -Path $Dir2 -Recurse -Filter "*$filename*" | measure).Count -ge 1) {Write-Host 'FILE ' $count ' ' $filename ' Ok' -foregroundcolor green; $found=$true;CONTINUE }$found=$false;} -END {if($found -ne $true){ Write-Host 'FILE ' $count ' ' $filename ' missing in the folder' -foregroundcolor red; [void]$filesnotfound.Add("$filename");}}
};
#Get-ChildItem -Path $Dir2 -Recurse | ForEach-Object  {$found=$false; foreach ($filename in $filenames) {if ((Get-ChildItem -Path $Dir2 -Recurse -Filter "*$filename*" | measure).Count -ge 1) {Write-Host 'FILE ' $_.BaseName ' was found on the list' -foregroundcolor cyan; $found=$true;BREAK }} if($found -ne $true){ Write-Host 'FILE ' $_.BaseName ' missing on the list of files' -foregroundcolor Magenta} };
echo $filesnotfound | Out-File -FilePath .\NotFound.csv

#(Get-ChildItem -Path $Dir2 -Recurse -Filter "*$filename*" | measure).Count -ge 1
# $(echo $files) -Match $filename