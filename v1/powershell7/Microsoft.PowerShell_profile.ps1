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

function aw{
	aws-vault exec rockcutter -- aws $args
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
	$my_color_1 = "DarkGray"

	$shell_icon_color = "DarkRed"
	$sun_color = "DarkYellow"
	$moon_color = "Yellow"
	$shell_wallpaper_color = "Black"
	$shell_background_color = $my_color_1
	$shell_foreground_color = "White"
	$user_background_color = ""
	$user_foreground_color = "Green"
	$path_background_color = $my_color_1
	$path_foreground_color = "Blue"
	$time_background_color = "DarkGray"
	$time_foreground_color = "Red"
	$return_code_success_color = "Green"
	$return_code_failed_color = "Red"
	$return_foreground_color = "Black"
	$git_branch_foreground_color = "Magenta"
	$git_branch_background_color = "DarkRed"

	
	Write-Host("┏ ") -NoNewline -ForegroundColor White

	# write user and host -------------------------------------
	$username = if($principal.IsInRole($adminRole)){
		"admin"
	}elseif($myprofile_optional_username){
		"$myprofile_optional_username"
	}elseif($myprofile_hide_username) {
		"<hidden>"	
	}else{
		"$env:USERNAME"
	}

	Write-Host($username + "@" + $env:COMPUTERNAME + " ") -NoNewline -ForegroundColor $user_foreground_color


	# write path -------------------------------------
	Write-Host(">> ") -NoNewline -ForegroundColor White
	
	$path_string = "$($executionContext.SessionState.Path.CurrentLocation)"
	$path_string = $path_string.Replace("$env:HOMEDRIVE$env:HOMEPATH", "~")
	
	Write-Host($path_string) -nonewline -ForegroundColor $path_foreground_color 

	#
	# Write git branch -------------------------------------------------------------------------
	#

	if("" -ne $(get_git_branch)){
		Write-Host(" ") -nonewline
		Write-Host("[[") -nonewline -ForegroundColor "White" 
		Write-Host(get_git_branch) -NoNewline -ForegroundColor $git_branch_foreground_color 
		Write-Host("]]") -nonewline -ForegroundColor "White" 
	}

	#
	# git branch end -------------------------------------------------------------------------
	#

	## #
	## # write time -----------------------------------------------------------------------
	## #

	Write-Host("  ") -nonewline
	Write-Host("(") -nonewline -ForegroundColor $time_foreground_color 
	Write-Host((Get-Date -UFormat "%H:%M:%S")) -NoNewline -ForegroundColor $time_foreground_color 
	Write-Host(")") -nonewline -ForegroundColor $time_foreground_color 
 

	## #
	## # write time end-----------------------------------------------------------------------
	## #
	
	#
	# check return val -----------------------------------------------------------------------
	#
	
	Write-Host(" ") -nonewline
	$last_return_color = ""
	$last_return_value = ""
	if($last_return){
		$last_return_color = $return_code_success_color
		$last_return_value = "true"
	}else{
		$last_return_color = $return_code_failed_color
		$last_return_value = "false"
	}
	
	Write-Host($last_return_value) -NoNewline -ForegroundColor $last_return_color

	#
	# check return val end -----------------------------------------------------------------------
	#

	#prompt
	Write-Host 
	$prompt_color = "Gray"
	Write-Host($("┗" * ($nestedPromptLevel + 1))) -NoNewline -ForegroundColor "White"
	Write-Host(" ") -nonewline
	Write-Host("$") -NoNewline -ForegroundColor $prompt_color
	
	## Write-Host("┌─") -NoNewline -ForegroundColor Green
	
	return " "
}
