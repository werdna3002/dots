function fish_greeting
    if type -q cowsay; and type -q fortune
        fortune | cowsay
    end
end
