    ## TO DO
    ## Fix the report so that it actually lists each vm on a new line    

    $vcenter="name.yourvcenter.blah"  
      
    # Connect to vcenter server  
    connect-viserver $vcenter  
   
    # Import the cvs file
    
    $cvsfile = @("C:\PowerCLI_Scripts\vmlist.csv")
    $vms2start = Import-Csv -Path $cvsfile
    
    # Fire 'em up
    
    foreach ($vm in $vms2start) {
    
    Write-Host "Powering on $vm.VMName ----"
    Start-VM $vm.VMName; Start-Sleep 10
    
    }

                
    #For generating email  
        $Report += $vm.VMName + " ---- Powered on. `r`n" 
        
        

    write-host "Sleeping ..."  
    Sleep 15

    #Send out an email with the names  
    $emailFrom = "you@domain.com"  
    $emailTo = "you@domain.com"  
    $subject = "List of servers powered on"  
    $smtpServer = "your.smtp.server.com"  
    $smtp = new-object Net.Mail.SmtpClient($smtpServer)  
    $smtp.Send($emailFrom, $emailTo, $subject, $Report)  
      
    #Disconnect from vcenter server  
    disconnect-viserver $vcenter -Confirm:$false
