<#
.SYNOPSIS
    Este script saluda a los nombres recibidos por pipeline.

.DESCRIPTION
    El script recibe nombres a través del pipeline y les envía un saludo. 
    Puedes especificar el tipo de saludo utilizando el parámetro -Saludo.

.PARAMETER String
    El nombre del usuario a saludar. Este parámetro es obligatorio y se recibe por pipeline.

.PARAMETER Saludo
    El tipo de saludo a utilizar. Puede ser "hola", "adios" o "hasta luego". 
    El valor predeterminado es "adios".

.EXAMPLE
    "Juan", "María", "Pedro" | ./Say-Hello.ps1 -Saludo "hola"
    Este comando saludará a Juan, María y Pedro con "hola".

.EXAMPLE
    "Juan", "María", "Pedro" | ./Say-Hello.ps1
    Este comando saludará a Juan, María y Pedro con "adios" (valor predeterminado).
#>

[CmdletBinding()]
param(
  [Parameter(ValueFromPipeline, Mandatory = $true, HelpMessage = "Introduce el nombre del usuario a saludar.")]
  [string]$String,

  [Parameter(Mandatory = $false)]
  [ValidateSet("hola", "adios", "hasta luego")]
  [string]$Saludo = "adios"
)

Begin {
  $var = 1
  Write-Verbose "Begin $var"
}

Process {
  function Generate-Password {
    param (
      [Parameter(Mandatory)]
      [int] $length,
      [int] $amountOfNonAlphanumeric = 1
    )
    Add-Type -AssemblyName 'System.Web'
    return [System.Web.Security.Membership]::GeneratePassword($length, $amountOfNonAlphanumeric)
  }


  #Read more: https://www.sharepointdiary.com/2020/04/powershell-generate-random-password.html#ixzz8kYVZX3ed
  $password = Generate-Password(10)
  Write-Output "$Saludo $String tu contraseña $password"
  Write-Verbose "Process: $String y es $var"
  $var++
}

End {
  Write-Verbose "End"
}
