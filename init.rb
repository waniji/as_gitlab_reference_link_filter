require 'asakusa_satellite/config'
require 'gitlab_reference_link_filter'
AsakusaSatellite::Config.room("GitLab Reference Link",
                              :controller=>:as_gitlab_reference_link, :action=> :room)

