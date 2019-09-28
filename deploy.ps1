printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t hugo-tufte # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
# cd public

# Add changes to git.
git add --all

# Commit changes.
if([string]::IsNullOrEmpty($Args[0])){
    git commit -m "rebuilding site $(date)"
}else{
	git commit -m $Args[0]
}

# Push source and build repos.
git push origin master

echo done