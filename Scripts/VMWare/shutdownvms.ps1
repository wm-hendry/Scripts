    ## TO DO 
    ## Fix the report so that it actually lists each vm on a new line

    $vcenter="name.yourvcenter.blah"  
      
    # Connect to vcenter server  
    connect-viserver $vcenter  
   
    # Import the cvs file
    
    $cvsfile = @("C:\PowerCLI_Scripts\vmlist.csv")
    $vms2stop = Import-Csv -Path $cvsfile
    
    # Ice 'em
    
    foreach ($vm in $vms2stop) {
    
    Write-Host "Shutting down $vm.VMName ----"
    Shutdown-VMGuest $vm.VMName -Confirm:$false; Start-Sleep 6
    
    }
    
                
    #For generating email  
        $Report += $vm.VMName + " ---- Powered off. `r`n" 
        
        

    write-host "Sleeping ..."  
    Sleep 15

    #Send out an email with the names  
    $emailFrom = "you@domain.com"  
    $emailTo = "you@domain.com"  
    $subject = "List of servers powered off"  
    $smtpServer = "your.smtp.server.com"  
    $smtp = new-object Net.Mail.SmtpClient($smtpServer)  
    $smtp.Send($emailFrom, $emailTo, $subject, $Report)  
      
    #Disconnect from vcenter server  
    disconnect-viserver $vcenter -Confirm:$false 
