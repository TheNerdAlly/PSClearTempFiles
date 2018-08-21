##Clears the temporary files in several locations on Windows.
##Created by Amber Kirkendoll | GitHub @allykir | amberk@engineer.com
##License - MIT - Do whatever you what with it.  I don't care.  Just don't blame me.  Provided "As Is"

##Get Windows Version
$OSVer = ([System.Environment]::OSVersion.Version.Major).ToString()

##Get logged in User
$loggedUser = $env:USERNAME

#get Primary drive
$sys = $pwd.drive.Name

$directory = @(
    $sys+":\Windows\temp";
    $env:TEMP;
    $sys+":\Windows\Prefetch";
    $sys+":\Documents and Settings\$loggedUser\Local Settings\temp"
)

switch($OSVer)
{
    10
    {
        Write-Host "You are running Windows 10"
        Write-Host "Your local drive letter is: $sys"
        
        foreach($folder in $directory)
        {
            Clear-Host
            Set-Location $folder
            write-host "You are viewing $folder"
            Get-ChildItem $folder -recurse | Measure-Object -property length -sum   
            $usrInput = Read-Host "Would you like to Delete everything in" $folder

            if($usrInput -ieq "Y" -or $usrInput -ieq "Yes")
            {
                Remove-Item * -Recurse -Force -ErrorAction SilentlyContinue
            }
            else 
            {
                continue
            }

        }

        #Change back to starting location
        Set-Location $PSScriptRoot
    }

    default
    {
        Write-error "This is currently not a support OS!"
    }
}
