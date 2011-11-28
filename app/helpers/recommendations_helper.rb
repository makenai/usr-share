module RecommendationsHelper
  
  def voting_class( user, recommendation )
    return '' unless user
    case user.voted_as_when_voting_on( recommendation )
    when true
      'upvoted'
    when false
      'downvoted'
    else
      ''
    end
  end
  
end
