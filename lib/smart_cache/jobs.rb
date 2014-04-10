module SmartCache
  module Jobs
    autoload :DelayedJob, 'smart_cache/jobs/delayed_job'
    autoload :Resque,     'smart_cache/jobs/resque'
    autoload :Sidekiq,    'smart_cache/jobs/sidekiq'
  end
end
