class AsGitlabReferenceLinkController < ApplicationController
  include RoomHelper
  def room
    find_room(params[:id]) do |room|
      @room = room
      @hash   = @room.yaml[:gitlab_reference] || {}
      if request.post? then
        @hash.merge!(params[:config])
        @room.yaml = @room.yaml.merge :gitlab_reference => @hash
        @room.save!
        flash[:notice] = t(:notice_saved)
      end
      @config = OpenStruct.new(@hash)
    end
  end

  def global
  end
end
