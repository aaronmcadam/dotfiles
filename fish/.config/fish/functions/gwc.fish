function gwc --description "Create a new git worktree"
    if test (count $argv) -eq 0
        echo "Usage: gwc <branch-name>"
        return 1
    end
    git create-worktree -b $argv[1]
    and cd $argv[1]
end
