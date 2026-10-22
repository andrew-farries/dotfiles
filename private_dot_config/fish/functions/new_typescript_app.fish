function new_typescript_app --description "create a new skeleton typescript application"
  set destination $argv[1]

  if test -z "$destination"
    set destination .
  end

  if ! test -d $destination
    mkdir -p $destination
  end

  git clone git@github.com:andrew-farries/skeleton-typescript-app.git $destination
  pushd $destination
  npm install --save-dev @types/node nodemon ts-node typescript
  rm -rf .git/
  popd
end
