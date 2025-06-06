function load_dotenv
    set env_file $argv[1]
    if test -z "$env_file"
        set env_file ~/dotfiles/.env.local
    end
    
    if test -f "$env_file"
        for line in (cat "$env_file")
            if test -n "$line" && not string match -q "#*" $line
                set -gx (echo $line | string split "=")
            end
        end
    end
end
