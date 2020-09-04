import { __ } from '~/locale';

export const SNIPPET_VISIBILITY_PRIVATE = 'private';
export const SNIPPET_VISIBILITY_INTERNAL = 'internal';
export const SNIPPET_VISIBILITY_PUBLIC = 'public';

export const SNIPPET_VISIBILITY = {
  [SNIPPET_VISIBILITY_PRIVATE]: {
    label: __('Private'),
    icon: 'lock',
    description: __('The snippet is visible only to me.'),
    description_project: __('The snippet is visible only to project members.'),
  },
  [SNIPPET_VISIBILITY_INTERNAL]: {
    label: __('Internal'),
    icon: 'shield',
    description: __('The snippet is visible to any logged in user.'),
  },
  [SNIPPET_VISIBILITY_PUBLIC]: {
    label: __('Public'),
    icon: 'earth',
    description: __('The snippet can be accessed without any authentication.'),
  },
};

export const SNIPPET_CREATE_MUTATION_ERROR = __("Can't create snippet: %{err}");
export const SNIPPET_UPDATE_MUTATION_ERROR = __("Can't update snippet: %{err}");
export const SNIPPET_BLOB_CONTENT_FETCH_ERROR = __("Can't fetch content for the blob: %{err}");

export const SNIPPET_BLOB_ACTION_CREATE = 'create';
export const SNIPPET_BLOB_ACTION_UPDATE = 'update';
export const SNIPPET_BLOB_ACTION_MOVE = 'move';
export const SNIPPET_BLOB_ACTION_DELETE = 'delete';

export const SNIPPET_MAX_BLOBS = 10;
