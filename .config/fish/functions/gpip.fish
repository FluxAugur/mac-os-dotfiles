# allow global pip if necessary when no virtualenv is sourced
function gpip -d "Allow global pip if necessary when no virtualenv is sourced"
    begin
        set -lx PIP_REQUIRE_VIRTUALENV
        sudo -H /usr/local/bin/pip $argv
    end
end
