Set-Alias ll ls
Set-Alias  touch New-Item
$myprofile_optional_username = $false
$myprofile_hide_username = $true

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
function prompt {
	$last_return = $?
	if(-Not($env:WT_PROFILE_ID)){
		"PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
		return 
	}
	
	
	$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
	$principal = [Security.Principal.WindowsPrincipal] $identity
	$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
	#definition
	$my_color_1 = "Magenta"

	$shell_wallpaper_color = "Black"
	$shell_background_color = $my_color_1
	$shell_foreground_color = "Black"
	$user_background_color = "White"
	$user_foreground_color = "Black"
	$path_background_color = $my_color_1
	$path_foreground_color = "Black"
	$time_background_color = "DarkGray"
	$time_foreground_color = "White"
	$return_foreground_color = "Black"
	
	Write-Host("┌─") -NoNewline -ForegroundColor Green
	#shell
	Write-Host("`u{e0b6}") -ForegroundColor $shell_background_color -NoNewline
	Write-Host ("`u{fab2} pwsh") -nonewline -ForegroundColor $shell_foreground_color -BackgroundColor $shell_background_color
	#Write-Host("") -NoNewline -ForegroundColor $shell_background_color -BackgroundColor $user_background_color
	#shell-user separator
	Write-Host("") -NoNewline -ForegroundColor $shell_background_color -BackgroundColor $shell_wallpaper_color
	Write-Host("") -NoNewline -ForegroundColor $shell_wallpaper_color -BackgroundColor $user_background_color
	#user	
	$username = if($principal.IsInRole($adminRole)){
		"`u{f084} admin"
	}elseif($myprofile_optional_username){
		"`u{f2be} $myprofile_optional_username"
	}elseif($myprofile_hide_username) {
		"`u{f2be} <hidden>"	
	}else{
		"`u{f2be} $env:USERNAME"

	}
	#Write-Host("`u{f2be} ") -NoNewline -BackgroundColor $user_background_color -ForegroundColor $user_foreground_color
	Write-Host($username + "`u{e79b} " + $env:COMPUTERNAME + " ") -NoNewline -BackgroundColor $user_background_color -ForegroundColor $user_foreground_color
	#user-path separator
	Write-Host("") -NoNewline -ForegroundColor $user_background_color -BackgroundColor $shell_wallpaper_color
	Write-Host("") -NoNewline -ForegroundColor $shell_wallpaper_color -BackgroundColor $path_background_color
	#path
	Write-Host(" `u{f115} `u{f63d} ") -NoNewline -BackgroundColor $path_background_color -ForegroundColor $path_foreground_color
	Write-Host("$($executionContext.SessionState.Path.CurrentLocation)".Replace("$env:HOMEDRIVE$env:HOMEPATH\source\repos", "`u{f121} ").Replace("$env:HOMEDRIVE$env:HOMEPATH", "`u{f015} ").Replace("\", "`u{e0bd} ").Replace(":", "")) -nonewline -ForegroundColor $path_foreground_color -BackgroundColor $path_background_color
	#Write-Host("`u{e0b4}") -ForegroundColor $path_background_color #これは丸の右半分
	Write-Host("") -nonewline -ForegroundColor $path_background_color #これは▶
	#Write-Host("`u{e0c4}") -ForegroundColor $path_background_color #これはげじげじ
	
	Write-Host("".PadLeft(5)) -NoNewline
	#return
	$last_return_color = ""
	$last_return_value = ""
	if($last_return){
		$last_return_color = "Green"
		$last_return_value = "`u{fb0c} `u{f62b} "
	}else{
		$last_return_color = "DarkRed"
		
		$last_return_value = "`u{fb0c} `u{f467} "
	}
	
	Write-Host("`u{e0b3}") -NoNewline -ForegroundColor $last_return_color
	Write-Host("`u{e0b2}") -NoNewline -ForegroundColor $last_return_color
	Write-Host($last_return_value) -NoNewline -ForegroundColor $return_foreground_color -BackgroundColor $last_return_color

	#return-time separator
	Write-Host("`u{e0b2}") -NoNewline -ForegroundColor $shell_wallpaper_color -BackgroundColor $last_return_color

	#time
	Write-Host("`u{e0b2}") -NoNewline -ForegroundColor $time_background_color
	Write-Host("`u{f64f} ") -NoNewline -ForegroundColor $time_foreground_color -BackgroundColor $time_background_color
	Write-Host((Get-Date -Format "hh:mm:ss")) -NoNewline -ForegroundColor $time_foreground_color -BackgroundColor $time_background_color
	Write-Host("`u{e0b0}`u{e0b1}") -NoNewline -ForegroundColor $time_background_color

	#prompt
	Write-Host 
	$prompt_color = "Gray"
	Write-Host($("└─" * ($nestedPromptLevel + 1))) -NoNewline -ForegroundColor Green
	Write-Host("") -NoNewline -ForegroundColor $prompt_color
	return " "
}
