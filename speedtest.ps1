$Speedtest = & "C:\speedtest.exe" --format=json --accept-license --accept-gdpr
$Speedtest | Out-File "C:\Last.txt" -Force
$Speedtest = $Speedtest | ConvertFrom-Json
 
[PSCustomObject]$SpeedObject = @{
    downloadspeed = [math]::Round($Speedtest.download.bandwidth / 1000000 * 8, 2)
    uploadspeed   = [math]::Round($Speedtest.upload.bandwidth / 1000000 * 8, 2)
    packetloss    = [math]::Round($Speedtest.packetLoss)
    isp           = $Speedtest.isp
    ExternalIP    = $Speedtest.interface.externalIp
    InternalIP    = $Speedtest.interface.internalIp
    UsedServer    = $Speedtest.server.host
    URL           = $Speedtest.result.url
    Jitter        = [math]::Round($Speedtest.ping.jitter)
    Latency       = [math]::Round($Speedtest.ping.latency)
}

# I need the output in one file per desired measurement
$SpeedObject.downloadspeed | Out-File "C:\LastDownloadspeed.txt" -Force
$SpeedObject.uploadspeed | Out-File "C:\LastUploadspeed.txt" -Force
$SpeedObject.packetloss | Out-File "C:\LastPacketloss.txt" -Force
$SpeedObject.Jitter | Out-File "C:\LastJitter.txt" -Force
$SpeedObject.Latency | Out-File "C:\LastLatency.txt" -Force