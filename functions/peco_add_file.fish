function peco_add_file -d "git add seleted file by peco"
  git status -sb | peco | rev | cut -d ' ' -f 1 | rev | tr '\n' ' ' | read files

  if test -n "$files"
      commandline "git add -p $files"
  end
end
