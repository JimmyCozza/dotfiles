function load_dotenv
    for line in (cat ~/dotfiles/.env)
        if test -n "$line" && not string match -q "#*" $line
            set -gx (echo $line | string split "=")
        end
    end
end
