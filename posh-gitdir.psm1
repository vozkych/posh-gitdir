function Get-GitChildItem
{
	[CmdletBinding(DefaultParameterSetName='Items', SupportsTransactions=$true, HelpUri='http://go.microsoft.com/fwlink/?LinkID=113308')]
	param(
		[Parameter(ParameterSetName='Items', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
		[string[]]
		${Path},

		[Parameter(ParameterSetName='LiteralItems', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
		[Alias('PSPath')]
		[string[]]
		${LiteralPath},

		[Parameter(Position=1)]
		[string]
		${Filter},

		[string[]]
		${Include},

		[string[]]
		${Exclude},

		[Alias('s')]
		[switch]
		${Recurse},

		[switch]
		${Force},

		[switch]
		${Name}
	)

	begin
	{
		try
		{
			$outBuffer = $null
			if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
			{
				$PSBoundParameters['OutBuffer'] = 1
			}
			$wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-ChildItem', [System.Management.Automation.CommandTypes]::Cmdlet)
			$scriptCmd = {& $wrappedCmd @PSBoundParameters | Format-Table -View Dir-Git }
			$steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
			$steppablePipeline.Begin($PSCmdlet)
		}
		catch
		{
			throw
		}
	}

	process
	{
		try
		{
			$steppablePipeline.Process($_)
		}
		catch
		{
			throw
		}
	}

	end
	{
		try
		{
			$steppablePipeline.End()
		}
		catch
		{
			throw
		}
	}
	<#

	.ForwardHelpTargetName Microsoft.PowerShell.Management\Get-ChildItem
	.ForwardHelpCategory Cmdlet

	#>
}

New-Alias -Name ggci -Value Get-GitChildItem

Export-ModuleMember -Alias @('ggci') -Function @('Get-GitChildItem')
