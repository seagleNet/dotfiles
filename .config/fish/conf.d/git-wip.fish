# Descriptions for git-wip-* subcommands.
# Registered lazily on the first prompt, after forcing fish to load its own
# git completions (on-disk or embedded), so these descriptions win.
function __git_wip_completions --on-event fish_prompt
    functions -e __git_wip_completions
    complete -C 'git ' >/dev/null # autoload stock git completions
    function __git_wip_needs_command
        test (count (commandline -opc)) -eq 1
    end
    complete -c git -n __git_wip_needs_command -f -a wip-push -d 'Push worktree to private wip ref'
    complete -c git -n __git_wip_needs_command -f -a wip-pull -d 'Apply wip ref to worktree'
    complete -c git -n __git_wip_needs_command -f -a wip-list -d 'List your wip refs on remote'
    complete -c git -n __git_wip_needs_command -f -a wip-drop -d 'Delete wip ref for current branch'
    complete -c git -n 'contains -- wip-pull (commandline -opc)' -f -s f -l force -d 'Apply even if worktree is dirty'
end
