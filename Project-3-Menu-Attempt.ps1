
#Ok I'll admit, this bit came from Gemini, because I couldnt get the ISE "terminal" to
#act the way a real terminal would behave. Getting keystrokes is weird in ISE, so Im
#using this AI slop if-statement to run the script in a real terminal during development.
if ($Host.Name -eq "Windows PowerShell ISE Host" -or $Host.Name -eq "Visual Studio Code Host") {
    # Re-launch this script in a real external window
    Start-Process powershell.exe -ArgumentList "-NoExit", "-File", $MyInvocation.MyCommand.Path
    return
}


#creating some variables. what a mess.
$menuOption = 1
$date = Get-Date -Format "yyyy-MM-dd_HHmm"
$fileName = "Log_dump_$date.txt"
$destPath = Read-Host Enter the complete filepath of the destination for the log reports to be placed
$filePath = Join-Path -Path $destPath -ChildPath $fileName
Write-Host $filePath


#Displaying the menu
function Display-My-Menu {
    if($menuOption -eq 1){
        cls
        Write-Host "Use arrow keys and Enter key to navigate the menu, or press any other key to exit."
        Write-Host [X] System identity and hardware
        Write-Host [ ] Network and connectivity
        Write-Host [ ] Users, accounts, groups
        Write-Host [ ] Processes, services, startup
        Write-Host [ ] Event Logs
        Write-Host [ ] Storage and File Systems
        Write-Host [ ] Security and Configuration
    }
    if($menuOption -eq 2){
        cls
        Write-Host "Use arrow keys and Enter key to navigate the menu, or press any other key to exit."
        Write-Host [ ] System identity and hardware
        Write-Host [X] Network and connectivity
        Write-Host [ ] Users, accounts, groups
        Write-Host [ ] Processes, services, startup
        Write-Host [ ] Event Logs
        Write-Host [ ] Storage and File Systems
        Write-Host [ ] Security and Configuration
    }
    if($menuOption -eq 3){
        cls
        Write-Host "Use arrow keys and Enter key to navigate the menu, or press any other key to exit."
        Write-Host [ ] System identity and hardware
        Write-Host [ ] Network and connectivity
        Write-Host [X] Users, accounts, groups
        Write-Host [ ] Processes, services, startup
        Write-Host [ ] Event Logs
        Write-Host [ ] Storage and File Systems
        Write-Host [ ] Security and Configuration
    }
    if($menuOption -eq 4){
        cls
        Write-Host "Use arrow keys and Enter key to navigate the menu, or press any other key to exit."
        Write-Host [ ] System identity and hardware
        Write-Host [ ] Network and connectivity
        Write-Host [ ] Users, accounts, groups
        Write-Host [X] Processes, services, startup
        Write-Host [ ] Event Logs
        Write-Host [ ] Storage and File Systems
        Write-Host [ ] Security and Configuration
    }
    if($menuOption -eq 5){
        cls
        Write-Host "Use arrow keys and Enter key to navigate the menu, or press any other key to exit."
        Write-Host [ ] System identity and hardware
        Write-Host [ ] Network and connectivity
        Write-Host [ ] Users, accounts, groups
        Write-Host [ ] Processes, services, startup
        Write-Host [X] Event Logs `(BROKEN DUE TO PERMISSIONS RESTRICTIONS`)
        Write-Host [ ] Storage and File Systems
        Write-Host [ ] Security and Configuration
    }
    if($menuOption -eq 6){
        cls
        Write-Host "Use arrow keys and Enter key to navigate the menu, or press any other key to exit."
        Write-Host [ ] System identity and hardware
        Write-Host [ ] Network and connectivity
        Write-Host [ ] Users, accounts, groups
        Write-Host [ ] Processes, services, startup
        Write-Host [ ] Event Logs
        Write-Host [X] Storage and File Systems `(BROKEN DUE TO PERMISSIONS RESTRICTIONS`)
        Write-Host [ ] Security and Configuration
    }
    if($menuOption -eq 7){
        cls
        Write-Host "Use arrow keys and Enter key to navigate the menu, or press any other key to exit."
        Write-Host [ ] System identity and hardware
        Write-Host [ ] Network and connectivity
        Write-Host [ ] Users, accounts, groups
        Write-Host [ ] Processes, services, startup
        Write-Host [ ] Event Logs
        Write-Host [ ] Storage and File Systems
        Write-Host [X] Security and Configuration
    }


    #Menu Control logic
    $keystroke = [Console]::ReadKey($true)
    if($keystroke.Key -eq [ConsoleKey]::Enter){
        #Get System identity and hardware info
        if($menuOption -eq 1){
            cls
            Write-Host Creating log...
            Get-CimInstance Win32_OperatingSystem | Out-File -FilePath $filePath
            Get-CimInstance Win32_ComputerSystem | Out-File -FilePath $filePath -Append
            Get-CimInstance Win32_BIOS | Out-File -FilePath $filePath -Append
            Get-CimInstance Win32_Processor | Out-File -FilePath $filePath -Append
            Get-CimInstance Win32_PhysicalMemory | Out-File -FilePath $filePath -Append
            Get-CimInstance Win32_LogicalDisk | Out-File -FilePath $filePath -Append
            (Get-CimInstance Win32_OperatingSystem).LastBootUpTime | Out-File -FilePath $filePath -Append
            Write-Host Log created at $filePath
        }
        #Get network and connectivity info
        if($menuOption -eq 2){
            cls
            Write-Host Creating log...
            ipconfig /all | Out-File -FilePath $filePath
            Get-NetAdapter | Out-File -FilePath $filePath -Append
            Get-NetIPAddress | Out-File -FilePath $filePath -Append
            route print | Out-File -FilePath $filePath -Append
            Get-DnsClientServerAddress | Out-File -FilePath $filePath -Append
            ipconfig /displaydns | Out-File -FilePath $filePath -Append
            netsh wlan show profiles | Out-File -FilePath $filePath -Append
            netsh wlan show profile name="PROFILE" key=clear | Out-File -FilePath $filePath -Append
            Test-Connection example.com -Count 4 | Out-File -FilePath $filePath -Append
            tracert example.com | Out-File -FilePath $filePath -Append
            Write-Host Log created at $filePath
        }
        #Get users, accounts, and groups info
        if($menuOption -eq 3){
            cls
            Write-Host Creating log...
            Get-LocalUser | Out-File -FilePath $filePath
            Get-LocalGroup | Out-File -FilePath $filePath -Append
            Get-LocalGroupMember Administrators | Out-File -FilePath $filePath -Append
            whoami | Out-File -FilePath $filePath -Append
            whoami /groups | Out-File -FilePath $filePath -Append
            Write-Host Log created at $filePath
        }
        #Get processes, services, and startup info
        if($menuOption -eq 4){
            cls
            Write-Host Creating log...
            Get-Process | Out-File -FilePath $filePath
            Get-Process | Sort-Object CPU -Descending | Select-Object -First 25 | Out-File -FilePath $filePath -Append
            Get-Service | Out-File -FilePath $filePath -Append
            Get-Service | Where-Object Status -eq Running | Out-File -FilePath $filePath -Append
            Get-CimInstance Win32_StartupCommand | Out-File -FilePath $filePath -Append
            Get-ScheduledTask | Out-File -FilePath $filePath -Append
            Write-Host Log created at $filePath
        }
        # Get event logs
        if($menuOption -eq 5){
            cls
            Write-Host Creating log...
            Get-WinEvent -ListLog * | Out-File -FilePath $filePath
            Get-WinEvent -LogName System -MaxEvents 200 | Out-File -FilePath $filePath -Append
            Get-WinEvent -LogName Application -MaxEvents 200 | Out-File -FilePath $filePath -Append
            Get-WinEvent -LogName Security -MaxEvents 200 | Out-File -FilePath $filePath -Append
            Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" -MaxEvents 200 | Out-File -FilePath $filePath -Append
            Get-WinEvent -LogName "Microsoft-Windows-WindowsUpdateClient/Operational" -MaxEvents 200 | Out-File -FilePath $filePath -Append
            Write-Host Log created at $filePath
        }
        #Get storage and file system info
        if($menuOption -eq 6){
            cls
            Write-Host Creating log...
            Get-PSDrive | Out-File -FilePath $filePath
            Get-ChildItem C:\SomePath -Recurse | Sort-Object Length -Descending | Select-Object -First 50 | Out-File -FilePath $filePath -Append
            Get-ChildItem C:\SomePath | Sort-Object LastWriteTime -Descending | Select-Object -First 50 | Out-File -FilePath $filePath -Append
            Write-Host Log created at $filePath
        }
        #Get Security and config info
        if($menuOption -eq 7){
            cls
            Write-Host Creating log...
            Get-MpComputerStatus | Out-File -FilePath $filePath
            Get-NetFirewallProfile | Out-File -FilePath $filePath -Append
            Get-NetFirewallRule | Out-File -FilePath $filePath -Append
            Get-HotFix | Out-File -FilePath $filePath -Append
            Write-Host Log created at $filePath
        }
    }


    #up and down arrow to navigate the menu
    if($keystroke.Key -eq [ConsoleKey]::DownArrow){
        $menuOption++
        if($menuOption -eq 8){
            $menuOption = 1
        }
        Display-My-Menu
    }
    if($keystroke.Key -eq [ConsoleKey]::UpArrow){
        $menuOption--
        if($menuOption -eq 0){
            $menuOption = 7
        }
        Display-My-Menu
    }
    #Left and Right arrow do nothing, otherwise the program would close when L/R arrow pressed.
    #There's probably a better way to apply this to all key's but ICBF.
    #and anyways, I can just say "any other key to exit" if I want to be lazy.
    if($keystroke.Key -eq [ConsoleKey]::LeftArrow){
        Display-My-Menu
    }
    if($keystroke.Key -eq [ConsoleKey]::RightArrow){
        Display-My-Menu
    }
}

cls
Display-My-Menu