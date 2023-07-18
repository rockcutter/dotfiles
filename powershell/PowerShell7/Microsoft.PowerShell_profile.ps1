function ls_force(){
	ls -force
}

Set-Alias ll ls_force
Set-Alias touch New-Item
Set-Alias grep findstr
$myprofile_optional_username = $false
$myprofile_hide_username = $true

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

$StartPath = Convert-Path .
if($StartPath -eq "C:\Windows\System32"){
	Set-Location
}

function get_git_branch{
  if (git branch) {
    return ((git branch | select-string "^\*").ToString()).trim() -replace "^\* *", ""
  }
	return ""
}

function prompt {
	$last_return = $?

	# Windows Terminalで表示していない時
	if(-Not($env:WT_PROFILE_ID)){
		"PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
		return 
	}
	
	
	$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
	$principal = [Security.Principal.WindowsPrincipal] $identity
	$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

	#definition
	$my_color_1 = "DarkRed"

	$shell_icon_color = "Black"
	$sun_color = "DarkYellow"
	$moon_color = "Yellow"
	$shell_wallpaper_color = "Black"
	$shell_background_color = $my_color_1
	$shell_foreground_color = "Black"
	$user_background_color = "White"
	$user_foreground_color = "Black"
	$path_background_color = $my_color_1
	$path_foreground_color = "Black"
	$time_background_color = "DarkGray"
	$time_foreground_color = "White"
	$return_code_success_color = "Green"
	$return_code_failed_color = "Red"
	$return_foreground_color = "Black"
	$git_branch_foreground_color = "White"
	$git_branch_background_color = "Magenta"

	
	Write-Host("┌─") -NoNewline -ForegroundColor Green

	#
	# write shell ----------------------------------------------------------------------------------
	#
	
	Write-Host("`u{e0b6}") -ForegroundColor $shell_background_color -NoNewline
	Write-Host (" ") -nonewline -ForegroundColor $shell_icon_color -BackgroundColor $shell_background_color
	Write-Host ("pwsh") -nonewline -ForegroundColor $shell_foreground_color -BackgroundColor $shell_background_color
	Write-Host("") -NoNewline -ForegroundColor $shell_background_color -BackgroundColor $shell_wallpaper_color
	
	#
	# shell end ----------------------------------------------------------------------------------
	#

	#
	# Write user	-------------------------------------------------------------------------------------
	# 
	
	$username = if($principal.IsInRole($adminRole)){
		" admin"
	}elseif($myprofile_optional_username){
		"$myprofile_optional_username"
	}elseif($myprofile_hide_username) {
		"<hidden>"	
	}else{
		"$env:USERNAME"
	}

	Write-Host("") -NoNewline -ForegroundColor $shell_wallpaper_color -BackgroundColor $user_background_color
	Write-Host($username + "  " + $env:COMPUTERNAME + " ") -NoNewline -BackgroundColor $user_background_color -ForegroundColor $user_foreground_color
	Write-Host("") -NoNewline -ForegroundColor $user_background_color -BackgroundColor $shell_wallpaper_color

	#
	# Write user end -------------------------------------------------------------------------------------
	# 

	#
	# Write git branch -------------------------------------------------------------------------
	#

	if("" -ne $(get_git_branch)){
		Write-Host("") -NoNewline -ForegroundColor $shell_wallpaper_color -BackgroundColor $git_branch_background_color
		Write-Host("") -NoNewline -ForegroundColor $git_branch_foreground_color -BackgroundColor $git_branch_background_color
		Write-Host(get_git_branch) -NoNewline -ForegroundColor $git_branch_foreground_color -BackgroundColor $git_branch_background_color
		Write-Host("") -NoNewline -ForegroundColor $git_branch_background_color -BackgroundColor $shell_wallpaper_color
		#Write-Host("") -NoNewline -ForegroundColor $git_branch_background_color
	}

	#
	# git branch end -------------------------------------------------------------------------
	#

	#
	# Write path -------------------------------------------------------------------------
	#
	
	$path_string = "$($executionContext.SessionState.Path.CurrentLocation)"
	$path_string = $path_string.Replace("$env:HOMEDRIVE$env:HOMEPATH\source\repos", "`u{f121} ")
	$path_string = $path_string.Replace("$env:HOMEDRIVE$env:HOMEPATH", "`u{f015} ")
	$path_string = $path_string.Replace("$env:ONEDRIVE", " ")
	$path_string = $path_string.Replace("\", "`u{e0bd} ")
	$path_string = $path_string.Replace(":", "")
	
	Write-Host("") -NoNewline -ForegroundColor $shell_wallpaper_color -BackgroundColor $path_background_color
	Write-Host("   ") -NoNewline -BackgroundColor $path_background_color -ForegroundColor $path_foreground_color
	Write-Host($path_string) -nonewline -ForegroundColor $path_foreground_color -BackgroundColor $path_background_color
	Write-Host("") -nonewline -ForegroundColor $path_background_color 
	
	#
	# Write path end -------------------------------------------------------------------------
	#
	
	
	Write-Host("".PadLeft(5)) -NoNewline

	#
	# check return val -----------------------------------------------------------------------
	#
	
	$last_return_color = ""
	$last_return_value = ""
	if($last_return){
		$last_return_color = $return_code_success_color
		$last_return_value = "   "
	}else{
		$last_return_color = $return_code_failed_color
		$last_return_value = "   "
	}
	
	Write-Host("") -NoNewline -ForegroundColor $last_return_color
	Write-Host($last_return_value) -NoNewline -ForegroundColor $return_foreground_color -BackgroundColor $last_return_color
	Write-Host("") -NoNewline -ForegroundColor $shell_wallpaper_color -BackgroundColor $last_return_color

	#
	# check return val end -----------------------------------------------------------------------
	#
	
	#
	# write time -----------------------------------------------------------------------
	#
	

	Write-Host("") -NoNewline -ForegroundColor $time_background_color
	Write-Host("  ") -NoNewline -ForegroundColor $time_foreground_color -BackgroundColor $time_background_color
	Write-Host((Get-Date -UFormat "%H:%M:%S")) -NoNewline -ForegroundColor $time_foreground_color -BackgroundColor $time_background_color

	$currentHour = [int](Get-Date -UFormat "%H")
	if(($currentHour -le 7) -Or ($currentHour -ge 19)){
		Write-Host("  ") -NoNewline -ForegroundColor $moon_color -BackgroundColor $time_background_color
	}else{
		Write-Host("  ") -NoNewline -ForegroundColor $sun_color -BackgroundColor $time_background_color
	}

	Write-Host("") -NoNewline -ForegroundColor $time_background_color
	Write-Host("") -NoNewline -ForegroundColor $time_background_color

	#
	# write time end-----------------------------------------------------------------------
	#
	
	#prompt
	Write-Host 
	$prompt_color = "Gray"
	Write-Host($("└─" * ($nestedPromptLevel + 1))) -NoNewline -ForegroundColor Green
	Write-Host("") -NoNewline -ForegroundColor $prompt_color

	
	return " "
}
