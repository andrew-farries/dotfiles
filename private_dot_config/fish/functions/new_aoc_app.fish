function new_aoc_app --description "create a new skeleton advent of code application"
  set destination $argv[1]

  if test -z "$destination"
    set destination .
  end

  if ! test -d $destination
    mkdir -p $destination
  end

  git clone git@github.com:andrew-farries/skeleton-aoc-app.git $destination
  pushd $destination
  npm install 
  rm -rf .git/
  rm src/utils/utils.test.ts
  popd
end
