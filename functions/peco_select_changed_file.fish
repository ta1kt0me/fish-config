function peco_select_changed_file -d "display git changed file by peco"
  git status -sb | sed -n '1d;p' | peco | rev | cut -d ' ' -f 1 | rev | read file

  if test -n "$file"
      commandline "$file"
  end
end
