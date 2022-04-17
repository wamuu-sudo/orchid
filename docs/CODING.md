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
## Coding style
### Indents : Style and localization
We are using tabulations with an equivalent of 4 spaces.
Rules :
 - Always use indents when we define a function. Example :
```sh
my_function()
{
    echo "You are done" # One tab between "{" and "}"
}
```
 - Always use indents for : `for`, `if` and `when`. Example :
```sh
if [ 1 = 1 ]; then
    my_function
fi


for i in {1..5}; do
    my_function ${i}
done


while [ 1 = 1 ]; do
    my_function
done
```
Example with all things above :
```sh
my_function()
{
    if (( "${1}" <= "1" )); then
        echo '$1 must be greater than 1'
        exit
    fi

    for i in {1..$1}; do
        echo "${i} time"
        while (( "${i}" < "${1}" )); do
            echo "${i} < ${1}"
        done
    done
}
```
## Line breaks
- 2 line breaks after the end of a function. Example :
```sh
my_function()
{
    echo "You are done"
}


echo "After the function"
```
- 1 line break after `fi`, `done`. Example :
```sh
if (( "${1}" <= "1" )); then
    echo '$1 must be greater than 1'
    exit
fi

for i in {1..$1}; do
    echo "${i} time"
done

echo "End of the script"
```
 **Exception** : No line break if there are several `fi` or `done` that follow each other.
 Apply the rule **only on the last**.
```sh
if (( "${1}" <= "1" )); then
    echo '$1 must be greater than 1'
    exit
fi

for i in {1..$1}; do
    echo "${i} time"
    while (( "${i}" < "${1}" )); do
        echo "${i} < ${1}"
    done
done # <= Only on the last

echo "End of the script"
```
## if, for and while syntax
- Always write `then`, `do` on the same line than `if`, `for` and `while`. Example :
```sh
if (( "${1}" <= "1" )); then            #
    echo '$1 must be greater than 1'
    exit
fi

for i in {1..$1}; do                    #
    echo "${i} time"
    while (( "${i}" < "${1}" )); do     #
        echo "${i} < ${1}"
    done
done
```
## Nomination
### Functions
- The name of a function need to be explicit : if your function make the square root of a number, name it `square_root`.
- We are using snake_case for functions. Example : `cli_orchid_selector`, `cli_disk_selector`, `select_GPU_drivers_to_install`...
    **Exception** : You can use upper case for acronyms. Example : CPU, GPU, RAM, SDD, HDD...
### Variables
- The name of a variable need to be explicit : `DATE` for the date
- We are using snake_upper_case for functions. Example : `COLOR_YELLOW`, `CHOOSEN_DISK`...
