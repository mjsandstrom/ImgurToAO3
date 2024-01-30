param(
[Parameter(Mandatory)]
[string]$SourcePath,

[Parameter(Mandatory)]
[string]$OutputFileName,

[string] $ImagesBeforePath,

[string] $ImagesAfterPath
)


function Delete-Output-Files-If-Exist {
    param(
        [string] $fixedFilePath,
        [string] $outputFilePath
    )
    if(Test-Path $fixedFilePath)
    {
        Remove-Item $fixedFilePath -verbose
    }

    if(Test-Path .\$outputFilePath)
    {
        Remove-Item .\$outputFilePath -verbose
    }
}


function Create-Empty-Output-Files {
    param(
        [string] $fixedFilePath,
        [string] $outputFilePath
    )
    New-Item .\$outputFilePath -ItemType File
    New-Item .\$fixedFilePath -ItemType File
}


function Populate-Fixed-File {
    param(
        [string] $fixedFilePath,
        [string] $sourceFilePath
    )
    #Get the source file and read its content
    $sourceFile = Get-Item .\$sourceFilePath
    $streamReader = New-Object -TypeName System.IO.StreamReader -ArgumentList $sourceFile

    while (($currentLine = $streamReader.ReadLine()) -ne $null)
    {
        #Add a delimiting character between any HTML tags that are next to each other.
        $newLine = $currentLine.Replace('><', '>|<').Replace('> <','>|<').Trim()
        $array = $newLine.Split('|')

        #Write fixed version of the source file
        Add-Content .\$fixedFilePath $array
    }
}


function Add-Html-Images-To-Output-File {
    param(
        [string] $fixedFilePath,
        [string] $outputFilePath
    )

    #Get the fixed file and read its content
    $fixedSourceFile = Get-Item .\$fixedFilePath
    $streamReader = New-Object -TypeName System.IO.StreamReader -ArgumentList $fixedSourceFile

    while (($currentLine =$streamReader.ReadLine()) -ne $null)
    {
        #Write only lines with image, ruling out images from the Imgur UI
        if ($currentLine.Contains('<img') -and -not($currentLine.Contains('class=')) -and -not($currentLine.Contains('style=')) -and -not($currentLine.Contains('blob')) -and -not($currentLine.Contains('icon')) -and -not($currentLine.Contains('scorecard')) -and -not($currentLine.Contains('img data-bid-id=')))
        {
            #Alter the HTML
            $printLine = $currentLine.Replace('/>','>').Replace('>',' width="100%"/><br/>').Replace('<img','<img alt=""').Trim()
            Add-Content .\$outputFilePath $printLine
            Write-Host $printLine -ForegroundColor gray
        }
    }
    
}


function Add-Text-Images-To-Output-File {
    param(
        [string] $listFilePath,
        [string] $outputFilePath
    )

    if ($listFilePath -ne $null) {
        #Get the txt file and read its content
        $listFile = Get-Item .\$listFilePath
        $streamReader = New-Object -TypeName System.IO.StreamReader -ArgumentList $listFile

        while (($currentLine =$streamReader.ReadLine()) -ne $null)
        {
            #Create HTML tags
            $printLine = '<img alt="" src="' + $currentLine + '" width="100%"/><br/>'
            Add-Content .\$outputFilePath $printLine
            Write-Host $printLine -ForegroundColor gray
        }
    } 
}

Write-Host "Creating empty file for 'fixed' HTML with relevant images..." -ForegroundColor green
$fixedSourceFilePath = $SourcePath.Replace('.html', '_fixed.html')

Write-Host ''
Write-Host "Deleting previous versions of output files..." -ForegroundColor green
Delete-Output-Files-If-Exist -fixedFilePath $fixedSourceFilePath -outputFilePath $OutputFileName

Write-Host ''
Write-Host "Creating (or recreating) empty output files..." -ForegroundColor green
Create-Empty-Output-Files -fixedFilePath $fixedSourceFilePath -outputFilePath $OutputFileName

Write-Host ''
Write-Host "Transferring relevant image tags to 'fixed' HTML files..." -ForegroundColor green
Populate-Fixed-File -fixedFilePath $fixedSourceFilePath -sourceFilePath $SourcePath

if ($ImagesBeforePath -ne $null) {
    Write-Host ''
    Write-Host "Adding images from 'before' file ("$ImagesBeforePath" )..." -ForegroundColor green
    Add-Text-Images-To-Output-File -listFilePath $ImagesBeforePath -outputFilePath $OutputFileName
}

Write-Host ''
Write-Host "Adding images from 'fixed' HTML file ("$fixedSourceFilePath" )..." -ForegroundColor green
Add-Html-Images-To-Output-File -fixedFilePath $fixedSourceFilePath -outputFilePath $OutputFileName

if ($ImagesBeforePath -ne $null) {
    Write-Host ''
    Write-Host "Adding images from 'after' file ("$ImagesAfterPath" )..." -ForegroundColor green
    Add-Text-Images-To-Output-File -listFilePath $ImagesAfterPath -outputFilePath $OutputFileName
}

Write-Host ''
Read-Host -Prompt 'Finished. Press Enter to exit'