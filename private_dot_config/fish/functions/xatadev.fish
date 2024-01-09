function xatadev
    begin
        pushd /Users/andrew/git/client-ts/
        and pnpm build
        and popd
    end
    /Users/andrew/git/client-ts/cli/bin/run.js $argv
end
