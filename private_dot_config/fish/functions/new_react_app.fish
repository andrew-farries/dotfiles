function new_react_app --description "create a new skeleton react application"
  set destination $argv[1]

  if test -z "$destination"
    set destination .
  end

  if ! test -d $destination
    mkdir -p $destination
  end

  if ! test -d ~/skeleton-react-app
    echo "Unable to find ~/skeleton-react-app"
    return 1;
  end

  cp -r ~/skeleton-react-app/. $destination
  pushd $destination
  npm install react react-dom
  npm install --save-dev parcel
  popd
end
