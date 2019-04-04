export const PRIMARY_VERSION = {
  version: '10.4.0-pre',
  revision: 'b93c51849b',
};

export const NODE_DETAILS_PATH = '/admin/geo/nodes';

export const mockNodes = [
  {
    id: 1,
    url: 'http://127.0.0.1:3001/',
    primary: true,
    enabled: true,
    current: true,
    files_max_capacity: 10,
    repos_max_capacity: 25,
    clone_protocol: 'http',
    _links: {
      self: 'http://127.0.0.1:3001/api/v4/geo_nodes/1',
      repair: 'http://127.0.0.1:3001/api/v4/geo_nodes/1/repair',
      status: 'http://127.0.0.1:3001/api/v4/geo_nodes/1/status',
      web_edit: 'http://127.0.0.1:3001/admin/geo/nodes/1/edit',
    },
  },
  {
    id: 2,
    url: 'http://127.0.0.1:3002/',
    primary: false,
    enabled: true,
    current: false,
    files_max_capacity: 10,
    repos_max_capacity: 25,
    clone_protocol: 'http',
    _links: {
      self: 'http://127.0.0.1:3001/api/v4/geo_nodes/2',
      repair: 'http://127.0.0.1:3001/api/v4/geo_nodes/2/repair',
      status: 'http://127.0.0.1:3001/api/v4/geo_nodes/2/status',
      web_edit: 'http://127.0.0.1:3001/admin/geo/nodes/2/edit',
    },
  },
];

export const mockNode = {
  id: 1,
  url: 'http://127.0.0.1:3001/',
  internalUrl: 'http://127.0.0.1:3001/',
  primary: true,
  current: true,
  enabled: true,
  nodeActionActive: false,
  nodeActionsAllowed: false,
  basePath: 'http://127.0.0.1:3001/api/v4/geo_nodes/1',
  repairPath: 'http://127.0.0.1:3001/api/v4/geo_nodes/1/repair',
  statusPath: 'http://127.0.0.1:3001/api/v4/geo_nodes/1/status',
  editPath: 'http://127.0.0.1:3001/admin/geo/nodes/1/edit',
};

export const rawMockNodeDetails = {
  geo_node_id: 2,
  healthy: true,
  health: 'Healthy',
  health_status: 'Healthy',
  missing_oauth_application: false,
  attachments_count: 0,
  attachments_synced_count: 0,
  attachments_failed_count: 0,
  attachments_synced_in_percentage: '0.00%',
  db_replication_lag_seconds: 0,
  lfs_objects_count: 0,
  lfs_objects_synced_count: 0,
  lfs_objects_failed_count: 0,
  lfs_objects_synced_in_percentage: '0.00%',
  job_artifacts_count: 0,
  job_artifacts_synced_count: 0,
  job_artifacts_failed_count: 0,
  job_artifacts_synced_in_percentage: '0.00%',
  repositories_count: 12,
  repositories_failed_count: 0,
  repositories_synced_count: 12,
  repositories_synced_in_percentage: '100.00%',
  wikis_count: 12,
  wikis_failed_count: 0,
  wikis_synced_count: 12,
  wikis_synced_in_percentage: '100.00%',
  repositories_verification_failed_count: 0,
  repositories_verified_count: 12,
  repositories_verified_in_percentage: '100.00%',
  wikis_verification_failed_count: 0,
  wikis_verified_count: 12,
  wikis_verified_in_percentage: '100.00%',
  repositories_checksummed_count: 12,
  repositories_checksum_failed_count: 0,
  repositories_checksummed_in_percentage: '100.00%',
  wikis_checksummed_count: 12,
  wikis_checksum_failed_count: 0,
  wikis_checksummed_in_percentage: '100.00%',
  replication_slots_count: null,
  replication_slots_used_count: null,
  replication_slots_used_in_percentage: '0.00%',
  replication_slots_max_retained_wal_bytes: null,
  last_event_id: 3,
  last_event_timestamp: 1511255200,
  cursor_last_event_id: 3,
  cursor_last_event_timestamp: 1511255200,
  last_successful_status_check_timestamp: 1515142330,
  version: '10.4.0-pre',
  revision: 'b93c51849b',
  selective_sync_type: 'namespaces',
  namespaces: [
    {
      id: 54,
      name: 'platform',
      path: 'platform',
      kind: 'group',
      full_path: 'platform',
      parent_id: null,
    },
    {
      id: 4,
      name: 'Twitter',
      path: 'twitter',
      kind: 'group',
      full_path: 'twitter',
      parent_id: null,
    },
    {
      id: 3,
      name: 'Documentcloud',
      path: 'documentcloud',
      kind: 'group',
      full_path: 'documentcloud',
      parent_id: null,
    },
  ],
  storage_shards: [
    {
      name: 'default',
      path: '/home/kushal/GitLab/geo/repositorie',
    },
  ],
  storage_shards_match: false,
};

export const mockNodeDetails = {
  id: 2,
  health: 'Healthy',
  healthy: true,
  healthStatus: 'Healthy',
  version: '10.4.0-pre',
  revision: 'b93c51849b',
  primaryVersion: '10.4.0-pre',
  primaryRevision: 'b93c51849b',
  statusCheckTimestamp: 1515142330,
  replicationSlotWAL: 502658737,
  missingOAuthApplication: false,
  storageShardsMatch: false,
  repositoryVerificationEnabled: true,
  replicationSlots: {
    totalCount: 1,
    successCount: 1,
    failureCount: 0,
  },
  repositories: {
    totalCount: 12,
    successCount: 12,
    failureCount: 0,
  },
  wikis: {
    totalCount: 12,
    successCount: 12,
    failureCount: 0,
  },
  lfs: {
    totalCount: 0,
    successCount: 0,
    failureCount: 0,
  },
  jobArtifacts: {
    totalCount: 0,
    successCount: 0,
    failureCount: 0,
  },
  attachments: {
    totalCount: 0,
    successCount: 0,
    failureCount: 0,
  },
  repositoriesChecksummed: {
    totalCount: 12,
    successCount: 12,
    failureCount: 0,
  },
  wikisChecksummed: {
    totalCount: 12,
    successCount: 12,
    failureCount: 0,
  },
  verifiedRepositories: {
    totalCount: 12,
    successCount: 12,
    failureCount: 0,
  },
  verifiedWikis: {
    totalCount: 12,
    successCount: 12,
    failureCount: 0,
  },
  lastEvent: {
    id: 3,
    timeStamp: 1511255200,
  },
  cursorLastEvent: {
    id: 3,
    timeStamp: 1511255200,
  },
  selectiveSyncType: 'namespaces',
  dbReplicationLag: 0,
};
