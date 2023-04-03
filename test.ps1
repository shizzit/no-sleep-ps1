. ".\keypress.ps1"

Add-Type -AssemblyName System.Windows.Forms

function timer_func {
    Write-Host "timer func"
    $now = Get-Date
    [void] $listBox.Items.Add($now)
    [ScreenSpender.PressKeyForMe]::Main()
}

function button_func { 
    Write-Host "button func"
    Write-Host $global:button_status

    if ($global:button_status -eq $false) {
        $global:button_status = $true
        Write-Host "timer starting"
        $button.Text = "Stop"
        $timer1.Start()
    } elseif ($global:button_status -eq $true) {
        $global:button_status = $false
        Write-Host "timer stopping"
        $button.Text = "Start"
        $timer1.Stop()
    }
    
}

$form = New-Object system.Windows.Forms.Form
$form.ClientSize = '200,150'
$form.text = "Test"
$form.Topmost = $true

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,10)
$listBox.Size = New-Object System.Drawing.Size(170,150)
$listBox.Height = 80
$form.Controls.Add($listBox)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(60,100)
$button.Size = New-Object System.Drawing.Size(75,30)
$button.Text = 'Start'
$global:button_status = $false
$button.Add_Click({ button_func })

$timer1 = New-Object System.Windows.Forms.Timer
$timer1.Interval = 10000
$timer1.add_Tick({ timer_func })

$form.Controls.Add($button)

# Display the form
[void]$form.ShowDialog()