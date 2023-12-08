param (
  [Parameter(Mandatory = $false)]
  [string]$Subject = "world"
)

Write-Output "Hello, $Subject!"
