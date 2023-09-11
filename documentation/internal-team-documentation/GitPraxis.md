# FlexiCharge 2023 Git Guidelines

Git workflows will be structured according to a `Main -> Dev -> Feature` branch method. This means that there will be no requirements to work using GitHub forks, instead all the work done by a squad will be done in one repository using branches.

## Main and Dev

Your repo will be made to have a branch named "Main" and a branch named "Dev". These will be permanent branches throughout the project and will therefore have special protections.

The Dev branch will be the branch that your squad develops on. It will be protected against force pushes, normal pushes, and removal. By having these protections, you guarantee that nobody will accidentally remove the past weeks worth of work. Therefore all changes will be applied through Pull Requests (PR) that will require one other team-member to review the PR before it is approved and pulled into the Dev branch. This other team-member has the responsibility of making sure the PR fulfills your squads Definition of Done, code standard, and any other requirements your squad puts on committed work. If it does not, then they will **not** approve the PR and point out errors though comments. Only once the PR is free of errors will it be approved. The person who created the PR may then complete the PR.

The Main branch is the branch that other squads will use. This branch is therefore guarded at a higher standard than the Dev branch. Only once the work done on the Dev branch is at a stable and "good" state is it time to create a PR. There is also only a single person able to approve PRs into the Main branch, and this is the Build Master. The Build Master has the final say on the state of a PR into Main. Only PRs from Dev will be approved, and only a single PR from Dev should exist at the same time to avoid conflicts.

## Feature Branches

Work conducted in your squads repository will be done through "feature branches". These are branches created for single GitHub issues. Work done on this branch shall only be related to that issue. Only a single person should also work in each feature branch, meaning they are *personal*. Only the creator of a feature branch is allowed to "Force Push" to it.

Feature branches should only be created from the Dev branch. If your work is reliant on the work done in another feature branch, you should wait for that work to be pulled into the Dev branch, then pull the latest version of the Dev branch into your feature branch.

Once a the PR of a feature branch is approved and completed, that branch is dead and shall be removed. Remember to remove dead branches locally too.

### Naming feature branches

To make it really clear what issue is related to what branch, you shall name your feature branches according to the following template:

```txt
x/y-z

x = 'feature' or 'bug' or 'hotfix'
y = GitHub issue number
z = Name of issue/branch
```

Example: `feature/#13-add-xray-drivers`

## Visual Aid

```txt
       Main ────────────────────►
                          ▲
     - - - - - - - - - - -│- - -
                          │
        Dev ─────┬─────┬──┴─────►
    - - - - - - -│- -▲-│-▲- -▲- -
                 │   │ │ │   │
  Feature      a ├───┘ │ │   │
   Branches      │     │ │   │
               b └─────┼─┘   │
                       │     │
                     c └─────┘
```
