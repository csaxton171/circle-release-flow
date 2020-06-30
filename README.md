# circle release flow

[![CircleCI][circleci-image]][circleci-url]

> small repo to experiment with various aspects of circleci, gitflow and release process

## primary scenario

1. _developer_ creates **feature branch** from latest **develop branch** - e.g. `git checkout -B feature/feat-some-feature`
2. _developer_ concludes work and submits **PR** for feature review
3. **PR** is reviewed and approved by _peer_
4. **feature branch** is merged into **develop branch**
5. **feature branch** is discarded/deleted
6. **release build** is offered by CI
7. **release build** is approved by _CODEOWNERS_. a **release branch** is created with bumped version(s) & updated documenation/changelog. release is deployed to staging environment.
8. release is tested & reviewed (both branch code & staging environment)
9. release is promoted to production ( merged to **trunk branch** and release registered)

## release rejection scenario

1. release is created
2. release is reviewed & rejected
3. release rolled back from staging && release branch discarded/deleted

## rules

1. only the automation account may merge/commit to **trunk branch** ( production )
2. only _CODEOWNERS_ may approve PRs
3. changes must have 100% test coverage in order to be promoted into **develop branch**
4. only changes from a **release branch** may be merged into **trunk branch**

## todo

- [x] implement release branch creation workflow
- [x] implement release version bump and changelog creation
- [x] implement release promotion
- [ ] implement automation merge to trunk restriction
- [ ] implement CODEOWNERS PR restriction
- [ ] test what happens when a release branch merge fails - is there some compensating action that makes sense here?
- [ ] test a release branch sync scenario ( hotfix applied to trunk )
- [ ] investigate - should multiple releases be supported

[circleci-image]: https://circleci.com/gh/csaxton171/circle-release-flow.svg?style=svg&circle-token=830211a3accaf334b38911e77da61bb52aec63bc
[circleci-url]: https://circleci.com/gh/csaxton171/circle-release-flow
