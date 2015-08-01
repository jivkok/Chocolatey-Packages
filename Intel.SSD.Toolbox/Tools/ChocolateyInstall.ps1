$packageName = 'Intel.SSD.Toolbox';
$url = 'http://downloadmirror.intel.com/18455/eng/Intel%20SSD%20Toolbox%20-%20v3.3.0.exe';

Install-ChocolateyPackage $package 'exe' '/s' $url;
