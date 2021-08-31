module Mentor
  class Discussion
    class FinishByMentor
      include Mandate

      initialize_with :discussion

      def call
        discussion.mentor_finished!

        notify!
      end

      def notify!
        User::Notification::Create.(
          discussion.student,
          :mentor_finished_discussion,
          { discussion: discussion }
        )
      end
    end
  end
end