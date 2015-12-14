$name = 'logparser'
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$program_files = if ($is64bit) { ${ENV:PROGRAMFILES(X86)} } else { $ENV:PROGRAMFILES }

Install-ChocolateyPackage $name 'msi' '/quiet' 'http://download.microsoft.com/download/f/f/1/ff1819f9-f702-48a5-bbc7-c9656bc74de8/LogParser.msi'
Install-ChocolateyPath (Join-Path $program_files 'Log Parser 2.2')
