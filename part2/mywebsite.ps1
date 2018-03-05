{
        Ensure = "Present"
        Name = "Web-Asp-Net45"
    }
    
    #Install IISManagementConsole
    WindowsFeature WebServerManagementConsole
    {
        Name = "Web-Mgmt-Console"
        Ensure = "Present"
    }

    #Replace IIS start page by hostname
    Script HTMLEdit
    {
        SetScript = 
        { 
            $hostname = get-childitem -path env:computername
            "<html><body>"+$hostname.value+"</body></html>" | out-file -FilePath "C:\inetpub\wwwroot\iisstart.htm"
            Start-Process -FilePath C:\Windows\System32\iisreset.exe -ArgumentList /RESTART
        }
        TestScript = 
        {
            return $False
        }
        GetScript = 
        { 
            Test-Path -Path "C:\inetpub\wwwroot\iisstart.htm"
        }
        DependsOn = "[WindowsFeature]IIS"       
    }
  }
}
