module ApplicationHelper

  def readable_date(date)
    return "[unknown]" unless date
    return (
      "<span class='date' title='".html_safe +
      date.to_s +
      "'>".html_safe +
      time_ago_in_words(date) +
      " ago</span>".html_safe
    )
  end

  def s_end?(num)
    if num && num.abs != 1
      return "s"
    end
  end

  def link_top_work
    top_work = Work.top_work
    return link_to top_work.title, work_path(top_work)
  end

  def link_work(work_id)
    work = Work.find_by(id: work_id)
    
    if work
      return link_to work.title, work_path(work.id)
    else
      return nil
    end
  end

  def link_user(user_id)
    user = User.find_by(id: user_id)
    
    if user
      return link_to user.username, user_path(user_id)
    else
      return nil
    end
  end

  def link_upvote(work_id)
    work = Work.find_by(id: work_id)

    if work
      return link_to "↑", work_upvote_path(work.id), method: :post, class: "vote-link upvote"
    else
      return nil
    end
  end

  def link_downvote(work_id)
    work = Work.find_by(id: work_id)

    if work
      return link_to "↓", work_downvote_path(work.id), method: :post, class: "vote-link downvote"
    else
      return nil
    end
  end

  def link_delete_upvote(vote_id)
    vote = Vote.find_by(id: vote_id)

    if vote
      return link_to "↑", vote_path(vote.id), method: :delete
    else
      return nil
    end
  end

  def link_delete_downvote(vote_id)
    vote = Vote.find_by(id: vote_id)

    if vote
      return link_to "↓", vote_path(vote.id), method: :delete
    else
      return nil
    end
  end

  def link_change_upvote(vote)
    return link_to "↑", changevote_path(id: vote.id), method: :post
  end

  def link_change_downvote(vote)
    return link_to "↓", changevote_path(id: vote.id), method: :post
  end

  def link_edit_work(work_id)
    work = Work.find_by(id: work_id)

    if work
      return link_to "Edit #{work.title}", edit_work_path(work.id), class: "edit-link"
    else
      return nil
    end
  end

  def link_delete_work( work_id)
    work = Work.find_by(id: work_id)

    if work
      return link_to "Delete #{work.title}", work_path(work.id), method: :delete, data: { confirm: "Are you sure?" }, class: "delete-link"
    else
      return nil
    end
  end

  def link_edit_user(user_id)
    user = User.find_by(id: user_id)

    if user
      return link_to "Edit Account", edit_user_path(user.id), class: "edit-link"
    else
      return nil
    end
  end

  def link_delete_user(user_id)
    user = User.find_by(id: user_id)

    if user
      return link_to "Delete Account", user_path(user.id), method: :delete, data: { confirm: "Are you sure?" }, class: "delete-link"
    else
      return nil
    end
  end
  
end

