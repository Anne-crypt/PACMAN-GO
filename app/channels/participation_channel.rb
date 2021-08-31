class ParticipationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    participation = Participation.find(params[:id])
    stream_for participation
  end
end
