# label merge-conflict action

This action adds a given label to Pull Requests that have merge conflicts and removes a given label from these pull requests

## Inputs

### `dirtyLabel`

**Required** The name of the label that should be added once a PR has merge conflicts.

### `removeOnDirtyLabel`

**Required** The name of the label that should be removed once a PR has merge conflicts.

### `repoToken`

**Required** Token for the repository. Can be passed in using {{ secrets.GITHUB_TOKEN }}

## Example usage

```yaml
name: "Maintenance"
on:
  # So that PRs touching the same files as the push are updated
  push:
  # So that the `dirtyLabel` is removed if conflicts are resolved
  pull_request:
    types: [synchronize]

jobs:
  main:
    runs-on: ubuntu-latest
    steps:
      - name: check if prs are dirty
        uses: eps1lon/actions-label-merge-conflict@releases/1.x
        with:
          dirtyLabel: "PR: needs rebase"
          removeOnDirtyLabel: "PR: ready to ship"
          repoToken: "${{ secrets.GITHUB_TOKEN }}"
```
