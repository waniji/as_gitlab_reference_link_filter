# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
require 'gitlab_reference_link_filter'

describe GitlabReferenceLinkFilter do
  before do
    @config = { :room =>
      OpenStruct.new(:yaml => {
          :gitlab_reference => {
            'root' => 'http://gitlab.example.com/',
            'repository_name' => 'user/repository',
          }})
    }
    @filter = GitlabReferenceLinkFilter.new({})
  end

  context "Merge requestへのリンク" do
    subject {
      @filter.process("foo !223", @config)
    }
    it {
      should == 'foo <a target="_blank" href="http://gitlab.example.com/user/repository/merge_requests/223">!223</a>'
    }
  end

  context "Issueへのリンク" do
    subject {
      @filter.process("foo #223", @config)
    }
    it {
      should == 'foo <a target="_blank" href="http://gitlab.example.com/user/repository/issues/223">#223</a>'
    }
  end

  context "Snippetへのリンク" do
    subject {
      @filter.process("foo $223", @config)
    }
    it {
      should == 'foo <a target="_blank" href="http://gitlab.example.com/user/repository/snippets/223">$223</a>'
    }
  end

  context "複合リンク" do
    subject {
      @filter.process("foo $123 bar !456 hoge #789", @config)
    }
    it {
      should == 'foo <a target="_blank" href="http://gitlab.example.com/user/repository/snippets/123">$123</a> bar <a target="_blank" href="http://gitlab.example.com/user/repository/merge_requests/456">!456</a> hoge <a target="_blank" href="http://gitlab.example.com/user/repository/issues/789">#789</a>'
    }
  end

end
