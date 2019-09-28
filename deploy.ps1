#!/bin/sh

# colors reference
# http://web.theurbanpenguin.com/adding-color-to-your-output-from-c/

$color_red = "\033[1;31m"
$color_green = "\033[1;32m"
$color_end = "\033[0m"

if ([string]::IsNullOrEmpty($("git status -s"))){ 
    printf "$color_red The working directory is dirty. Please commit any pending changes. $color_end\n"
    exit 1;
}

printf "$color_green Deleting old publication $color_end\n"
Remove-Item -LiteralPath "public" -Force -Recurse
mkdir public
git worktree prune
Remove-Item -LiteralPath ".git/worktrees/public/" -Force -Recurse

printf "$color_green Checking out gh-pages branch into public $color_end\n"
git worktree add -B gh-pages public upstream/gh-pages

printf "$color_green Removing existing files $color_end\n"
Remove-Item -LiteralPath "public/*" -Force -Recurse

printf "$color_green Generating site $color_end\n"
hugo

printf "$color_green Updating gh-pages branch $color_end\n"
cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"

#echo "Pushing to github"
git push --all
cd ..

printf "$color_green Done $color_end\n"
