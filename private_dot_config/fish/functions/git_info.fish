function git_info --description "Print an information string about the state of the git repository in the current directory"
  if not __fish_is_git_repository
    return 1;
  end

  # Run git commands to gather required information
  set git_status (command git status)
  set git_stashes (command git stash list | wc -l | sed 's/ //g')
  command git branch -a | not grep -iq 'remotes/origin/main'; set has_origin_main $status
  set contains_origin_main 0
  if test "$has_origin_main" -eq 1
    not command git merge-base --is-ancestor origin/main HEAD; set contains_origin_main $status
  end

  # Find the location of HEAD
  set branch_name (string match -ir "on branch (.+)" $git_status)[2]
  set detached_at (string match -ir "head (detached at .+)" $git_status)[2]
  set detached_from (string match -ir "head (detached from .+)" $git_status)[2]
  set rebase_desc (string match -ir "currently rebasing branch '(.+?)'" $git_status)[2]
  set rebase_i_desc (string match -ir "interactive rebase in progress; (onto .+)" $git_status)[2]

  # Find ahead/behind info
  set ahead (string match -ir "your branch is ahead of .+ by (\d+) commit" $git_status)[2]
  set behind (string match -ir "your branch is behind .+ by (\d+) commit" $git_status)[2]
  set ahead_behind (string match -ir "and have (\d+) and (\d+) different commits" $git_status)
  if test -n "$ahead_behind"
    set ahead $ahead_behind[2]
    set behind $ahead_behind[3]
  end

  # Find working tree state
  set untracked_files (string match -ir "untracked files:" $git_status)
  set staged_changes (string match -ir "changes to be committed:" $git_status)
  set unstaged_changes (string match -ir "changes not staged for commit:" $git_status)

  # Print HEAD location
  echo -ns (set_color cyan) "(" (set_color green)
  if test -n "$detached_at"
    echo -n "$detached_at"
  else if test -n "$detached_from"
    echo -n "$detached_from"
  else if test -n "$branch_name"
    echo -n "$branch_name"
    if test \( $has_origin_main -eq 1 \) -a \( $contains_origin_main -eq 0 \)
      echo -ns (set_color white) "*"
    end
  else if test -n "$rebase_desc"
    echo -n "rebasing $rebase_desc"
  else if test -n "$rebase_i_desc"
    echo -n "rebasing onto $rebase_i_desc"
  else
    echo -n "???"
  end
  echo -ns (set_color cyan) ")"

  # Print number of stashes
  if test $git_stashes -ne 0
    echo -ns (set_color cyan) " (" (set_color brblack) $git_stashes (set_color cyan)  ")"
  end

  # Print working tree state
  if test -n "$staged_changes" || test -n "$unstaged_changes" || test -n "$untracked_files"
    echo -ns (set_color cyan) " (" (set_color brblue)
    if test -n "$staged_changes"
      echo -n "S"
    end
    if test -n "$unstaged_changes"
      echo -n "M"
    end
    if test -n "$untracked_files"
      echo -n "?"
    end
    echo -ns (set_color cyan) ")"
  end

  # Print ahead/behind
  if test -n "$ahead" || test -n "$behind"
    echo -ns (set_color cyan) " ("
    if test -n "$ahead"
      printf "%s\uf431%s" (set_color yellow) $ahead
      if test -n "$behind"
        echo -n " "
      end
    end
    if test -n "$behind"
      printf "%s\uf433%s" (set_color brpurple) $behind
    end
    echo -ns (set_color cyan) ")"
  end

  echo -ns (set_color normal) " "
end
