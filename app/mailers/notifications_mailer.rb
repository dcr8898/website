class NotificationsMailer < ApplicationMailer
  def mentor_started_discussion
    notification = params[:notification]
    @user = notification.user
    @discussion = notification.discussion
    @exercise = @discussion.exercise
    @track = @exercise.track

    @unsubscribe_key = :email_on_mentor_started_discussion_notification
    @title = "Your solution is being mentored"
    subject = "#{@discussion.mentor.handle} has started mentoring you on #{@track.title}/#{@exercise.title}"
    mail_to_user(@user, subject)
  end

  def mentor_replied_to_discussion
    notification = params[:notification]
    @user = notification.user
    @discussion = notification.discussion
    @exercise = @discussion.exercise
    @track = @exercise.track

    @unsubscribe_key = :email_on_mentor_replied_to_discussion_notification
    @title = "Your mentor has replied"
    subject = "#{@discussion.mentor.handle} has commented in your discussion on #{@track.title}/#{@exercise.title}"
    mail_to_user(@user, subject)
  end

  def student_replied_to_discussion
    notification = params[:notification]
    @user = notification.user
    @discussion = notification.discussion
    @exercise = @discussion.exercise
    @track = @exercise.track

    @unsubscribe_key = :email_on_student_replied_to_discussion_notification
    @title = "Your student has replied"
    subject = "[Mentoring] #{@discussion.student.handle} has commented in your discussion on #{@track.title}/#{@exercise.title}" # rubocop:disable Layout/LineLength
    mail_to_user(@user, subject)
  end

  def student_finished_discussion
    notification = params[:notification]
    @user = notification.user
    @discussion = notification.discussion
    @exercise = @discussion.exercise
    @track = @exercise.track

    @unsubscribe_key = :email_on_student_finished_discussion_notification
    @title = "Your student has finished the discussion"
    subject = "[Mentoring] #{@discussion.student.handle} has finished the discussion on the solution you are mentoring for #{@track.title}/#{@exercise.title}" # rubocop:disable Layout/LineLength
    mail_to_user(@user, subject)
  end

  def mentor_finished_discussion
    notification = params[:notification]
    @user = notification.user
    @discussion = notification.discussion
    @exercise = @discussion.exercise
    @track = @exercise.track

    @unsubscribe_key = :email_on_mentor_finished_discussion_notification
    @title = "Your mentor has finished the discussion"
    subject = "[Mentoring] #{@discussion.mentor.handle} has finished the discussion on your solution for #{@track.title}/#{@exercise.title}" # rubocop:disable Layout/LineLength
    mail_to_user(@user, subject)
  end
end
