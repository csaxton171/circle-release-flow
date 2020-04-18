# circle release flow

[![CircleCI][circleci-image]][circleci-url]

> small repo to experiment with various aspects of circleci, gitflow and release process

## scenarios

### basic feature development

1. user creates **feature** branch
2. user creates PR
3. PR is approved and merged into **develop** branch

PR should be validated for:

- test + coverage
- standards/style

validation should occur for as many iterations of feedback until PR is either accepted or closed.

merge should be blocked until approval and status check passes.

### release [basic]

1. user initiates release
2. validation passes
3. deployment to staging succeeds
4. user reviews release changes and approves
5. all merge checks and validation pass
6. merge to master and develop occurs
7. release branch is deleted
8. deployment to production succeeds

### release [validation fails]

1. user intiates release
2. validation fails
3. workflow stops and release branch is preserved

### release [user disapproves release]

1. user initiates release
2. validation passes
3. deployment to staging succeeds
4. user reviews release changes and disapproves
5. workflow stops and release branch is preserved

[circleci-image]: https://circleci.com/gh/csaxton171/circle-release-flow.svg?style=svg&circle-token=830211a3accaf334b38911e77da61bb52aec63bc
[circleci-url]: https://circleci.com/gh/csaxton171/circle-release-flow
