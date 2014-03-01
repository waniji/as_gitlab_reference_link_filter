class GitlabReferenceLinkFilter < AsakusaSatellite::Filter::Base

  def process(text, opts={})
    room = opts[:room]
    info = room.yaml[:gitlab_reference]
    text.gsub!(/#(\d+)/) {|id|
      reference $1, id, info, 'issues'
    }
    text.gsub!(/!(\d+)/) {|id|
      reference $1, id, info, 'merge_requests'
    }
    text.gsub!(/\$(\d+)/) {|id|
      reference $1, id, info, 'snippets'
    }
    text
  end

  def process_all(lines, opts={})
    # generated method
    # modify here
    lines
  end

  private
  def reference(id, ref, info, type)
    root_url = info['root']
    root_url << '/' unless root_url.end_with?('/')
    repository = info['repository_name']
    repository << '/' unless repository.end_with?('/')
    url = URI.join(root_url, repository, "#{type}/#{id}")
    return %[<a target="_blank" href="#{url}">#{ref}</a>]
  end

end

