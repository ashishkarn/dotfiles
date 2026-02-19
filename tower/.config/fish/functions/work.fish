function work
    set name $argv[1]
    if test -z "$name"
        set name (basename (pwd))
    end

    set cwd (pwd)

    if tmux has-session -t $name 2>/dev/null
        if test -n "$TMUX"
            tmux switch-client -t $name
        else
            tmux attach -t $name
        end
        return
    end

    tmux new-session -d -s $name -n nvim -c $cwd
    tmux send-keys -t $name:nvim "nvim ." Enter

    tmux new-window -t $name -n terminal -c $cwd

    tmux new-window -t $name -n claude -c $cwd

    tmux select-window -t $name:nvim

    if test -n "$TMUX"
        tmux switch-client -t $name
    else
        tmux attach -t $name
    end
end
