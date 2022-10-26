function new_react_app --description "create a new skeleton react application"
  set destination $argv[1]

  if test -z "$destination"
    set destination .
  end

  if ! test -d $destination
    mkdir -p $destination
  end

  git clone git@github.com:andrew-farries/skeleton-react-app.git $destination
  pushd $destination
  npm install react react-dom
  npm install --save-dev parcel
  popd
end
