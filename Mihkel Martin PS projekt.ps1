Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]
$ComboBoxObject = [System.Windows.Forms.ComboBox]
$TabControlObject = [System.Windows.Forms.TabControl]
$TabPageObject = [System.Windows.Forms.TabPage]
$CheckBoxObject = [System.Windows.Forms.CheckBox]
$PictureBoxObject = [System.Windows.Forms.PictureBox]
$TextBoxObject = [System.Windows.Forms.TextBox]

# Aknavaline pealkiri
$HelloWorldForm = New-Object $FormObject
$HelloWorldForm.ClientSize = '600,700'
$HelloWorldForm.Text = 'Mihkli Toolbox'
$HelloWorldForm.BackColor = "#FFFFFF"

# Tabbide tegemine
$tabControl = New-Object $TabControlObject
$tabControl.Size = New-Object System.Drawing.Size(600, 700)
$tabControl.Location = New-Object System.Drawing.Point(0, 0)

$tabPage1 = New-Object $TabPageObject
$tabPage1.Text = "Tavakasutus"
$tabPage1.BackColor = "#DBE4EE"

$tabPage2 = New-Object $TabPageObject
$tabPage2.Text = "Installer"
$tabPage2.BackColor = "#44BBA4"

$tabPage3 = New-Object $TabPageObject
$tabPage3.Text = "Antivirus"
$tabPage3.BackColor = "#F9ADA0"

$tabPage4 = New-Object $TabPageObject
$tabPage4.Text = "CLI"
$tabPage4.BackColor = "#666666"

# Tabbide jaoks tabcontrol, et see tootaks
$tabControl.TabPages.Add($tabPage1)
$tabControl.TabPages.Add($tabPage2)
$tabControl.TabPages.Add($tabPage3)
$tabControl.TabPages.Add($tabPage4)

# Aknasisene pealkiri, mis on yleval paremal
$lbltitle = New-Object $LabelObject
$lbltitle.Text = 'Mihkli Toolbox'
$lbltitle.AutoSize = $true
$lbltitle.Font = 'Verdana,8,style=Bold'
$lbltitle.Location = New-Object System.Drawing.Point(500, 30)

# Rakvere ametikooli pilt
$imageUrlRak = "https://upload.wikimedia.org/wikipedia/commons/a/aa/Animated-Flag-Estonia.gif"
$rakPilt = New-Object $PictureBoxObject
$rakPilt.ImageLocation = $imageUrlRak
$rakPilt.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$rakPilt.Size = New-Object System.Drawing.Size(200, 200)
$rakPilt.Location = New-Object System.Drawing.Point(250, 250)

# Esimese tabi pilt
$imageUrl = "https://preview.redd.it/xyqo6hx42sn51.png?width=440&format=png&auto=webp&s=3bf357e64a68883aee1618a1abdadc16d9ceee73"
$pictureBox = New-Object $PictureBoxObject
$pictureBox.ImageLocation = $imageUrl
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox.Size = New-Object System.Drawing.Size(200, 200)
$pictureBox.Location = New-Object System.Drawing.Point(10, 450)

# Timer liikuva pildi jaoks
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 50  
$timer.Enabled = $true

# Mitu pikslit liigub pilt tickis
$step = 2 

# Funktsioon timeri jaoks, mis arvutab pildi asukoha ning viib vajadusel selle tagasi
$timer_Tick = {
    $newX = $pictureBox.Location.X + $step
    
    # Vaatab, kas pilt on liiga kaugel voi mitte
    if ($newX -gt $form.ClientSize.Width) {
        $newX = -$pictureBox.Width
    }
    
    $pictureBox.Location = New-Object System.Drawing.Point($newX, $pictureBox.Location.Y)
}


$timer.Add_Tick($timer_Tick)



# PC shutdown nupp
$btnTemp = New-Object $ButtonObject
$btnTemp.Text = 'Shut down'
$btnTemp.AutoSize = $true
$btnTemp.Font = 'Verdana,10'
$btnTemp.Location = New-Object System.Drawing.Point(10, 80)
$btnTemp.Size = New-Object System.Drawing.Size(150, 23)

# PC restart nupp
$btnRestart = New-Object $ButtonObject
$btnRestart.Text = 'Restart'
$btnRestart.AutoSize = $true
$btnRestart.Font = 'Verdana,10'
$btnRestart.Location = New-Object System.Drawing.Point(10, 40)
$btnRestart.Size = New-Object System.Drawing.Size(150, 23)

# PC sleep nupp
$btnSleep = New-Object $ButtonObject
$btnSleep.Text = 'Sleep'
$btnSleep.AutoSize = $true
$btnSleep.Font = 'Verdana,10'
$btnSleep.Location = New-Object System.Drawing.Point(10, 10)
$btnSleep.Size = New-Object System.Drawing.Size(150, 23)
$btnSleep.Add_Click({
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::SetSuspendState([System.Windows.Forms.PowerState]::Suspend, $false, $true)
})

# Kettaruumi label
$lblSpace = New-Object $LabelObject
$lblSpace.Text = 'Vali ketas, et kettaruumi näha:'
$lblSpace.AutoSize = $true
$lblSpace.Font = 'Verdana,10'
$lblSpace.Location = New-Object System.Drawing.Point(10, 115)

# Kettaruumi nimekiri. See näitab ainult arvutis olemasolevaid kettaid.
$volumes = Get-Volume
$ddlSpace = New-Object System.Windows.Forms.ComboBox
$ddlSpace.Width = '75'
$ddlSpace.Location = New-Object System.Drawing.Point(240, 115)

foreach ($volume in $volumes) {
    if ($volume -ne $null -and $volume.DriveLetter -ne $null -and $volume.DriveType -ne 'NoRootDirectory') {
        $ddlSpace.Items.Add($volume.DriveLetter + ":")
    }
}

# Näitab vabat kettaruumi. Kui ketast ei ole valitud, ei näita numbrit
$lblFreeSpace = New-Object $LabelObject
$lblFreeSpace.Text = 'Vaba kettaruum:'
$lblFreeSpace.AutoSize = $true
$lblFreeSpace.Font = 'Verdana,10'
$lblFreeSpace.Location = New-Object System.Drawing.Point(10, 150)

$lblFreeSpaceValue = New-Object $LabelObject
$lblFreeSpaceValue.Text = ''
$lblFreeSpaceValue.AutoSize = $true
$lblFreeSpaceValue.Font = 'Verdana,10'
$lblFreeSpaceValue.Location = New-Object System.Drawing.Point(150, 150)

# Prügikasti tühjendamise label
$lblPrygi = New-Object $LabelObject
$lblPrygi.Text = 'HOIATUS! SEDA TEGEVUST EI SAA TAGASI VÕTTA!'
$lblPrygi.AutoSize = $true
$lblPrygi.Font = 'Verdana,10'
$lblPrygi.Location = New-Object System.Drawing.Point(170, 185)

# Prügikasti tühjendamise nupp
$btnPrygi = New-Object $ButtonObject
$btnPrygi.Text = 'Tühjenda prügikast'
$btnPrygi.AutoSize = $true
$btnPrygi.Font = 'Verdana,10'
$btnPrygi.Location = New-Object System.Drawing.Point(10, 180)
$btnPrygi.Size = New-Object System.Drawing.Size(150, 23)

# Ajutiste failide kustutamise label
$lblAjutine = New-Object $LabelObject
$lblAjutine.Text = 'Need on ajutised ja ebavajalikud failid.'
$lblAjutine.AutoSize = $true
$lblAjutine.Font = 'Verdana,10'
$lblAjutine.Location = New-Object System.Drawing.Point(180, 225)

# Ajutiste failide kustutamise nupp (kustutab kõik võimalikud failid Temp kaustas)
$btnAjutine = New-Object $ButtonObject
$btnAjutine.Text = 'Kustuta ajutised failid'
$btnAjutine.AutoSize = $true
$btnAjutine.Font = 'Verdana,10'
$btnAjutine.Location = New-Object System.Drawing.Point(10, 220)
$btnAjutine.Size = New-Object System.Drawing.Size(150, 23)

# Eemalda Cortana nupp
$btnCortana = New-Object $ButtonObject
$btnCortana.Text = 'Eemalda Cortana'
$btnCortana.AutoSize = $true
$btnCortana.Font = 'Verdana,10'
$btnCortana.Location = New-Object System.Drawing.Point(10, 260)
$btnCortana.Size = New-Object System.Drawing.Size(150, 23)

# Eemalda bloatware nupp
$btnBloatware = New-Object $ButtonObject
$btnBloatware.Text = 'Eemalda bloatware'
$btnBloatware.AutoSize = $true
$btnBloatware.Font = 'Verdana,10'
$btnBloatware.Location = New-Object System.Drawing.Point(10, 300)
$btnBloatware.Size = New-Object System.Drawing.Size(150, 23)

# Aktiveeri Hyper-V nupp
$btnHyperv = New-Object $ButtonObject
$btnHyperv.Text = 'Aktiveeri Hyper-V'
$btnHyperv.AutoSize = $true
$btnHyperv.Font = 'Verdana,10'
$btnHyperv.Location = New-Object System.Drawing.Point(10, 340)
$btnHyperv.Size = New-Object System.Drawing.Size(150, 23)
$btnHyperv.Add_Click({Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All})

# Arvuti nime muutmise label
$lblRename = New-Object $LabelObject
$lblRename.Text = 'Kirjuta uus arvutinimi kasti: '
$lblRename.AutoSize = $true
$lblRename.Font = 'Verdana,10'
$lblRename.Location = New-Object System.Drawing.Point(350, 500)

# Arvuti nime muutmise tekstikast

$txtRename = New-Object System.Windows.Forms.TextBox
$txtRename.Location = New-Object System.Drawing.Point(350, 520)
$txtRename.Size = New-Object System.Drawing.Size(200, 10)
# Arvuti nime muutmise nupp
$btnRename = New-Object $ButtonObject
$btnRename.Location = New-Object System.Drawing.Point(350,540)
$btnRename.AutoSize = $true
$btnRename.Text = "Muuda nimi"
$btnRename.Add_Click({
        $newName = $txtRename.Text
        if ($newName -ne "") {
        #Muuda arvuti nimi ara
        Rename-Computer -NewName $newName -Force -Restart
        } else {
            [System.Windows.Forms.MessageBox]::Show("Kirjutasid mittesobiva arvutinime! Palun kirjuta normaalne arvutinimi.", "Error", "OK", [System.Windows.Forms.MessageBoxIcon]::Error)
        }
})
# Eemalda bloatware funktsioon
function removeBloatware {
    $Junk = "xbox|phone|disney|skype|groove|solitaire|zune|mixedreality|tiktok|adobe|prime|soundrecorder|bingweather!3dviewer"
    $packages = Get-AppxPackage -AllUsers | Where-Object { $_.Name -match $Junk } | Where-Object -Property NonRemovable -eq $false
    foreach ($appx in $packages) {
        "Removing {0}" -f $appx.name
        Remove-AppxPackage $appx -AllUsers
    }
}

function disableCortana {
    Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
}

# Otsib get-volumega kõik kettad, mis su arvutis on ning valides ketta, näitab vaba ruumi gigabaitides
function getFreeSpace {
    $selectedDrive = $ddlSpace.SelectedItem
    $driveLetter = $selectedDrive.Substring(0, 1)
    $volume = Get-Volume -DriveLetter $driveLetter
    $freeSpace = $volume.SizeRemaining / 1GB
    $lblFreeSpaceValue.Text = "$($freeSpace.ToString("F2")) GB"
}

#---------------------------------------------------------------------------TAB 2--------------------------------------------------------------------------------------------------#
# Teise tabi pilt
$imageUrl2 = "https://preview.redd.it/vf3ojm4o1sn51.png?width=440&format=png&auto=webp&s=7cfa65a910d76e324fcc4c23468a9b801c3b74d5"
$pictureBox2 = New-Object $PictureBoxObject
$pictureBox2.ImageLocation = $imageUrl2
$pictureBox2.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox2.Size = New-Object System.Drawing.Size(200, 200)
$pictureBox2.Location = New-Object System.Drawing.Point(400, 450)

# Teise tabi pilt 2
$imageUrl22 = "https://media.tenor.com/qEUU7UjDgdEAAAAM/rainbow-dash-estonian-flag.gif"
$pictureBox22 = New-Object $PictureBoxObject
$pictureBox22.ImageLocation = $imageUrl22
$pictureBox22.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox22.Size = New-Object System.Drawing.Size(200, 200)
$pictureBox22.Location = New-Object System.Drawing.Point(350, 50)

# Programmide nimekiri, mida installida
$programs = @(
    'Mozilla.Firefox', 'Google.Chrome', 'TeamViewer.TeamViewer', 'Notepad++.Notepad++', '7zip.7zip', 
    'Spotify.Spotify', 'Brave.Brave', 'Opera.OperaGX', 'Microsoft.Teams', 'Zoom.Zoom'
)

# Funktsioon, mis teeb checkboxid
function Add-Checkbox {
    param (
        [string]$text,
        [System.Drawing.Point]$location
    )
    $cbx = New-Object System.Windows.Forms.CheckBox
    $cbx.Text = $text
    $cbx.AutoSize = $true
    $cbx.Font = 'Verdana,10'
    $cbx.Location = $location
    $cbx.Size = New-Object System.Drawing.Size(150, 23)
    return $cbx
}

# Arvutab iga programmi jaoks checkboxide asukoha
$location = New-Object System.Drawing.Point(10, 20)
$checkboxes = @()

foreach ($program in $programs) {
    $cbx = Add-Checkbox $program $location
    $tabPage2.Controls.Add($cbx)
    $checkboxes += $cbx
    $location.Y += 30
}

# Installimise nupp
$btnInstall = New-Object $ButtonObject
$btnInstall.Text = "Installi valitud"
$btnInstall.Location = New-Object System.Drawing.Point(10, 350)
$btnInstall.Size = New-Object System.Drawing.Size(120, 30)

$btnInstall.Add_Click({
    $selectedPrograms = $checkboxes | Where-Object { $_.Checked } | ForEach-Object { $_.Text }
    foreach ($program in $selectedPrograms) {
        Start-Process "winget" -ArgumentList "install --id $program -e" -NoNewWindow -Wait
    }
    [System.Windows.Forms.MessageBox]::Show("Installimine lõpetatud!", "Staatus", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})


#---------------------------------------------------------------------------TAB 3--------------------------------------------------------------------------------------------------#
# Kolmanda tabi pilt
$imageUrl3 = "https://preview.redd.it/ppawzo4o1sn51.png?width=440&format=png&auto=webp&s=d09c261013546996e8325d507ff230a7e9513793"
$pictureBox3 = New-Object $PictureBoxObject
$pictureBox3.ImageLocation = $imageUrl3
$pictureBox3.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox3.Size = New-Object System.Drawing.Size(200, 200)
$pictureBox3.Location = New-Object System.Drawing.Point(400, 450)

# Kolmanda tabi pilt 2
$imageUrl33 = "https://purepng.com/public/uploads/large/purepng.com-fortnite-take-the-lfortnitefortnite-battle-royalebattle-royaleepic-gamesgames-1251525436722hchjn.png"
$pictureBox33 = New-Object $PictureBoxObject
$pictureBox33.ImageLocation = $imageUrl33
$pictureBox33.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox33.Size = New-Object System.Drawing.Size(200, 200)
$pictureBox33.Location = New-Object System.Drawing.Point(30, 1)

# Viirusetõrje nupp
$btnAntivirus = New-Object $ButtonObject
$btnAntivirus.Text = 'Teosta kiire viirusetõrje skänn'
$btnAntivirus.AutoSize = $true
$btnAntivirus.Font = 'Verdana,20,style=Bold'
$btnAntivirus.Location = New-Object System.Drawing.Point(50, 150)
$btnAntivirus.Size = New-Object System.Drawing.Size(150, 130)

#---------------------------------------------------------------------------TAB 4--------------------------------------------------------------------------------------------------#

# Neljanda tabi pilt
$imageUrl4 = "https://preview.redd.it/2rcjpn4o1sn51.png?width=440&format=png&auto=webp&s=c372e948dbd9efe0aad20ae54382f9244c9110b6"
$pictureBox4 = New-Object $PictureBoxObject
$pictureBox4.ImageLocation = $imageUrl4
$pictureBox4.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox4.Size = New-Object System.Drawing.Size(250, 250)
$pictureBox4.Location = New-Object System.Drawing.Point(200, 440)

$cli_textbox = New-Object $TextBoxObject
$cli_textbox.Text='Sisesta oma skript siia'
$cli_textbox.Font=$TextFont
$cli_textbox.Location=New-Object System.Drawing.Point(30,30)
$cli_textbox.Size=New-Object System.Drawing.Size(530,130)
$cli_textBox.Multiline=$true
$cli_textBox.ScrollBars='Vertical'
$cli_textBox.WordWrap=$true
$cli_textbox.ForeColor='#ffffff'
$cli_textbox.BackColor='#686868'

# Teeb output kasti
$cli_output = New-Object $TextBoxObject
$cli_output.Text='Väljund'
$cli_output.Font=$TextFont
$cli_output.Location=New-Object System.Drawing.Point(30, 210)
$cli_output.Size=New-Object System.Drawing.Size(530,130)
$cli_output.Multiline=$true
$cli_output.ScrollBars='Vertical'
$cli_output.WordWrap=$true
$cli_output.ForeColor='#ffffff'
$cli_output.BackColor='#686868'

# Skripti jaoks nupp
$cli_run_script_button=New-Object $ButtonObject
$cli_run_script_button.Text='Jooksuta skript'
$cli_run_script_button.AutoSize=$true
$cli_run_script_button.Font=$TextFont
$cli_run_script_button.ForeColor='#ffffff'
$cli_run_script_button.Location=New-Object System.Drawing.Point(30,170)

# Jooksutab tekstikastis oleva skripti powershellis
function RunScript{
    $custom_script = $cli_textbox.Text
    $cli_output.Text = Invoke-Expression -Command $custom_script
}
$cli_run_script_button.Add_Click({RunScript})

# Nuppude klikid
$btnPrygi.Add_Click({ Clear-RecycleBin -Force })
$btnTemp.Add_Click({ Stop-Computer -ComputerName localhost})
$btnRestart.Add_Click({ shutdown /r })
$btnAjutine.Add_Click({ Remove-Item -Path $env:TEMP -Recurse -Force })
$btnCortana.Add_Click({ disableCortana })
$ddlSpace.Add_SelectedIndexChanged({ getFreeSpace })
$btnBloatware.Add_Click({ removeBloatware })
$btnAntivirus.Add_Click({
    Start-Process "powershell.exe" -ArgumentList "-Command Start-MpScan -ScanType QuickScan" -Verb RunAs
    [System.Windows.Forms.MessageBox]::Show("Skänn algas!", "Information", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# Tabbide kontrollid
$tabPage1.Controls.AddRange(@($rakPilt, $lblRename, $txtRename, $btnRename, $lblSpace, $ddlSpace, $lblFreeSpace, $lblFreeSpaceValue, $btnTemp, $btnRestart, $btnSleep, $btnHyperv, $lblPrygi, $btnPrygi, $lblAjutine, $btnAjutine, $btnCortana, $btnBloatware, $btnAntivirus, $pictureBox))
$tabPage2.Controls.AddRange(@($btnInstall, $pictureBox2, $pictureBox22))
$tabPage3.Controls.AddRange(@($btnAntivirus, $pictureBox3, $pictureBox33))
$tabPage4.Controls.AddRange(@($cli_textbox, $cli_output, $cli_run_script_button, $pictureBox4))

# TabControl ja pealkiri igale leheküljele
$HelloWorldForm.Controls.AddRange(@($lbltitle, $tabControl))

# Näitab formi
$HelloWorldForm.ShowDialog()
$HelloWorldForm.Dispose()


