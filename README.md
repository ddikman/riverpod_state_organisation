# riverpod_state_organisation

A project to show how to organise state in a Riverpod project.

## Challenges covered

- Updating single references instead of the entire list of items on updates
- Invalidating a single item should invalidate that item in the list
- Pre-loading several items and then refreshing single instances

## Advanced

- Caching and updating async values [see this](https://docs-v2.riverpod.dev/docs/essentials/combining_requests)
- Optimistic updates [see this](https://github.com/rrousselGit/riverpod/issues/2625)
- Optimistic error handling. [This example](https://github.com/rrousselGit/riverpod/issues/2625) shows how to do it but not how to raise errors to the UI.
- Eager loading by using `ref.watch` [see this](https://docs-v2.riverpod.dev/docs/essentials/eager_initialization)
- Crud with notifier lists [see example repository](https://github.com/dhafinrayhan/dummymart)

## Key concepts

- A future provider will show a loader the first time it is loaded, if the value is invalidated, it will update the value when it gets it but not before that
- An `autoDispose` provider will dispose the value when the widget is disposed (leaves screen), meaning the next time it is accessed it will be re-created

## Gotchas

- Use `ref.watch` inside build methods or methods called by build methods, use `ref.read` otherwise
- Which provider is the `source` of the state? Is it a list provider or the single provider? (for updates)
- Having `single item` notifier providers, the name of the provider can clash with the model, such as `Todo`.