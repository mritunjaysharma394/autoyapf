# autoyapf

Worried whether your Python code is following the style  guidelines or not? Well, you don't need to do that now :smile:

**autoyapf** is a GitHub action for [yapf](https://github.com/google/yapf), an open-source tool that automatically formats Python code to conform to the PEP 8 style guide. 
It is in essence, the algorithm that takes the code and reformats it to the best formatting that conforms to the style guide, even if the original code didn't violate the style guide.

This action is designed to be used in conjunction with the 'push' trigger. In simple words - everytime **the maintainer pushes the code from thier own playground or merges a Pull Request from a contributor it will be 
formatted automatically with the PEP 8 Style guidelines** using the *yapf* tool. This action is a win-win situation for **both contributors and maintainers** of projects involving Python! Yes, you heard it right! 

This action will immensely help in increasing the speed of development cycle of projects as you will no longer need to worry about whether clean code is being produced 
or not as **autoyapf** action will take care of that :confetti_ball:

## Usage
### Step 1:
Create a `.github/workflows` directory in your repository and inside this directory create a workflow `.yml` file (give the file a name like `autoyapf.yml`). An example workflow is available below. For more information, reference the GitHub Help Documentation for [Creating a workflow file](https://help.github.com/en/articles/configuring-a-workflow#creating-a-workflow-file).

### Step 2: 
Copy the workflow example below in the `.yml` file you created in `.github/workflows` directory.
The following workflow is a simple example to demonstrate how the action works.

```yaml
name: Formatting python code
on: push
jobs:
  autoyapf:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
        with:
          ref: ${{ github.head_ref }}
      - name: autoyapf
        id: autoyapf
        uses: mritunjaysharma394/autoyapf@v2
        with:
          args: --style pep8 --recursive --in-place .
      - name: Check for modified files
        id: git-check
        run: echo ::set-output name=modified::$(if git diff-index --quiet HEAD --; then echo "false"; else echo "true"; fi)
      - name: Push changes
        if: steps.git-check.outputs.modified == 'true'
        run: |
          git config --global user.name 'Maintainer Name' 
          git config --global user.email 'github_user_name_of_maintainer@users.noreply.github.com' 
          git remote set-url origin https://x-access-token:${{ secrets.GITHUB_TOKEN }}@github.com/${{ github.repository }}
          git commit -am "Automated autoyapf fixes"
          git push
```

**Note**:  
1. `GITHUB_TOKEN` is provided by Actions, you do not need to create your own token.
2. If you are the Project Maintainer/Developer and you want to use this action in your project, please change the 'Maintainer Name' and 'github_user_name_of_maintainer'
accordingly in `git config --global user.name 'Maintainer Name'` and `git config --global user.email 'github_user_name_of_maintainer@users.noreply.github.com'` respectively
in the above `.yml` file


## Working example
This configuration will work something like this. As an example here, my friend Naman is contributing to the Project with a Pull Request of a code that is not formatted or styled. On
merging this PR, `autoyapf` action will be triggered which will automatically style the code according to PEP-8 Guidelines.:

**1. Pull Request Initiated by Naman which I later merged**

![Pull Request Initiated by Naman](https://github.com/mritunjaysharma394/autoyapf/blob/master/assets/PR_initiated.png)

**2. GitHub Action worked successfully**

![GitHub Action worked successfully](https://github.com/mritunjaysharma394/autoyapf/blob/master/assets/GitHub_Action_at_work.png)

**3. Automated code fixes commit by autoyapf action**
![Automated code fixes commit](https://github.com/mritunjaysharma394/autoyapf/blob/master/assets/Automated_fix_commit.png)

**4. Visible changes in code after the autoyapf fix**
![Visible changes in code after the autoyapf fix](https://github.com/mritunjaysharma394/autoyapf/blob/master/assets/Visible_changes_in_code.png)

Note that due to [token restrictions on public repository forks](https://docs.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token#permissions-for-the-github_token), this workflow does not work for pull requests raised from forks.
Private repositories can be configured to [enable workflows](https://docs.github.com/en/github/administering-a-repository/disabling-or-limiting-github-actions-for-a-repository#enabling-workflows-for-private-repository-forks) from forks to run without restriction. 

## Contributing
We would love you to contribute to `@actions/autoyapf`, pull requests are welcome! Please see the [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## License
The scripts and documentation in this project are released under the [MIT License](LICENSE)
