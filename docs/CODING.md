# Coding Conventions and Guidelines

## Branch strategy
We use github-flow: https://docs.github.com/en/get-started/quickstart/github-flow

The main branch is what we ship to users. It MUST be usable at all time.

If you develop a new feature, use a new branch. Do the job and when it's ready for production and tested, ask for a pull request.

### Working on a feature within in branch:
```
$ git pull origin main  # sync your local main copy with github
$ git branch my-feat  # create a branch named "my-feat"; use any name you like.
$ git checkout my-feat   # change to the new branch

# At this point, do your changes localy on your branch

# When it is ready to merge to main branch:
$ git add --all   # add your changes to git
$ git commit -am "A great label for your feature"   # Give a meaningful label to your changes
$ git checkout main   # change to the main branch
$ git pull origin main  # Pull all changes from flathub to your local copy
$ git push origin my-feat   # push your changes made in the my-feat branch to github. This will create a branch named my-feat on github
# Look carefully at the command output:
remote: Create a pull request for 'my-feat' on GitHub by visiting:
remote:      https://github.com/wamuu-sudo/orchid/pull/new/my-feat
                        ^^ Use this link in your browser to ask for a pull request on flathub, i.e. ask to merge your changes into main
```
### After your pull request is accepted, you can now delete your branch:
```
$ git checkout main   # change to the main branch if needed
$ git pull origin main  # sync your local main copy with github
$ git branch -d my-feat  # delete your local branch
$ git push origin -d my-feat  # delete your branch on github
```
