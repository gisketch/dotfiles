# zoxide init
Invoke-Expression (& { (zoxide init powershell | Out-String) }) | Out-Null

$env:Path += ";C:\Program Files\PostgreSQL\18\bin"
$env:Path += ";C:\Program Files\PostgreSQL\18\lib"

# oh-my-posh
oh-my-posh init pwsh --config ~/.config/oh-my-posh/theme.omp.json | Invoke-Expression

# Remove conflicting aliases if they exist
$unixCommands = 'ls','rm','cp','mv','cat','mkdir','touch','man'
foreach ($c in $unixCommands) {
        if (Get-Command $c -ErrorAction SilentlyContinue) {
                    Remove-Item Alias:$c -ErrorAction SilentlyContinue
                        }
}

# Unix-style commands mapped to PowerShell / external executables
function ls { & eza --icons=always --color=always --git --group-directories-first @args }

function rm { Remove-Item @args -Force }  # like Unix rm -f
function cp { Copy-Item @args -Force }    # like Unix cp -f
function mv { Move-Item @args }           # like Unix mv
function cat { Get-Content @args }        # like Unix cat
function mkdir { New-Item -ItemType Directory @args }  # like mkdir
function touch { if (-Not (Test-Path $args)) { New-Item $args -ItemType File | Out-Null } else { (Get-Item $args).LastWriteTime = Get-Date } } # like touch

# Remove any conflicting aliases first
$gitAliases = 'g', 'gst', 'gco', 'gcm', 'gpl', 'gps', 'gbr', 'gam', 'gap'
foreach ($a in $gitAliases) {
        if (Get-Command $a -ErrorAction SilentlyContinue) {
                    Remove-Item Alias:$a -ErrorAction SilentlyContinue
                        }
}

# Git shortcuts
function g { git @args }
function gst { git status @args }
function gco { git checkout @args }
function gcm { git commit @args }
function gpl { git pull @args }
function gps { git push @args }
function gbr { git branch @args }
function gam { git add @args }
function gap { git add -p @args }
function vim { neovide --frame none @args }

pokemonshow
