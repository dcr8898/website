require "test_helper"

class Git::SyncPracticeExerciseTest < ActiveSupport::TestCase
  test "no change when git SHA matches HEAD SHA" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '302312cc-bd15-4ba0-8f2f-cbf411c40186', slug: 'hello-world', title: 'Hello World', git_sha: "HEAD", synced_to_git_sha: "HEAD" # rubocop:disable Layout/LineLength

    Git::SyncPracticeExercise.(exercise)

    refute exercise.changed?
  end

  test "git sync SHA changes to HEAD SHA when there are no changes" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '302312cc-bd15-4ba0-8f2f-cbf411c40186', slug: 'hello-world', title: 'Hello World', git_sha: "c5f6c9620528a2ec6c5f84146cda444926446997", synced_to_git_sha: "c5f6c9620528a2ec6c5f84146cda444926446997" # rubocop:disable Layout/LineLength
    create :track_concept, track: track, slug: 'strings', uuid: '8a3e23fd-aa42-42c3-9dbd-c26159fd6774'

    Git::SyncPracticeExercise.(exercise)

    assert_equal exercise.git.head_sha, exercise.synced_to_git_sha
  end

  test "git SHA and git sync SHA change to HEAD SHA when there are changes in config.json" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '302312cc-bd15-4ba0-8f2f-cbf411c40186', slug: 'hello-world', title: 'Hello World', git_sha: "bbe7435448f3617d457f4f75dcfad2fff9896fcf", synced_to_git_sha: "bbe7435448f3617d457f4f75dcfad2fff9896fcf" # rubocop:disable Layout/LineLength
    create :track_concept, track: track, slug: 'strings', uuid: '8a3e23fd-aa42-42c3-9dbd-c26159fd6774'

    Git::SyncPracticeExercise.(exercise)

    assert_equal exercise.git.head_sha, exercise.synced_to_git_sha
    assert_equal exercise.git.head_sha, exercise.git_sha
  end

  test "git SHA and git sync SHA change to HEAD SHA when there are changes in documentation files" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '302312cc-bd15-4ba0-8f2f-cbf411c40186', slug: 'hello-world', title: 'Hello World', git_sha: "42ab6f9d30e5a7edcd90f8f17d39cb27d8d74cb0", synced_to_git_sha: "42ab6f9d30e5a7edcd90f8f17d39cb27d8d74cb0" # rubocop:disable Layout/LineLength
    strings = create :track_concept, track: track, slug: 'strings', uuid: '8a3e23fd-aa42-42c3-9dbd-c26159fd6774'
    exercise.prerequisites << strings

    Git::SyncPracticeExercise.(exercise)

    assert_equal exercise.git.head_sha, exercise.synced_to_git_sha
    assert_equal exercise.git.head_sha, exercise.git_sha
  end

  test "git SHA and git sync SHA change to HEAD SHA when there are changes in track-specific files" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '302312cc-bd15-4ba0-8f2f-cbf411c40186', slug: 'hello-world', title: 'Hello World', git_sha: "ab0b9be3162f6ec4ed6d7c46b55a8bf2bd117ffb", synced_to_git_sha: "ab0b9be3162f6ec4ed6d7c46b55a8bf2bd117ffb" # rubocop:disable Layout/LineLength
    strings = create :track_concept, track: track, slug: 'strings', uuid: '8a3e23fd-aa42-42c3-9dbd-c26159fd6774'
    exercise.prerequisites << strings

    Git::SyncPracticeExercise.(exercise)

    assert_equal exercise.git.head_sha, exercise.synced_to_git_sha
    assert_equal exercise.git.head_sha, exercise.git_sha
  end

  test "metadata is updated when there are changes in config.json" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '302312cc-bd15-4ba0-8f2f-cbf411c40186', slug: 'hello-world', title: 'Hello World', git_sha: "bbe7435448f3617d457f4f75dcfad2fff9896fcf", synced_to_git_sha: "bbe7435448f3617d457f4f75dcfad2fff9896fcf" # rubocop:disable Layout/LineLength
    create :track_concept, track: track, slug: 'strings', uuid: '8a3e23fd-aa42-42c3-9dbd-c26159fd6774'

    Git::SyncPracticeExercise.(exercise)

    assert_equal "Hello World!", exercise.title
  end

  test "adds new prerequisites defined in config.json" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '302312cc-bd15-4ba0-8f2f-cbf411c40186', slug: 'hello-world', title: 'Hello World', git_sha: "dc8071dd51a031fdcefafe3c383c18d4f6630522", synced_to_git_sha: "dc8071dd51a031fdcefafe3c383c18d4f6630522" # rubocop:disable Layout/LineLength
    strings = create :track_concept, track: track, slug: 'strings', uuid: '8a3e23fd-aa42-42c3-9dbd-c26159fd6774'

    Git::SyncPracticeExercise.(exercise)

    assert_includes exercise.prerequisites, strings
  end

  test "removes prerequisites that are not in config.json" do
    track = create :track, slug: 'fsharp'
    exercise = create :practice_exercise, track: track, uuid: '2ee3cc7a-db3f-4668-9983-ed6d0fea95d1', slug: 'two-fer', title: 'Two Fer', git_sha: "e74f6457b4c872a254830ae8f002164c2235259a", synced_to_git_sha: "e74f6457b4c872a254830ae8f002164c2235259a" # rubocop:disable Layout/LineLength
    strings = create :track_concept, track: track, slug: 'strings', uuid: '8a3e23fd-aa42-42c3-9dbd-c26159fd6774'
    conditionals = create :track_concept, track: track, slug: 'conditionals', uuid: '2d2c2485-7655-40f0-9bd2-476fc322e67f'
    exercise.prerequisites << strings
    exercise.prerequisites << conditionals

    Git::SyncPracticeExercise.(exercise)

    refute_includes exercise.prerequisites, conditionals
  end
end